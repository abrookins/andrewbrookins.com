---
id: 857
title: Set an ImageField path in Django manually
date: 2012-08-23T11:42:37+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=857
permalink: /tech/set-the-path-to-an-imagefield-in-django-manually/
aktt_notify_twitter:
  - 'no'
categories:
  - Django
  - Technology
---
Apparently this is a confusing topic. Let&#8217;s say you have a Django model with an ImageField and some existing media files, and you&#8217;d like to connect the files to the ImageField. This is relatively painless and doesn&#8217;t require you to use the `save()` method on the ImageField.

If you only want to set an ImageField to point to an existing file, assign a string containing the path _relative to `settings.MEDIA_ROOT`_ to the field. E.g.:



This works as of (and possibly before) Django 1.3.

Note a couple of things:

Setting the path ignores your `upload_to` value. You have to prefix your string with that value yourself.

Again, you don&#8217;t have to call `save()` on the ImageField &#8212; just the model instance. There are some StackOverflow posts that advise going the route of calling `save()` on the ImageField, which requires you to open a file descriptor, etc. This isn&#8217;t necessary, will end up copying the file, and ignores any prefixed paths, resulting in a path that is always, in my testing, `settings.MEDIA_ROOT/filename.jpeg`.