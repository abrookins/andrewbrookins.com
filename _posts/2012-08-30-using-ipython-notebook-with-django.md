---
id: 856
title: Using IPython Notebook with Django
date: 2012-08-30T09:28:52+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=856
permalink: /python/using-ipython-notebook-with-django/
aktt_notify_twitter:
  - 'no'
lazyload_thumbnail_quality:
  - default
categories:
  - Python
tags:
  - python django
---
IPython has a relatively new featured called the &#8220;Notebook,&#8221; which improves on the traditional terminal shell in many ways.

Notebook launches a web-based shell to an IPython session that has some very, very handy features, like the ability to save, edit and delete &#8220;notebooks&#8221; of code that are each comprised of organized cells of Python, text or Markdown. You can move the cells around, developing code interactively with documentation and notes to yourself, displaying anything that a browser could render: images, HTML, etc.

But! You can&#8217;t run a Django shell using notebook.

## With Django Extensions

The latest version of the <a href="https://github.com/django-extensions/django-extensions" title="Django Extensions" target="_blank">Django Extensions</a> app on Github has support for using the `shell_plus` command with Notebook. If you&#8217;re up to date, you should be able to use the following command to run a Django shell with Notebook:

`$ ./manage.py shell_plus --notebook`

## Without Django Extensions

If you&#8217;d rather not use the Django Extensions app, you can load an IPython extension that performs the imports that an IPython session needs to run Django.

I&#8217;ve packaged up such an extension (very simple) that you can install from by executing this command from within IPython:



This will download the `django_notebook.py` module into `~/.ipython/extensions/django_notebook.py`. (The file merely attempts to load Django whenever you start IPython, unless an ImportError occurs.)

After installing the extension, add it to your IPython RC file. This is probably at `~/.ipython/profile_default/ipython_config.py`. If you don&#8217;t have one, you can use this command to create one with IPython (from the terminal shell, not within IPython):

`$ ipython profile create`

Then edit the created (or existing) `ipython_config.py` file and add the following line somewhere after the line `c = get_config()`:



(Or just append `'django_notebook'` to the existing extensions list if it exists.)

Now you should be able to run `ipython notebook` from within a Django project and have access to all of the Django and project-related modules.