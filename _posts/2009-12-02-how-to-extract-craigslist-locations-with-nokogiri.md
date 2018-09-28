---
id: 293
title: How to Extract Craigslist Locations with Nokogiri
date: 2009-12-02T10:16:24+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=293
permalink: /tech/how-to-extract-craigslist-locations-with-nokogiri/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
exclude_from_homepage: true
---
[Solace](http://solace.heroku.com) is a web app I created to search multiple Craigslist locations for the same query. It uses YQL to make the search, but in order to generate the YQL queries I first needed to generate a list of all valid Craigslist locations.

_Update:_ Full source code for Solace is now available on [GitHub](http://github.com/abrookins/solace).

There were a fair number of locations in the US, so I wrote a Ruby class that uses Nokogiri to scrape the locations directly from Craigslist&#8217;s web site.

The extraction process grabs all of the links from the supplied Craigslist URL and parses out the subdomain and link text. Then I preload the JavaScript portion of the app by dumping the JSON into an ERB template.

I still plan on writing up a description of the JavaScript portion of the app (which is now, as of 2011, written in CoffeeScript). In the meantime, check out GitHub for the source.
