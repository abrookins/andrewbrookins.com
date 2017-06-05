---
id: 626
title: How to Fix Slow Scrolling in Vim and MacVim on macOS
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
Vim, Neovim, and MacVim can all exhibit slow scrolling in macOS. In some cases, the problem is OS-specific: key repeat settings can slow down scrolling with the `j` and `j` keys. Other times, the problem is really about Vim's ability to render long lines with syntax highlighting.

Fear not! There are solutions to both problems.

## Key Repeat Settings

There was always a marked difference between Vim on my Mac and Vim on Linux. Scrolling with `j` and `k` was blindingly fast on Linux, but plodded along on my Mac so slowly that I began using Control-F and Control-B most of the time.

It turns out there was a simple cause for the problem: key repeat settings. The default setting was too low for me.

You can change Key Repeat settings in System Preferences -> Keyboard. Tweak the Key Repeat and Delay Until Repeat settings to find a good speed. I had to restart after changing these settings to see any effect.

Now, the vanilla options helped some, but in order to get _really_ fast scrolling speed, I had to take two more steps:

  * Switch to [iTerm 2](http://www.iterm2.com/) for my terminal. Terminal.app couldn&#8217;t cope with faster key repeat settings &#8211; Vim was still slow, though a bit faster.
  * Tweak the repeat values even more with [KeyRemap4MacBook](http://pqrs.org/macosx/keyremap4macbook/).

The magic KeyRemap4MacBook values for me were:

  * [Key Repeat] Initial Wait: **500**
  * [Key Repeat] Wait: **35**

## Slow Rendering

Even with fast repeat settings, Vim can slow to a craw while scrolling through files that have long lines, when syntax highlighting is turned on. If you're a programmer, that means a lot of files! And the problem affects more than just macOS.

There are three settings that helped this on my systems. 

### nocursorline

This setting had the most impact of the three. It turns off the bar that highlights the current line you're on. That's kind of a bummer, but if it means I can scroll through HTML and Ruby files, then I'll take it.

### lazyredraw

This does... something. You can read about it with `help lazyredraw`. Basically, it seems to limit the number of times Vim renders, which sped up scrolling for me.

### synmaxcol

This is the nuclear option. It turns off syntax highlighting after a max column value, so lines longer than that abrubtly lose syntax coloring. I don't use this setting anymore because `nocursorline` was more useful. 

## Wrap-up

There you have it. All the tricks I currently know for dealing with slow scrolling in Vim. Note that I did not mention using `tmux` over `screen`, or Neovim instead of Vim. Besides using `iTerm` instead of `Terminal.app` for the key repeat issue, no other changes in how I was running Vim helped.

I read that slow scrolling due to rendering long lines was less pronounced in GVim and MacVim than in terminal Vim, but that was not the case for me. Only adjusting the settings I mentioned helped!
