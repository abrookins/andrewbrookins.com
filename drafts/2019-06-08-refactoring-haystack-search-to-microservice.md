---
title: Refactoring Search in a Django App from Haystack to Microservice
date: 2019-06-08
author: Andrew
layout: post
permalink: /technology/refactoring-search-in-a-django-app-from-haystack-to-microservice/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Django
  - Python
  - Haystack
  - Solr
  - Search
image:
  feature: cables.jpg
manual_newsletter: true
---

This post explains the technical choices my team made while refactoring a search feature from a component within a monolithic Django project into a microservice a couple of projects back. It explores our efforts to break dependence on a shared database, use central authentication and plan for redundancy, among other things.

### Why a Microservice?

Some areas of the monolithic Django application in question suffered more from long cycles of development and deployment than others. Search was one of the slow-boaters. If you had to tackle even a medium-sized search feature — or, heck, fix a search bug, since they often required reloading the search index (AKA, “reindexing”) — you might lose an entire sprint. Coordinating the release of a search feature could be difficult, as it required close work with our QA team to get new code onto a QA machine and reindex, a process that often blocked other QA work.

## Indexing: before and after

Our first task was to discover all of the logic hiding in the nooks and crannies of our existing search code You know how it is — there’s always some file that contains the critical thing that makes every other piece work correctly.

At a high level, there appeared to be two major zones of search code in the monolith: the first was indexing, and the second was handling user searches. Indexing seemed like the more complicated area, so we tackled it first.

### Could We Reuse Our Haystack Code?

The monolith used a library called Haystack to convert data from its database into XML documents that it sent to Solr. `SearchIndex` classes handled these transformations. These index classes were a mix of declarative and imperative code that defined exactly how to transform a Django model instance to data ready to send to Solr as XML. The indexing code layered on top of the monolith’s database models and referenced them explicitly. You can see how Haystack’s `SearchIndex` works by looking at this example from the library’s documentation:

```python
import datetime
from haystack import indexes
from myapp.models import Note


class NoteIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)
    author = indexes.CharField(model_attr='user')
    pub_date = indexes.DateTimeField(model_attr='pub_date')

    def get_model(self):
        return Note

    def index_queryset(self, using=None):
        """Used when the entire index for model is updated."""
        return self.get_model().objects.filter(pub_date__lte=datetime.datetime.now())
```

We had a set of classes like this in our monolith that wrapped our content models (e.g., book, chapter, video and video clip). Except, of course, they were much larger than the example and performed many more operations to transform a model into a Solr document.

We had already split both the search features and the core platform models into separate Django “apps” or components. This meant that a developer could build search component features by checking out the search component, writing code, and running just that component’s tests. However, the search component was tightly coupled to the data models it shared with the rest of the monolith, so, while it was nice that as a developer you could run tests independently of the monolith, at a certain point you had to integrate new versions of your code with the monolith, which meant installing your version of the component into a local build of the monolith and writing tests that proved that the integration worked.

This is a typical situation in large Django projects, and we do it all the time. Still, especially with search, we had noticed that all of these bare wires tended to entangle and electrocute hapless developers, so we hoped that microservices could lead us to a slightly better system.

### A Path to the Dark Side

Now, we could have pulled the index classes out of the monolith (specifically, the search component that it used) and copied them into a new repository. We would have needed the shared data models and a connection to the monolith’s database as a dependency. We probably would have ended up with a Celery task that ran asynchronously to pull content directly from the production database and put it into a Solr instance.

Retaining the coupling between search and the database would have meant that when a developer working on a monolith feature migrated the shared database, the change could have broken the search microservice. We would need to coordinate migrations of the shared database to make sure that all search nodes were using the latest version of the schema through the shared data models. This path sounded like it led to the dark side. In fact, Chapter 4 of [[Building Microservices]] has a whole section dedicated to convincing people to avoid doing exactly this. We didn’t want a new flavor of entanglement. We wanted to go fast. But what was the alternative?

We looked at whether we could continue to use our Haystack index classes, but point them at something other than a Django model. Could we build some kind of facade that pulled data from a REST API, but reused all of the code we had embedded in the index classes? After studying Haystack, we concluded that this was probably not possible.

### Indexing from a REST API
Despite this problem, the best alternative to building a distributed monolith that we came up with was to rebuild the indexing code, such that instead of pointing at the database to get search content, it pointed at a higher-level interface — the monolith’s REST API. This API served content to our iOS and Android applications, and it included everything that we needed for indexing.
But if we ditched Haystack, what would we lose? It turned out that a significant amount of business logic lived in our Haystack index classes.
As we already discussed, the purpose of that code was to transform a Django model into an XML document (or many documents) that lived in Solr’s index. We wondered if there was something else that we could use for this job that was a natural fit if we pulled content from a REST API for indexing. Since we had already planned on using [[Django Rest Framework]] (DRF), that library’s “serializer” classes seemed like they could work — we could validate and deserialize API responses, perform transformations on the result, and then send the validated and transformed data to Solr using the `pysolr` library directly, instead of Haystack.
We ended up taking this approach. It’s not perfect: now instead of depending on a library meant to transform Django model instances into documents in a search engine, we’re dependent on a REST API framework and a lower-level Solr library (`pysolr`). However, we don’t need a shared database. The input data can come from any source, whether that’s a REST API now or an AMPQ message body later (who knows?).
In most cases, converting logic from a Haystack index class to a DRF serializer was straightforward. Instead of a model object, the input was a JSON document. In both cases, the output (with the help of `pysolr`) was an XML document prepared for Solr, that matched the fields in its index definition.
### But how do we know when to index new documents?
In the monolith, we indexed new documents into Solr as one step of an asynchronous workflow that constantly pulled new content from an upstream API and broke it up for storage in the monolith’s database. We wanted to continue to make new content available in search as soon as it was available in the monolith. Since we were already beginning to use Celery for asynchronous tasks in the microservice, and another team had recently added code that sent an AMPQ message when new content arrived in the monolith (not using Celery), we built a Celery `ConsumerStep` to consume these messages. When the microservice received a message that the monolith had added a new title or removed a title, it spawned a new asynchronous task that eventually indexed that content from the monolith’s REST API. The code for the “book was added” consumer looked like this:
'' import logging
''
'' from celery import Celery
'' from celery import bootsteps
''
'' from django.conf import settings
'' from kombu import Consumer, Exchange, Queue
''
'' from indexer import tasks
''
'' exchange = Exchange(settings.EVENT_EXCHANGE, type='topic')
''
'' content_ingestion_queue = Queue(settings.CONTENT_INGESTION_QUEUE, exchange=exchange, routing_key=settings.CONTENT_ROUTING_KEY)
''
'' app = Celery('consumers', broker=settings.EVENT_BROKER)
'' log = logging.getLogger(__name__)
''
''
'' class IngestionConsumerStep(bootsteps.ConsumerStep):
''     def get_consumers(self, channel):
''         return [Consumer(channel,
''                          queues=[content_ingestion_queue],
''                          callbacks=[self.handle_message],
''                          accept=['json'])]
''
''     def handle_message(self, body, message):
''         log.info("Received content update message: {0!r}".format(body))
''         if 'identifier' in body:
''             tasks.index_book.delay(body['identifier'])
''         else:
''             log.warn("Ignored content update message because it lacked an identifier")
''         message.ack()
''
'' app.steps['consumer'].add(DeletionConsumerStep)
But because we (I) did not trust messages completely, we also built a “catchup” task that ran occasionally to reconcile the Solr index with the total set of titles in the monolith, pruning or adding any for which the microservice had missed an update or remove operation.
This approach has been good enough for now, but it takes way too long to reindex from an empty collection (i.e., a full reindex) — usually about two days. Because the reindexing process involves spawning thousands of tasks that make sometimes hundreds of API calls each, we think that the speed will improve with a threaded or `asyncio` approach rather than the purely multi-process concurrency that we get now, running several Celery workers. I look forward to trying that optimization.
### So many unnecessary bugs
I carried over much of the Solr index schema from our existing search code (by which I mean the XML definition of the fields stored in the Solr index, not the Haystack index classes), which saved a lot of time and preserved much of our past search work. However, in my haste to stake a boundary around the new search microservice, I changed several fields that appeared to have inherited their names directly from fields in the production database, but for which there were clearer names. I also pluralized any field name that was singular but represented a multi-value field in Solr, to avoid confusion. I meticulously used find-and-replace to change all of these names across the Solr field configuration and schema, except *where I didn’t*.
My error while executing the seemingly trivial job of replacing text across multiple files, for which I used the finest tools available, became a whole class of error conditions  that our whole team dealt with on and off over the next few months. And then after we had finally nailed down the last missing rename operation and had done *another reindex* to get those values stored correctly, we received reports that our replacement search page mishandled some bookmarked searches. Searches that referenced the field names that I had changed directly in an “advanced search” capacity did not work. I had not known that people used the field names directly in search queries, or that someone wanted the new search form to preserve people’s bookmarked searches. We finally added a layer of aliases to the API that would accept both the old and new field names as input.
Overall, it was a costly find-and-replace!
## Searching: before and after
Users can search the latest version of Safari, which is what I work on, in a few places: the search box at the top of the web site, the web site’s `/search` page, the web site’s “search inside the book” tool, the iOS app and the Android app.
In the monolith, we used “form” classes derived from Haystack’s `SearchForm` class to handle all of these cases (except the Android Queue app, which was in beta at the time that we built the microservice and did not yet have a search interface). Here is an example of a `SearchForm` from the Haystack [[documentation]]:
'' from django import forms
'' from haystack.forms import SearchForm
''
''
'' class DateRangeSearchForm(SearchForm):
''     start_date = forms.DateField(required=False)
''     end_date = forms.DateField(required=False)
''
''     def search(self):
''         # First, store the SearchQuerySet received from other processing.
''         sqs = super(DateRangeSearchForm, self).search()
''
''         if not self.is_valid():
''             return self.no_query_found()
''
''         # Check to see if a start_date was chosen.
''         if self.cleaned_data['start_date']:
''             sqs = sqs.filter(pub_date__gte=self.cleaned_data['start_date'])
''
''         # Check to see if an end_date was chosen.
''         if self.cleaned_data['end_date']:
''             sqs = sqs.filter(pub_date__lte=self.cleaned_data['end_date'])
''
''         return sqs
On the web site, we used a form class to render the search-specific parts of the search page and “search inside the book” tool. Users visiting the site could adjust the inputs on the rendered form to build query parameters, and when they submitted it, we used JavaScript to make an AJAX request to an HTTP endpoint that used our form class to validate the user’s input and make the Solr query. Then we rendered the result of the query with a Django template and returned the rendered HTML. Our JavaScript replaced the search content element on the page with the new rendered response from the server.
The monolith’s mobile search API also used the form classes.  It would receive POST parameters that needed to map to the inputs on the search form. Then it used the form class to validate the POST and returned the results as JSON instead of rendering them as HTML.

### Scope creeping ourselves
Retrieving partially-rendered HTML responses from a server via AJAX requests is a well-used pattern in web development, but now that we had decided to jettison Haystack in our attempt to create a service boundary (i.e., no shared database), we had to make a difficult choice. Without Haystack, we would either need to build an endpoint in the monolith that called out to the new microservice, rendered the HTML and returned that to the JavaScript front-end exactly as it had appeared before, or we would need to change the front-end so that it rendered HTML in the browser using the microservice’s JSON responses.
After I talked to one of our front-end engineers about the problem, he felt excited about rewriting the search page so that it consumed JSON directly. So, we grew the scope of the project, not realizing how much time a front-end rewrite of the search page would add. We worked on the new form in piecemeal over several weeks when we could, and eventually we deployed it hidden behind a flag. QA would try it once a sprint or so, file a list of problems that blocked us from turning it on, and disable it. Once again, when we had time, we would work on those tickets and restart the process. We’ve done a lot of navel-gazing since then about how to avoid this particular wheel of suffering.
Next time, I hope we accept more risk that new code may have problems, and that we’ll stick a couple of people on a feature until it’s done. Or that we scale back our ambitions, knowing what we know now.
### Search in the microservice
Anyway, back to the technical side of things. We looked at the job that the Haystack form classes were doing in the monolith and found that they had two primary roles: validating user input and building a Solr query based on the validated input.
The last responsibility seemed to produce most of the code in our repository, as the form classes built a query by passing validated user input through various branches, to arrive, finally, at a Solr query. The classes then performed the search using `pysolr` behind the scenes, and returned the results inside a wrapper object.
With the new microservice, we decided to accept search parameters the same way, via GET or POST, and validate them against a DRF serializer. Pretty typical stuff. DRF serializers are great at expressing a schema for input validation. It then seemed straightforward to add a helper method to the serializer that built a query from the validated input, and simply returned the built query string.
We ended up with an API endpoint in Django that received HTTP requests, validated the input against a serializer, then asked the serializer for a Solr query based on the input. The API view then sent this query to Solr using `pysolr` and returned the results as JSON.
### Mixing responsibilities
As with our use of serializers to replace Haystack index classes, we mixed the responsibility for validation with something else (validation and transformation in the indexing case, validation and query building in the searching case). More than once I have looked askance at this code after writing it. I suspect that the sentiment is shared by other people. Maybe someday we’ll compose these responsibilities into a new set of objects (suppose an `Index` like Haystack’s but without database dependence, and a `QueryBuilder` for the search API). Or, we we might separate the responsibilities completely and build pipelines (validation, transformation, Solr update for indexing; validation, query building, Solr search for searching).
The most important goal that we had was to draw a boundary around search that excluded the main production database, rather than shared it. We accomplished that goal. Now we have room to make improvements.
### Authentication
Our first plan was to deploy the microservice without any authentication and see if we felt the need to add it later. However, we had to switch gears when the company decided to use the microservice to serve public requests made by partners.
Opening the search API up to public/external search requests meant that we would need to satisfy an internal set of requirements for all public APIs, of which this would be the first. That list included rate-limiting, which is based on the notion of identity, so we would need a way to authenticate clients after all.
Our monolithic search endpoints all relied on either session or oAuth authentication, both of which referred to user data stored in the monolith’s database. But, the new microservice didn’t have access to this anymore.
We thought that the fastest thing might be to add token-based authentication. That would have required us to build a separate repository of credential information inside the microservice, when we already had a system containing that information: the monolith. It also wouldn’t have worked for mobile app users, whose oAuth tokens were tracked through the monolith.
Instead of doing using token auth, we made another hard decision that added complexity to the project — to build in central authentication. We worked with other engineers who had begun experimenting with central authentication middleware that could authenticate users of a microservice through network requests to the monolith.
### Too much latency
The code for the central authentication middleware was pretty straightforward. It copied an inbound request (after slimming down headers) to the microservice as a new outbound request to the monolith, with any authentication headers intact, and built a user facade from data in the response. Smart caching reduced the number of redundant requests for subsequent searches by the same user. It looked good (and props to the engineers who worked on it), so we incorporated it into the microservice.
Meanwhile, we housed the microservice URL under our main site, using our top-level domain as an [[API gateway]]. We proxied requests to the path `/api/v2/search/` to a load balancer that distributed work among a pool of nodes running the microservice’s search API.
We turned on rate-throttling with central authentication and it worked. So cool! Now we could authenticate partners with an auth token (stored in the monolith, associated with their account information), people using the JavaScript front-end, and people using our iOS and Android applications. Perfect.
A problem dogged us, though: we began seeing high latency on authentication requests. The latency was so high, in fact, that requests were timing out.
### Authentication timeouts
The timeouts were happening in our authentication calls to the monolith. New Relic showed clear, occasional spikes from that call, too.
But they were not *always* timing out, and we couldn’t reproduce the problem with `curl`. We worked with IT to switch the URL that we used to one that did not travel through our CDN, but the problem resurfaced. We had also gradually raised the timeout value from milliseconds until we were timing out after ten seconds. We had a serious problem, and yet New Relic had no record of these slow responses from the monolith’s side.
After a few deep dives into the problem, we narrowed it down to POSTs only, which led us to consider the headers coming in on the requests. We captured and replayed a problematic request, rebuilding it by hand one header at a time and sending it to the microservice with `curl`, until we found the issue, which in retrospect was obvious: our authentication middleware was copying over the `Content-Length` header from an inbound POST request to an outbound GET request with no body. This caused a server on the other end to stall indefinitely, waiting for input that never arrived.
Computers! Why do they always do exactly what you tell them?

## Redundancy: before and after
Previously we had one running Solr instance and two collections. The monolith pointed updates and searches at the current collection, and did nothing with the “off” collection. When we had to perform full reindexes of content, we reindexed into the “off” collection, and when the reindex finished, we changed the collection that the app nodes pointed at. This was reasonably simple, but there was one problem — we only ever had a single Solr instance primed. If that server ever failed, search on the site and in all mobile apps would go down until we could recover (point of order: I don’t remember this ever happening).
In designing the microservice, we wanted to continue to have zero-downtime reindexes while also gaining more redundancy, so that a single search server could fail and search would continue to work.
### Our DIY topology
SolrCloud looked appropriate for our use case, but at the same time, we were trying to move fast and it looked complicated (ZooKeeper…?). Solr supports replication, so with our eye on using SolrCloud in the future, we built out a topology that included a master “indexer” Solr instance, which received all index updates that we generated in response to messages that the monolith had added content, but served no search requests; and two Solr “searcher” nodes whose indexes constantly replicated from the indexer and which served all search requests. Our application nodes pointed at the searchers and were load-balanced such that both Solr instances handled search traffic.
### Two machines exactly the same, but one underperformer?
We deployed the two nodes with different VM specifications, but on the first day that the microservice received heavy traffic, one search server strongly underperformed when compared to the other. We beefed up the underperformer, only to discover that even with specifications that matched its twin, it continued to underperform.
The only other difference we found was that the slower machine was chewing on disk IO constantly, whereas the fast node barely touched it. With some inspection of the processes running on the slower machine, we found that it had been consuming update messages bound for the indexer and updating its index with new content — constantly — while it also replicated from the indexer. We followed the trail back to Chef, where we found that we had left a “recipe” configured for one of the searcher nodes that set it up as Celery worker, pulling indexing tasks. It’s amazing how much heartache a typo can cause.
Another post-launch issue that gave me the sweats but stabilized quickly was that with two Solr instances serving search requests there were, of course, two query caches. This meant that after we reindexed, the search API took longer than we expected to reach a sub-400 millisecond average response time.
## In closing
Microservices are all fun and games until someone asks you to refactor part of a monolith. And yet, if you subscribe to the [[Monolith First]] strategy, that is how you’ll spend most of your time building microservices!
Seriously, though, I learned a lot working on this project, and I’m glad that Safari asked me to work on it. I made more mistakes than I am happy with, so I hope that by describing all of them in painful detail, I will help someone (perhaps you?) avoid some small amount of pain in the future.
