---
title: 'Coding on iPadOS: Browser Dev Tools with Inspect'
date: 2019-06-12
author: Andrew
layout: post
permalink: /technology/coding-on-ipados-browser-dev-tools-with-inspect/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Unix, technology
image:
  feature: matt-artz-gears.jpg
manual_newsletter: true
custom_js:
  - /assets/js/debugging.js
---

If you're a web developer who uses an iPad, you will eventually need access to a browser with developer tools. These tools should allow inspecting the DOM tree, changing an element's HTML, and tweaking CSS rules. Such tasks are trivial on macOS, but the only way to inspect a web page rendered by Safari on iPadOS is to connect your iPad to a Mac.

Is that the end of the web developer tools story on iPad? Do we pack it up and go back to our Macs?

No! [Inspect Browser](https://apps.pdyn.net/inspect/) is an iOS and iPadOS app that gives you a browser with developer tools. If you're a web developer with an iPad, you absolutely need this app.

Few people seem to know about Inspect, so this post will take a breezy tour of its strengths and weaknesses.

## Is the Inspect App Legit?

An app called "Inspect" should probably support inspecting HTML and CSS. Good news: Inspect lives up to its name and goes beyond the basics to provide a nice set of developer tools (this is no "Firebug Lite").

As a web developer, I want to point to an element on a page and see these things:

* The element's position in the DOM tree
* The markup used for the element
* The CSS rules applied to the element

I also want to interact with JavaScript running on the page.

Inspect can do all of this.

## Inspecting HTML

Inspect gives you a modal browsing experience with a "Tap to Inspect Mode" toggle that, when activated, lets you tap on any visible element to reveal it in a representation of the DOM tree in the sidebar.

<img src="/images/inspect-inspecting.jpg">

This functions the same way that developer tools in desktop browsers do. You can also tap items within the DOM tree to view the same details.

The sidebar is resizable, thankfully.

<img src="/images/inspect-resizable.jpg">

The sidebar can also be positioned to the right or the bottom of the screen.

<img src="/images/inspect-bottom.jpg">

{% include book.html %}

## Modifying Markup With Live Preview

Once you inspect an element, you can edit its markup and preview the result live.

<img src="/images/inspect-editable.jpg">

Web developers should be familiar with this behavior from other browsers -- it's a godsend sometimes!

## Viewing CSS

The CSS tab allows viewing the element's CSS rules. You can also edit CSS rules with live updates, similar to HTML markup.

<img src="/images/inspect-css.jpg">

Being able to tweak and adjust styles and markup with a live preview of the running page means that this tool allows doing frontend work on an iPad that simply wasn't possible before Inspect. Buy this app!

## Testing Responsive Layouts

Desktop browsers all include responsive layout tools now, and Inspect follows this trend. The app has a "Design" tab that lists different device size presets. Selecting one of these sets the viewport of the document to that size, e.g. an iPhone 8 Plus.

<img src="/images/inspect-design.jpg">

## JavaScript Console

To debug JavaScript, use `console.log()`. If you log JavaScript objects this way, they will appear in the "Console" tab of the app as an interactive object representation.

<img src="/images/inspect-console.jpg">

## Did You Just Say There Is No JavaScript Debugger?

There is no JavaScript debugger in Inspect. 50% of JavaScript developers should find this news completely uninteresting, while the other 50% will cry tears of blood.

I'm a debugger kind of guy, so this is the only weakness of the app that I've found.

## Summary: I Love This App

As mentioned at the beginning of this review, Inspect is legit. I love this app because A) it works well and B) it's one of several apps created by developers for developers to write and test code directly on an iPad. Nice work!
