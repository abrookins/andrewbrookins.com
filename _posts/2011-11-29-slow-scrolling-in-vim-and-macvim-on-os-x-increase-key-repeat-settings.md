---
id: 626
title: How to Fix Slow Scrolling in Vim and MacVim on OS X
date: 2011-11-29T07:08:30+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=626
permalink: /tech/slow-scrolling-in-vim-and-macvim-on-os-x-increase-key-repeat-settings/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
I finally discovered the cause of my #1 OS X problem: slow scrolling in Vim, both in Terminal.app and in MacVim.

There was always a marked difference between Vim on my Mac and Vim on Linux. Scrolling with the movement keys (j/k in particular) was blindingly fast on Linux, but plodded along on my Mac so slowly that I began using Control-F and Control-B most of the time.

It turns out there was a simple cause for the problem: key repeat settings. The setting was too low for me.

You can change Key Repeat settings in System Preferences -> Keyboard. Tweak the Key Repeat and Delay Until Repeat settings to find a good speed. I had to restart after changing these settings to see any effect.

Now, the vanilla options helped some, but in order to get _really_ fast scrolling speed, I had to take two more steps:

  * Switch to [iTerm 2](http://www.iterm2.com/) for my terminal. Terminal.app, even Lion&#8217;s, couldn&#8217;t cope with faster key repeat settings &#8211; Vim was still slow, though a bit faster.
  * Tweak the repeat values even more with [KeyRemap4MacBook](http://pqrs.org/macosx/keyremap4macbook/).

The magic KeyRemap4MacBook values for me were:

  * [Key Repeat] Initial Wait: **15 (Update: 500)**
  * [Key Repeat] Wait: **35**