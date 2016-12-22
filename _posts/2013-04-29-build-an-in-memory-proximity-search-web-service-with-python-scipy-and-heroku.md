---
id: 924
title: Build an In-Memory Proximity Search Web Service with Python, SciPy and Heroku
date: 2013-04-29T08:53:57+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=924
permalink: /tech/build-an-in-memory-proximity-search-web-service-with-python-scipy-and-heroku/
aktt_notify_twitter:
  - 'no'
categories:
  - Python
  - Technology
---
In this post I&#8217;m going to look at a concrete example of building an in-memory proximity (aka, nearest neighbor) search web service using Python, SciPy and Heroku.

Later we can speculate on use cases for this approach as opposed to a geo-aware database.

# <span id="Define_Our_Terms">Define Our Terms</span>

So, let&#8217;s define our terms:

  * In-memory: The web service process contains the data we will query.
  * Proximity search: Given a latitude/longitude coordinate, return a set of results within a fixed distance from that location. Also called nearest neighbor search, closest point search, etc. I prefer &#8220;proximity search.&#8221;
  * Web service: This will be a JSON web service.
  * Python: We&#8217;ll use Python 2.7.
  * SciPy: We&#8217;ll use a C component of SciPy to do the search, namely `scipy.spatial.cKDTree`.
  * Heroku: We&#8217;ll deploy the project on Heroku using a custom Python build-pack to install SciPy.

# <span id="The_Example_Project">The Example Project</span>

All of the code I&#8217;ll discuss and quote is available in [an example project on Github](https://github.com/abrookins/siren).

The proximity search that the example performs looks up statistics (nothing fancy now, just sums) about crimes that occurred in Portland, Oregon near a given location.

Also, a **warning**: this is by no means an attempt at production-ready code.

# <span id="The_Secret_Sauce_SciPy8217s_K-D_Tree">The Secret Sauce: SciPy&#8217;s K-D Tree</span>

The fastest way to do a proximity search lookup in Python that I could find was SciPy&#8217;s implementation of a k-d tree. For more information, check the [Wikipedia article](http://en.wikipedia.org/wiki/K-d_tree).

In short, a k-d tree is a binary space partitioning tree, and SciPy&#8217;s C implementation is pretty fast. Here are [the docs for the code we&#8217;ll use](http://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.cKDTree.html#scipy.spatial.cKDTree).

The class is pretty simple. According to the docs, we load in some data and get a `query` method that we can use to perform a nearest-neighbor search.

# <span id="Building_the_Proximity_Search">Building the Proximity Search</span>

So, let&#8217;s look at some example code that loads up the k-d tree. Then we&#8217;ll look at code that performs the query.

I&#8217;ve simplified part of a class I used in the example project to do this. The source is [available on GitHub](https://github.com/abrookins/siren/blob/master/siren/crime_tracker.py).

Here&#8217;s a Gist of the code we&#8217;ll look at first:



We have an `__init__` method that creates a `self.crimes` object.

Let&#8217;s assume this code loads a file that contains crime data tagged with Mercator coordinates into a dict whose keys are coordinates and values are an array of crimes that occurred at that location. (Presumably you also have a file of geo-tagged data that you wish to offer a proximity search web service for.)

On [line 13](https://gist.github.com/abrookins/5478445#file-gistfile1-py-L13) we create the k-d tree of crime locations. What we&#8217;re doing here is taking the coordinates of all known crimes (not the crime objects &#8212; just the coordinates, which are stored as keys in the `self.crimes` dict) and passing them into the `scipy.spatial.cKDTree` constructor. The `cKDTree` builds an index of the coordinates.

Next we have a `get_points_nearby` method that performs the nearest-neighbor(s) query against the k-d tree. The call to `query` is on [line 24](https://gist.github.com/abrookins/5478445#file-gistfile1-py-L24).

We sent a coordinate into `query` and we get back a tuple containing the distances and indices of nearest neighbors within the maximum distance that we supplied (in this case, 1/2 a mile).

That&#8217;s the meat of the proximity search, just passing the buck to SciPy &#8212; we now have our coordinates and we can look up in `self.crimes` the actual crime data that map to those coordinates.

# <span id="Creating_the_Web_Service">Creating the Web Service</span>

Assuming your source data is already in latitude and longitude form, you can already use `cKDTree` in the fashion we&#8217;ve looked at to do proximity search. Now we just need to wrap it up as a web service.

The following is an example using Flask because it&#8217;s a pretty easy framework to deploy to Heroku. I&#8217;ve edited it to remove only a couple of lines from [the real file](https://github.com/abrookins/siren/blob/master/siren/__init__.py).



This file defines two web services, one available at `/crimes/stats/<longitude>,<latitude>` and one at `/crimes/<longitude>,<latitude>`.

Assuming that the `PortlandCrimeTracker` object is capable of giving us back sums by category for crimes discovered near a coordinate, the rest of the work done in these services is ceremony: `get_point` tries to obtain a coordinate from the current request, and if it fails, causes Flask to return a 400 status code for the request. Meanwhile, `get_crimes` passes a valid coordinate and any GET parameters found in the request to `PortlandCrimeTracker.get_crimes_nearby`, which returns data on crimes near the coordinate.

# <span id="Deploying_SciPy_on_Heroku">Deploying SciPy on Heroku</span>

The trick to deploying SciPy on Heroku is using a custom buildpack. Fortunately, someone already creating one of these for this purpose. Some details about using it are available in [this Stack Overflow comment](http://stackoverflow.com/a/10632272).

I [forked the buildpack](https://github.com/abrookins/heroku-buildpack-python) for the sole purpose of pointing all of the repo URLs at my GitHub account.

# <span id="Performance">Performance</span>

Deploying this code onto Heroku with a free account (1 dyno) using no cache, Gunicorn and two workers got me an average of 98 requests per second after around 6000 requests.

# <span id="Why_not_PostGIS">Why not PostGIS?</span>

Well, for one, to have fun!

I like the idea of doing an in-memory search more than storing geo-data in a database when the dataset is frozen or it changes at regular and predictable intervals. So, I wouldn&#8217;t use this for an application that made user-entered locations searchable. In that case I would probably use PostGIS.

That said, we swapped a PostGIS dependency for a SciPy dependency, and with Heroku that turns out to be less than straightforward to deploy.