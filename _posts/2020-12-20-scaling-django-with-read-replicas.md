---
title: "Scaling Django with Postgres Read Replicas"
tagline: Scale Database Reads Linearly While Maintaining Consistency
date: 2020-12-13
author: Andrew
layout: post
permalink: /python/scaling-django-with-postgres-read-replicas/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - PostgreSQL
  - Python
  - Databases
  - Django
image:
  feature: prague.jpg
manual_newsletter: false
---
Replication is a feature of PostgreSQL that you typically use to achieve high availability, by running copies of a database that are ready to take over if your primary database fails. However, you can also use replication to make your Django applications faster. In this post, I'll explain how to configure Django to query read-only Postgres replicas, allowing you to scale your database read performance linearly with the number of replicas.

I'll also talk about how reading from replicas can go wrong -- specifically, I'll detail the consistency errors that *replication lag* can cause -- and the tools that Django gives you to work with this problem.

## What is Replication?

With replication, you run a cluster of Postgres database instances: a leader, also called a "primary," database, and multiple "replicas." All write queries execute on the leader, making it the trusted source of your data, and the replicas continuously copy changes from the leader to keep themselves up to date. Replicas not only give you the superpower to failover to a replica if the leader crashes, which is known as high availability -- they also let you scale reads across all replicas and the leader.

Put a different way: by configuring Django to query replicas, you can _scale performance linearly_ by adding replicas. So, in theory, you'll get 2x performance by adding two replicas, 4x performance with four, and so on.

**Read-only replica or hot standby?** With Postgres, replicas usually don't allow queries of any kind -- replicas are only there for failover. However, you can configure replicas to run in "hot standby" mode, which allows them to service read-only queries. Another term for hot standby replicas is "read-only replicas," or "read replicas," which is how this post will refer to them.

## Configuring Replication in Postgres

Configuring replication in Postgres is a _project_. However, if you study the `postgres_leader` and `postgres_follower` directories in my [example Django project](https://github.com/abrookins/quest/tree/read-replicas), you can see what's required. Postgres also has [extensive documentation](https://www.postgresql.org/docs/12/high-availability.html) on replication.

However, most managed database services offer replication as a feature that you can click to enable. If you want to test replication without configuring it yourself, try DigitalOcean's [Managed Databases product](https://m.do.co/c/e061bdbde6da).


## Configuring Multiple Databases in Django

From this point on, I'm going to assume that you have a Postgres cluster with a primary database and at least one replica running somewhere -- either a cluster you configured yourself, my example Django project running via Docker, or a managed database service.

Your next step is to configure Django so that it knows about your replicas. The goal here is for the primary to handle write queries, while your replicas handle reads.

The first thing you'll do is add the replicas to the `DATABASES` setting. Here is what my example app looks like -- note that this example uses a single replica:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'quest',
        'USER': 'quest',
        'PASSWORD': DATABASE_PASSWORD,
        'HOST': PRIMARY_HOST
    },
    'replica': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'quest',
        'USER': 'quest',
        'PASSWORD': DATABASE_PASSWORD,
        'HOST': REPLICA_HOST
    }
}

```

As you can see, I store the primary database under the "default" key and the replica under the "replica" key. If I did nothing else, Django would have no idea what to do with the replica: it wouldn't use that database, and would continue to use the default database for all queries.

To inform Django of the presence of the replica and direct all read queries to it, we need to create a `router`. This one is adapted from the Django docs:

```python
class PrimaryReplicaRouter:
    """
    An example primary/replica router adapted from:
    https://docs.djangoproject.com/en/3.1/topics/db/multi-db/
    """
    def db_for_read(self, model, **hints):
        """
        Reads go to the replica.
        """
        return 'replica'

    def db_for_write(self, model, **hints):
        """
        Writes always go to primary.
        """
        return 'default'

    def allow_relation(self, obj1, obj2, **hints):
        """
        Relations between objects are allowed if both objects are
        in the primary/replica pool.
        """
        db_set = {'default', 'replica'}
        if obj1._state.db in db_set and obj2._state.db in db_set:
            return True
        return None

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        return True

```

**Note**: If you have more than one replica, your `db_for_read()` method should instead randomly choose a replica, as the example in the Django docs does: `return random.choice(['replica1', 'replica2'])`.

## How to Confirm that Replication is Working

To confirm replication is working, connect to the primary node and run this SQL query.

```
quest=# select * from pg_stat_replication;
-[ RECORD 1 ]----+------------------------------
pid              | 35
usesysid         | 16385
usename          | rep
application_name | walreceiver
client_addr      | 172.18.0.2
client_hostname  |
client_port      | 54096
backend_start    | 2020-12-14 19:56:09.100272+00
backend_xmin     |
state            | streaming
sent_lsn         | 0/29019160
write_lsn        | 0/29019160
flush_lsn        | 0/29019160
replay_lsn       | 0/29019160
write_lag        |
flush_lag        |
replay_lag       |
sync_priority    | 0
sync_state       | async
reply_time       | 2020-12-14 20:19:12.147809+00

```

You can also connect to a replica using Django and check that your data is there:

```
./manage.py dbshell --database replica

```

In addition to these techniques, Postgres's logging output also indicates replication activity.

## Running Tests When Replication Is Active

There seems to be no way to properly run unit tests with Django if you've configured read-only replicas, so you'll need to disable the replica configuration while running tests.

You are supposed to be able to mark a database as a ["test mirror"](https://docs.djangoproject.com/en/3.1/topics/testing/advanced/#testing-primary-replica-configurations), but this appears [not to work](https://code.djangoproject.com/ticket/23718).

My advice is to use settings inheritance to create a `test_settings.py` file that only contains the primary database and excludes your custom router:

```python
from quest.settings import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'quest',
        'USER': 'quest',
        'PASSWORD': DATABASE_PASSWORD,
        'HOST': PRIMARY_HOST
    }
}

DATABASE_ROUTERS = []

```

## So, What Could Go Wrong? (Answer: Replication Lag)

We have now covered most of the material on working with read-only replicas that you can find in the Django documentation -- and, incidentally, most web tutorials on this topic written from a Django perspective. So, what could go wrong?

The problem with reading from replicas is that replication really needs to be _asynchronous_ to perform well. What does that mean? The primary database doesn't wait until all replicas are synchronized before telling you that your write is complete.

And that can lead to many kinds of reality distortion, as we shall see. The Django docs mention this, but unless you already practice the Dark Arts the warning might sound like gibberish:

> The primary/replica [configuration] doesn’t provide any solution for handling replication lag (i.e., query inconsistencies introduced because of the time taken for a write to propagate to the replicas).

The "inconsistencies" that this paragraph mentions are, in concrete terms, usually failures of *read-your-writes* consistency or *monotonic reads* consistency.

### Failing to Guarantee Read-Your-Writes Consistency

Consider this unfortunate timeline of events from an ecommerce site:

* I fill out a form adding a new Star Wars lightsaber to my wishlist
* Django routes my wishlist write query to the primary database
* The primary writes my data to disk (actually more complicated -- but that's for another day)
* Django redirects me to a page showing my wishlist
* Django routes my wishlist read query to a replica
* There is no fucking lightsaber, what happened?
* 0.2 seconds later: the replica gets the update with my lightsaber
* I add the lightsaber to my wishlist again
* Now I have two lightsabers - what's wrong with this stupid web site??

This is an example of an application that fails to provide read-your-writes consistency. That is, the application can't ensure that users will be able to read their own writes to the database -- due to replication lag, they may not see the data immediately after writing it.

### Failing to Guarantee Monotonic Reads Consistency

Next, consider this example from a self-help forum for the aforementioned lightsaber web site:

* I visit a page forum page titled "Help adding items to my wishlist"
* I scroll past the instructions and read the comments
* The comments are in order from oldest to newest
* The first comment reads, "Answer: There's nothing wrong with the site ya geezer"
* The second comment reads, "Question: What's up with the site today - I keep getting duplicates in my wishlist??"

This is an example of a failure to provide monotonic reads consistency. In other words, the application might show us database writes *out of order*. This can happen if Django routes queries to multiple replicas, and the replicas are in different states of synchronizing data from the leader.

## Solving Consistency Problems Caused By Replication Lag

This all may sound truly dreadful ("consistency guarantees" -- ugh!), and the truth is that it is, so you should ask yourself:

>Will users actually care if they see this data out of order, or fail to see new data immediately?

If neither matters all that much, then don't worry about it. And it may only matter *sometimes* -- in some areas of your application.

Assuming it does matter, what can you do about these two kinds of failures with Django?

### Guaranteeing Read-Your-Writes Consistency

The simplest solution to guarantee users always see their own writes is to route reads of models that users edit to the primary database -- and send all other reads to the replicas.

```python
class PrimaryReplicaRouter:
    def db_for_read(self, model, **hints):
        # Imagine that UserProfile is the only user-
        # editable model in this application.
        if model is UserProfile:
            return 'primary'
        return 'replica'

```

Because you get a type object for the `model` argument to the `db_for_read()` method, you could probably introduce a [proxy model](https://docs.djangoproject.com/en/3.1/topics/db/models/#proxy-models) that you use when a user views their own data.

For example, you might use a proxy model for the `UserProfile` model called `UsersOwnProfile`. When a user views their profile, your app queries the database with the `UsersOwnProfile` class, but when a user views other profiles, the app queries with the `UserProfile` class.

Then you could do something like this in your custom database router:

```python
class PrimaryReplicaRouter:
    def db_for_read(self, model, **hints):
        # A user always reads their own profile from the leader
        if model is UsersOwnProfile:
            return 'primary'

        # Other user profiles -- and all other data -- come from a replica.
        return 'replica'

```

The more general you want to guarantee read-your-writes consistency, the darker the sorcery becomes. For example, another approach is to [keep track of the replication status of replicas](https://brandur.org/postgres-reads).

### Guaranteeing Monotonic Reads Consistency

One way to guarantee that users see database writes in a consistent order is to always direct their reads to the same replica. How would you do this with Django? You'll need three things:

* A middleware function that makes the user ID accessible to the database router
* A database router that reads the user ID if it's present and returns the correct replica for that user
* A hash function that will consistently assign a user ID to the same "bucket" (replica)

First, let's examine the middleware. Consider this example, which uses thread local storage to store the user's ID:

```python
import threading

request_config = threading.local()


class RouterMiddleware(object):
    def process_view(self, request, view_func, *args, **kwargs):
        if request.is_authenticated():
            request_config.user_id = request.user.id

    def process_response(self, request, response):
        if hasattr(request_config, 'user_id'):
            del request_config.user_id
        return response

```

So, when a logged-in user accesses the Django application, this middleware saves their ID in a thread-local variable.

When (and if) Django issues a database query for this user, the database router will look for that ID and, if it's present, use a consistent hashing function to assign that ID to a replica.

That following example does just this -- note that it expects two replicas defined in the `DATABASES` setting: "replica1" and "replica1".

```python
import random

import mmh3

from quest.middleware.router_middleware import request_config


REPLICAS = ['replica1', 'replica2']


def hash_to_bucket(user_id, num_buckets):
    """Consistently hash `user_id` into one of `num_buckets` buckets.

    Approach derived from: https://stats.stackexchange.com/questions/26344/how-to-uniformly-project-a-hash-to-a-fixed-number-of-buckets
    """
    i = mmh3.hash128(str(user_id))
    p = i / float(2**128)
    for j in range(0, num_buckets):
        if j/float(num_buckets) <= p and (j+1)/float(num_buckets) > p:
            return j+1
    return num_buckets


class HashingPrimaryReplicaRouter:
    def db_for_read(self, model, **hints):
        """Consistently direct reads of authenticated users to the same replica."""
        user_id = getattr(request_config, 'user_id', None)
        if user_id:
            bucket = hash_to_bucket(user_id)
            return REPLICAS[bucket]

        # Anonymous users get a random replica.
        return random.choice(REPLICAS)

```

To read more about replication and consistency problems, check out Chapter 5 of [Designing Data-Intensive Applications](https://amzn.to/34dWtWJ) by Martin Kleppmann, which directly informed this section.

## One More Thing: Controlling Consistency Per Transaction with synchronous_commit

Is your mind melting yet?

No?

Then let's talk about "one more thing." With Postgres, you have another tool to maintain consistency when it matters and prefer speed when consistency is less important: the `synchronous_commit` setting.

[Entire articles](https://www.compose.com/articles/postgresql-and-per-connection-write-consistency-settings/) have been written on this setting. The gist of it is that you can control write consistency at the level of individual transactions (and not just transactions -- also sessions, users, databases, and instances!).

My recommendation is to configure Postgres so that replication is asynchronous by default, but such that you can turn on synchronous commits when you need them. The following settings accomplish this:

```
    synchronous_commit = local
    synchronous_standby_names='*'

```

Setting `synchronous_commit` to "local" ensures that Postgres returns a successful commit after the primary database flushes the change to disk, but before any replicas have done so. _However_, we also set `synchronous_standby_names` to "*", meaning all replicas are considered synchronous.

This state of affairs, while seemingly contradictory, means that commits won't wait for replicas unless we explicitly turn on synchronous commits. With Django, doing that within a transaction looks like the following:

```python
# Make sure Postgres confirms writes to replicas before it considers
# this transaction complete.
with transaction.atomic():
    with connection.cursor() as cursor:
        cursor.execute("SET LOCAL synchronous_commit TO remote_apply;")
        Event.objects.create(name="task_created", data=serializer.data,
                            user=self.request.user)

```

For the single transaction in this example, Postgres will require confirmation that all replicas have applied the change before considering the transaction successful. So, you can be sure that users will see their writes, _and_ that writes will appear in the correct order, when those things matter.

## Summary

Querying replicas is a great way to scale your read performance, and you can use a variety of techniques to manage consistency from the application side.

With a little elbow grease, you can also control write consistency on individual transactions with Postgres!

---

Photograph by Fabrizio Verrecchia.
