---
title: Coding on an iPad Pro in 2019
date: 2019-01-03
author: Andrew
layout: post-dark
permalink: /technology/coding-on-ipad-pro-2019/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology, iOS, markdown, Python
image:
  feature: ipad23.jpg
manual_newsletter: true
---

In 2017 I asked, [“Can You Write Code on an iPad?”](https://andrewbrookins.com/tech/can-you-write-code-on-an-ipad/) In 2019 the answer is basically the same: not really. But things are getting interesting.

Fair warning: Much of this post is specific to web application development.

## “Programming” on iOS: the Shortcuts App

The iPad still lacks the ability to do any native _programming_. That is, you won’t find a secret door leading to a UNIX shell where you can install homebrew and a C compiler. If only!

The closest to programmability that exists as a native function of iOS is the Shortcuts app, which can automate small tasks and connect apps together.

This is the rebranded Apple version of Workflow, a popular app that did more or less the same thing. You can use Shortcuts to string together a series of actions you might normally take, like turning on Do Not Disturb, playing a specific album (I recommend _Brute Force_ by The Algorithm), and opening an SSH client app or a text editor.

Shortcuts is probably useful to someone, but I don’t use it much yet and it’s not programming!

## Editing in Native iOS Text Editors

Yet all is not completely lost. First, if you concede that the iPad Pro is a potential thin client that pairs with a server, then you have options. There are great SSH apps available, like Blink. But you don’t necessarily have to connect directly to the server. If you would rather edit natively on the iPad and construct a system of pulleys that heft your code up to a cloud server, that is also possible. We will explore both options.

### You Probably Can’t Run Your Code on iOS Unless It’s Python

There is some wiggle room around running your code directly on the iPad if you are a Python developer. The Pythonista app has grown over time from a Python text editor focused on iOS automation to a hackable Python development environment that ships with major packages like NumPy, has a bash-like shell implemented in Python, and supports plugins.

Other than Python, I haven't found any generally useful interpreter or compiler apps on iOS.

**Update**: Readers referred me to Continuous, a C# and F# IDE for iOS, and Rescript, a JavaScript/node.js IDE for iOS. These both look promising and may be equivalent to Pythonista, but I haven't used them. There is also Replete, an iOS app that gives you a ClojureScript REPL (read-eval-print loop); while fun, it seems less feature-rich than the others.

### Native iOS Editors Are Getting Better

There are increasingly decent text editors that run without the interpreter or compiler component. Apps like GoCoEdit and Textastic offer editing experiences that have started to gain some of the features of desktop editors that go beyond the basics — e.g. fuzzy-finding files.

These editors are beginning to work with each other and with the powerful Git app Working Copy and the Apple-provided Files app to produce interesting effects. Working Copy can check out a Git repository and make it available for editing to apps like GoCoEdit; changes made in the editor reflect automatically back in Working Copy, where you can then commit them.


{% include newsletter.html %}


### Features Missing from iOS Text Editors

None of these editors provide an experience suitable for actual software development by themselves, though. We’re talking Dreamweaver, not Emacs.

One missing piece currently is project search; that is, given a directory or set of directories, allow the user to search for text across all files in it. If you use GoCoEdit or iVim, you can get an approximation of this by using Working Copy’s great search tool, which does provide this feature, to find files and then choose e.g. “open in GoCoEdit” from the share menu. Textastic doesn’t offer this feature for some reason. Anyway, it’s workable in a pinch, but you probably won’t achieve the sought-after "flow."

---
**Side note on iVim**: it’s gotten better. You can have a `.vimrc` file and download plugins into the app’s filesystem. Supposedly plugins work as long as they’re written in Vimscript. Also, note that it's Vim 7, so no async.

---

While working from an iOS text editor, don’t expect the typical pattern of web application development to apply. Unless you use Pythonista, there is no server running your code on the iPad, so you’ll need some glue to make your edited file transfer somewhere that actually runs code, like a server or a serverless platform. There are many ways to accomplish this in 2019, possibly involving some use of Pythonista, Zapier, IFTTT, and/or a Siri voice command in Shortcuts. If coding on an iPad is your new hobby then you can indulge all of your worst Attention Deficit Disorder habits exploring this topic.

None of these editors offer any linters or code formatters either. The design of iOS suggests that getting linters and formatters external to an editor app to work would probably involve a separate app that supported linting and formatting messages with text as the input. Otherwise, the editor will need to provide the binary, e.g. `gofmt`. For tools written in interpreted languages, I suppose the editor would have to bundle the entire programming language or whatever Pythonista is doing.

## The Message-Passing Nature of iOS is Pretty Cool

The more you use iOS to do anything non-trivial, the more you start to feel its message-passing nature. Instead of applications interacting with each other and with the OS through files and system calls, all apps send and receive messages between each other and the OS.

Thus you find your files in the Files app, but it isn’t just a directory of files. It’s more like a single place to send and receive messages about files in all of the apps on your iPad, including iCloud Drive.

Apps that do anything with files have added more advanced features to take advantage of these new file-related messages that other apps support, so many text editor apps can now do things like open a directory of files exposed by another app (in 2019 that is “advanced” for iOS). Directories opened this way will usually stay in something like a sidebar in the app and continue to be accessible as if they were local to the app.

Eventually this starts to feel pretty cool and natural; going back to a desktop computer, you might expect a consistent “share” button that doesn’t exist. If only there was a professional-grade text editor available on iOS -- and compilers, interpreters, web servers, etc.

## Connecting to a Real Computer with SSH

If you use Blink or another SSH app to connect to a server that can execute arbitrary code and run Vim or Emacs from there, then the typical pattern with web apps written in dynamic languages of editing a file, waiting for the app server to reload the edited file, and then refreshing a web page can still work.

You’ll be refreshing a browser on iOS, of course. I suggest iCab due to its extensive customization options, including hands-down the best modifiable keyboard shortcuts I’ve seen on iOS.

### Where Should You Run Your Server in 2019?

For people who need the power and flexibility of a remote server and a true editor like Vim, there are even more options than there used to be.

There are, of course, VPS providers like Linode and Digital Ocean. These work fine, but one downside is they don't have very strong renewable energy commitments.

Google uses 100% renewable power, and Google Cloud Shell gives you a micro server with persistent storage and preinstalled development tools for free. The Google Cloud Console app can open a Cloud Shell session natively on iOS. However, good luck getting copy and paste to work in that app! You will also need to set any settings like font size by launching a Cloud Shell session in an iOS browser. You can’t actually use Cloud Shell from an iOS browser though — the app won’t pick up keyboard presses, at least with the onscreen keyboard.

Instead of using the Cloud Console app, you could connect to a jump host that has the `gcloud` CLI tool installed. You can connect to Cloud Shell from a terminal with the recently added command, `gcloud alpha cloud-shell ssh`. The "always free" tier of GCP includes an f1-micro instance, which could be your jump host to Cloud Shell or just... your development VM.

What also works well is an old Mac that you can set up as a server, because then you can do fun stuff like access the same files as the iPad over iCloud Drive, or use `osascript` to send yourself text messages that deep-link into iOS apps. The world is your oyster at that point. Apple has revived the Mac Mini, so that is a viable home server/desktop computer pair for the iPad. (Or you could, you know, buy a real mobile computer like a laptop.)

### Reaching Your Development Web Server from an iOS Browser

A few years ago year if you were developing a web application on a remote server you might have had to run the application’s dev server on a publicly-accessible port. Now there is an app for SSH tunneling called -- wait for it! -- SSH Tunnel.

To reach your application server (e.g. Django's development server), first you establish a tunnel to the server (the computer) on which the app server is running with SSH Tunnel. You'll want to define a hostname other than "localhost" in `/etc/hosts` on the server, pointed at 127.0.0.1. Then follow the instructions on SSH Tunnel's web site to set the right proxy settings on the iOS network connection you're using.

After you perform the blood sacrifice, you can type in the hostname you specified, e.g. `old-faithful` and the port on which your application server is running into your iOS browser of choice, e.g. `http://old-faithful:4000` to load the application.

### Browser Dev Tools, Where Art Thou?

When you need to debug the web app, there is now a dev tools app called Inspect. It works pretty well, though it lacks the robust JavaScript debugging environment you get on a desktop browser. Still, other than a JS debugger, Inspect has most of what you need: CSS/HTML inspection and a JS console, so you can at least do `console.log` debugging.

Lack of a dev tools app like Inspect was the number one blocker for web app development on the iPad before 2018. Using just these tools, you can do web application development from the iPad. Will it be great? I don't know. Probably not.

### So There You Have It

In 2019 the iPad and iOS are basically the same as they were in 2017, as far as programming goes. What is different is the growing number of iOS app developers catering to people who want to write code on iOS.

Given that iOS was released 12 years ago and only now has text editors akin to Dreamweaver available, with few ways to run code beyond “learn to code” apps, I propose that you will be able to code on an iPad in 2037.
