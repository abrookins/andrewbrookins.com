---
id: 957
title: Wrap Comments and Text to Column Width in IntelliJ Editors
date: 2013-05-19T20:57:16+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=957
permalink: /tech/wrap-comments-and-text-to-column-width-in-intellij-editors/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
One of the small annoyances I found after switching to PyCharm recently was that while the editor will reformat code to the chosen column width, it won&#8217;t wrap plaintext or comments. Annoying, for Vim and Emacs users!

I corrected this by writing my first IntelliJ plugin: [Wrap to Column](http://plugins.jetbrains.com/plugin/?phpStorm&pluginId=7234), which is a port of [a different plugin I wrote](https://github.com/abrookins/WrapCode) for the same feature in Sublime Text 2. It should work with any JetBrains editor based on Intellij IDEA (PyCharm, WebStorm, PHPStorm, RubyMine, etc.).

The &#8220;Wrap to column&#8221; command wraps selected text or the current line to the column width you&#8217;ve configured for the project. The goal is to match the functionality of Vim&#8217;s &#8220;reformat lines&#8221; (`gq`) command and &#8220;fill paragraph&#8221; in Emacs.

Just so you know, there _is_ a &#8220;fill paragraph&#8221; command in IntelliJ &#8212; something they added in recent months &#8212; but I&#8217;ve not been able to get it to do anything but merge all selected text into a single line that is longer than my column width setting. After filing bug reports and sending emails, I gave up and wrote the feature myself, since I&#8217;d already done so once before.

If you end up using it, drop me a line or comment on the plugin page if it&#8217;s working for you. I could use more testers!