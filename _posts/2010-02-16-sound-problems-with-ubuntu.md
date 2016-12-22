---
id: 300
title: Sound Problems with Ubuntu
date: 2010-02-16T10:23:39+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=300
permalink: /tech/sound-problems-with-ubuntu/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
The other day, I stopped hearing any sound effects on my Toshiba Satellite work laptop, which has an Intel HDA sound card. I&#8217;m running Karmic Koala, so I rolled up my sleeves and dug into the cause.

As an experienced Linux user I&#8217;m familiar with the occasional driver problems due to using computers effectively designed for Windows; and as a 2 year Ubuntu user, I&#8217;ve also been burned &#8212; constantly! &#8212; by automated software updates that totally hose some functionality in my system.

This time, I&#8217;m not really sure what the cause was, but [this forum post]() had the magic elixir:

<pre>rm -rf ~/.pulse killall pulseaudio</pre>

Apparently my Pulse Audio settings were the problem because after I removed that directory and restarted X, I had sound again.