---
title: Will iOS 13 Add Support for Safari Extensions?
date: 2019-05-29
author: Andrew
layout: post-dark
permalink: /technology/ios-13-safari-extensions/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology, iOS, Safari, iPad
image:
  feature: zebra.jpg
manual_newsletter: false
---

The lack of a desktop-class web browser on iOS is one of several things missing from the operating system that stop the iPad from being a true replacement for a laptop or desktop computer.

## What Are Extensions?

The defining feature of a desktop-class browser is extensions, which allow customizing the behavior of the browser. Safari, like the iOS versions of Chrome and Firefox, lacks support for extensions, while the macOS version supports them.

Over the years, Apple has opened up some functionality in iOS that extensions usually provide in macOS, like content blocking and password management, to apps installed from the App Store. So you can, for example, install Firefox Focus to block ads in Safari, and if 1Password is installed, you can use it to fill out passwords.

However, for Apple to truly sell iPads as a replacement for _work_ computers, Safari needs to support extensions. I think they're about to do just that -- as early as iOS 13.

## iOS 13 Will Address Other Major Productivity Pain Points

[Rumors suggest](https://www.macworld.com/article/3336145/ios-13-rumors-features-release-date.html) that with iOS 13, Apple will address other missing productivity features the lack of which iPad users often bemoan:

- The ability to open apps in multiple "windows": think multiple spreadsheets using the same app, multiple documents, etc.
- External mouse support
- Better file management

Apple wants people to use iPads to do serious work. They've created the best iPad in the history of the product -- with iOS 13, they need to make that iPad actually useful for more than watching videos.

## Safari Extensions Would Require a Safari Extensions API, Which Now Exists

Last year, over in macOS land, Apple sunsetted the Safari Extensions Gallery. Its replacement? [App Extensions](https://developer.apple.com/documentation/safariservices/safari_app_extensions): starting in 2019, if you want to create a plugin for Safari on macOS, you need to program against the App Extensions API and release your extension through the App Store.

Skip forward to today: many Safari extensions have now migrated to the App Extensions API. If Apple waved their wand and added support in Safari on iOS for the Extensions API, you could install these extensions in iOS. But will they?

## Apple's Game Plan is Unified Binaries

We already know that Apple is pushing hard on "Marzipan," which is a set of APIs that will allow app developers to write code that runs on both iOS and macOS.

Apple's game plan for iOS and macOS is unified binaries. That is, instead of a Windows 10 world in which the same computer is also your tablet, Apple sees a world in which the same app runs on macOS and iOS, and you might own both a laptop and a tablet.

## Conclusion: Look for Safari Extensions in iOS 13

Given the shared binary mindset and the existence, in 2019, of many Safari extensions that now use the Safari Extensions API, we should see support for extensions come to Safari on iOS soon -- and iOS 13 would be the right release, given Apple's other producitivty improvements. And if Apple does it right, developers should be able to flip a switch on their macOS Safari Extensions to release them on iOS.
