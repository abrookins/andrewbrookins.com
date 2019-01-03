---
id: 831
title: 'Go: How to Get the Directory of the Current File'
date: 2012-05-19T14:10:38+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=831
permalink: /tech/golang-get-directory-of-the-current-file/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
In Python I often use the `__file__` constant to get the directory of the current file (e.g., `os.path.dirname(os.path.realpath(__file__))`). While writing a Go app recently, I found that there wasn&#8217;t an immediately obvious (or searchable, even with &#8220;golang&#8221;) equivalent.

But in the annals of the golong-nuts mailing list I eventually found out about `runtime.Caller()`. This returns a few details about the current goroutine&#8217;s stack, including the file path.

The context of my problem was opening a data file in a shared package. What I cooked up was:



Sending `1` to `runtime.Caller` identifies the caller of `runtime.Caller` as the stack frame to return details about. So you you get info about the file your method is in. Check [the docs](http://golang.org/pkg/runtime/#Caller) for more in-depth coverage.

It&#8217;s not quite as elegant as `__file__` but it works.