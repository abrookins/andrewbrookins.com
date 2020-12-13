---
title: "Scaling Django with Postgres Read Replicas"
date: 2020-12-20
author: Andrew
layout: post
permalink: /python/scaling-django-with-postgres-read-replicas
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
  feature: IMG_Jul52020at90431PM.jpg
manual_newsletter: false
---
Replication is an important disaster recovery feature of most modern databases, but you can also use it to make your Django application faster. In this post, I'll explain how to configure Django to query multiple read-only PostgreSQL replicas, allowing you to scale database performance by adding more replicas.

I'll also talk about what can go wrong -- specifically, *replication lag* -- and the tools that Django gives you to work with this problem.

## What is Replication?

With replication, you run multiple copies, or "replicas," of the same database, each of which synchronizes changes from the leader (also called the "primary") database. This not only gives you the superpower to immediately failover to a replica if the primary crashes -- it also lets you scale reads across all replicas and the leader.

Let me put that a different way: by configuring Django to query read-only replicas, you can _scale performance linearly_ by adding replicas. So, in theory, you'll get 2x performance by adding two replicas, 4x performance with four, and so on.

## Configuring Replication

Configuring replication in Postgres is a _project_. However, if you study the `postgres_leader` and `postgres_follower` directories in my [example Django project](https://github.com/abrookins/quest/tree/read-replicas), you can see what's required. Postgres also has [extensive documentation](https://www.postgresql.org/docs/12/high-availability.html) on replication.

However, most managed database services offer replication as a feature that you can click to enable. If you want to test replication without configuring it yourself, try DigitalOcean's Managed Databases product. Sign up with <a href="https://m.do.co/c/e063bdbde6da">this link</a> and you'll get $100 in credit -- while I get to run this blog for another month.

## Configuring Multiple Databases in Django

From this point on, I'm going to assume that you have a Postgres cluster with at least one replica running somewhere -- either one you configured yourself, my example database running via Docker, or a managed database service.

Your next step is to configure Django so that it knows about your replicas. The goal here is for the primary to handle read and write queries, while your replicas handle _only_ reads.

The first thing you'll do is add the replicas to the `DATABASES` setting. Here is what my example app looks like -- note that my example uses a single replica:

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

**Note**: If you have more than one replica, your `db_for_read()` method should instead randomly choose a replica, as the example in the Django docs does: `        return random.choice(['replica1', 'replica2'])`.

## So, What Could Go Wrong? (Replication Lag)

We have now covered most of the material on working with read-only replicas that you can find in the Django documentation -- and, incidentally, most web tutorials on this topic written from a Django perspective. So, what could go wrong?

The problem with reading from replicas is that for replication to be performant, it really needs to be _asynchronous_. What doest that mean? The primary database doesn't wait until all replicas are synchronized before telling you that your write is complete.

And that can lead to many kinds of reality distortions, as we shall see. The Django docs mention this, but unless you already practice the Dark Arts the warning might sound like gibberish:

> The primary/replica [configuration] doesn’t provide any solution for handling replication lag (i.e., query inconsistencies introduced because of the time taken for a write to propagate to the replicas).

The "inconsistencies" that this paragraph mentions are, in concrete terms, are usually failures of *read-your-writes consistency* or *monotonic reads* consistency.

### Read-Your-Writes Consistency

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

### Monotonic Reads Consistency

Next, consider this example from a self-help forum for the aforementioned lightsaber web site:

* I visit a page forum page titled "Help adding items to my wishlist"
* I scroll past the instructions and read the comments
* The first comment reads, "There's nothing wrong with the site ya geezer"
* The second comment reads, "What's up with the site today - I keep getting duplicates in my wishlist??"

This is an example of a failure to provide monotonic reads consistency. In other words, the application might show us writes database *out of order*. This can happen if Django routes queries to multiple replicas, and the replicas are in different states of synchronizing data from the leader.

### Working With Replication Lag

This all may sound truly dreadful ("consistency guarantees" -- ugh!), and it is, so you should ask yourself:

>Will users actually care if they see this data out of order, or fail to see new data immediately?

If neither matters all that much, then don't worry about it. And it may only matter *sometimes* -- in some areas of your application.

Assuming it does matter, what can we do about these two kinds of failures with Django?

### Guaranteeing Read-Your-Writes Consistency

The simplest thing is to always route reads of models that users routinely edit to the leader -- and send all other reads to the replicas.

```python
class PrimaryReplicaRouter:
    def db_for_read(self, model, **hints):
        if model is UserProfile:
            return 'primary'
        return 'replica'
```

Because you get a type object for the `model` argument to the `db_for_read()` method, you could probably introduce a [proxy model](https://docs.djangoproject.com/en/3.1/topics/db/models/#proxy-models) for user profiles that you _only_ use on the page that displays the user's own profile. When other users view their profile, though, you use the true `UserProfile` class.

Then you could do something like this:

```python
class PrimaryReplicaRouter:
    def db_for_read(self, model, **hints):
        # A user always reads their own profile from the leader
        if model is UsersOwnProfile:
            return 'primary'

        # Other user profiles -- and all other data -- comes
        # from a replica.
        return 'replica'
```

The more general you want to guarantee read-your-writes consistency, the darker the sorcery becomes. For example, another approach is to [keep track of the replication status of replicas](https://brandur.org/postgres-reads).

### Guaranteeing Monotonic Read Consistency

One way to guarantee that users see data in a consistent order is to always direct their reads to the same replica. How would you do this with Django? You'll need three things:

* A middleware function that makes the user ID accessible to the database router
* A database router (as we've discussed)
* A consistent hash function that will assign users to a replica

So, first, the middleware. Consider this middleware one, which uses thread local storage:

```python
import threading

request_config = threading.local()

class RouterMiddleware (object):
    def process_view( self, request, view_func, args, kwargs ):
        if request.is_authenticated():
            request_config.user_id = request.user.id

    def process_response( self, request, response ):
        if hasattr(request_config, 'user_id' ):
            del request_config.user_id
        return response
```

So, when a logged-in user accesses the Django application, this middleware is going to save their ID in a thread-local variable. Next, the database router needs to read that ID and, if it's present, consistently hash it to a "bucket" (a particular replica).

```python
import random

import mmh3

from quest.middleware.router_middleware import request_config


REPLICAS = ['replica1', 'replica2']


def hash_to_bucket(user_id, num_buckets):
    i = mmh3.hash128(str(user_id))
    p = i / float(2**128)
    for j in range(0, num_buckets):
        if j/float(num_buckets) <= p and (j+1)/float(num_buckets) > p:
            return j+1
    return num_buckets



class PrimaryReplicaRouter:
    def db_for_read(self, model, **hints):
        user_id = getattr(request_config, 'user_id')
        if user_id:
            bucket = hash_to_bucket(user_id)
            return REPLICAS[bucket]
        return random.choice(REPLICAS)
```


## Confirming that Replication is Working


To confirm replication is working, connect to the primary node and run this SQL query.

```
SELECT pid,usename,application_name,state,sync_state FROM pg_stat_replication;
```

You should see something like the following:

```
 pid | usename | application_name |   state   | sync_state
-----+---------+------------------+-----------+------------
  34 | rep     | walreceiver      | streaming | async
```

You can also connect to a replica (frpom ):

 ./manage.py dbshell --database replica

