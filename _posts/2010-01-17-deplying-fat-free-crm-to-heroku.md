---
id: 296
title: Deploying Fat Free CRM to Heroku
date: 2010-01-17T10:18:15+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=296
permalink: /tech/deplying-fat-free-crm-to-heroku/
categories:
  - Technology
---
</p> 

I just finished deploying a [Fat Free CRM](http://www.fatfreecrm.com/) install with all the under-development plugins to Heroku. Starting out with [Saturn Flyer&#8217;s write-up](http://saturnflyer.com/blog/jim/2009/09/08/fat-free-crm-on-heroku/), I learned a few things along the way, and now I have a cool Rails-based sales app to play with.

### Working with a read-only filesystem

The biggest stumbling block I had was realizing Fat Free CRM&#8217;s use of Sass didn&#8217;t jive with Heroku&#8217;s read-only filesystem. Two plugins exist that theoretically fix this problem; however, only one worked for me: [heroku sass and cache](http://github.com/mooktakim/heroku_sass_and_cache).

### CSS errors

If you get any weird CSS-related errors in the Heroku production log after deploying your app (read it via the &#8220;heroku logs&#8221; command), make sure to read this [Fat Free CRM Users thread](http://github.com/mooktakim/heroku_sass_and_cache), which links to a patch for this problem. However, this shouldn&#8217;t come up if you just clone the [Fat Free git repo](http://github.com/michaeldv/fat_free_crm).

### Pushing a local branch to Heroku

Remember, by default you are pushing to the master branch on Heroku, and according to Heroku&#8217;s git deployment docs, there isn&#8217;t a way to change this. However, you can still work on a local branch and push that branch to master with the following command:</p> 

`git push heroku local_branch:master`