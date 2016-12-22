---
id: 820
title: Run Django Unit Tests in a Sublime Text 2 Build System
date: 2012-02-28T09:11:20+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=820
permalink: /tech/run-django-unit-tests-in-a-sublime-text-2-build-system/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
With the dev builds of Sublime Text 2, you can easily set up a build system that runs Django unit tests. You do this by adding a build system to your Sublime Text 2 project file for the Django project.

I&#8217;ll include an example project file in this post that runs `manage.py test --noinput` as the build command. In order for this to work with the current implementation of build systems, the project file must add the Django project dir and the virtualenv&#8217;s site-packages directory to the `PYTHONPATH`.

Note a couple of things:

  * In the project file, ${project_path} refers to the directory in which the project file exists: I created mine in the virtual env directory (the directory with the bin/ and lib/ directores for the virtualenv). For more info on other possible substitutions see [the docs](http://sublimetext.info/docs/en/reference/build_systems.html) (note that I couldn&#8217;t get substitutions to work in the &#8220;env&#8221; dictionary)
  * My placeholder text `django_project_dir` stands for the directory that contains your Django project files inside of the virtualenv
  * This doesn&#8217;t use the `python` binary in your virtualenv &#8212; so your mileage may vary 

One final thing to note is that I&#8217;ve added the `lib/python2.7` directory as a folder in the project file. This is not related to the build system. It simply includes libraries in my &#8220;Find in File&#8230;&#8221; searches, allowing me to easily search for, e.g., Django classes and usages alongside my own. (SublimeRope is also a helpful tool for exploring.)

Anyway, here is the example project file: