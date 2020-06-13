---
title: 'My Ideal Software Development Environment'
date: 2017-06-03T11:19:45+00:00
author: Andrew
layout: post
permalink: /tech/my-ideal-software-development-environment/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology
  - iOS
---
> Someone who looks for me in form  
> or seeks me in sound  
> is on a mistaken path  
> and cannot see the Tathagata.  
>
> -- *The Diamond Sutra*, translated by Thich Nhat Hanh

> The world should provide me my computing environment and maintain it for me and make it available everywhere. If this were done right, my life would become much simpler and so could yours.
>
> -- [Rob Pike, interviewed for *The Setup*](https://usesthis.com/interviews/rob.pike/)

## The Beginning

It started simply enough: I wanted to pick the model of my next computer. I had very exact requirements. It had to be a device that could act as a desktop machine or a tablet, was extremely light (two pounds or less), had all day battery life even under high load, and whose memory and hard drive were upgradable.

Then I decided that on top of all that, I should be able to break it, pick up a replacement, and get back to work in fifteen minutes.

Nothing on the market had all of these features. There were hybrid laptops available -- Microsoft in particular makes some good ones, it seems -- but they were either soldered together and thus not upgradable, were quite expensive, or both. And all but the Surface Pro were too heavy!

The requirements didn't even fit my method of working. I used a big IDE and wrote code directly on my computer, a process that required hours to set up on a new machine and lots of CPU, RAM, and disk space.

I began to wonder, though: had working that way over the past several years blinded me to a different option, one that didn't require upgradable hardware? Could I store my development environment in a cloud system, turn it off and on when needed, and use a device that was more like an input/output tool -- in effect, a thin client?

I pondered this question until it led me to a vision of my ideal future computer and software development environment.

## The Computer

The most important thing about the computer is that there will be hardly anything on it. The environment that it connects to -- which is composed of remote services -- will be ambient and available in many forms.

Its smallest form is probably the size of a phone or watch. In any case, I can take it on runs, or to the grocery store, make calls and send messages, and otherwise use it as a phone.

Another form is a nine- or 12-inch tablet that is as light as a piece of paper. In a bag on my shoulder, I won't feel it at all on a three mile walk, even if I bring a keyboard attachment. When I hold it, it will be cool to the touch and absolutely silent. Reading with it in one hand will be comfortable, and so will occasional writing with a stylus, light gaming, and watching videos. When I want to work on it, which will involve writing code, I'll attach a keyboard and trackpad or mouse.

If the tablet form isn't large enough for my work, I'll attach the computer to a larger screen.

The only time I will need power will be at night, when I charge it, unless it can charge itself from solar cells. In either case, I won't think about the battery at all during the day.

Data stored on the computer will be used for caching. Data I create will be sent to a remote server immediately, or as soon as the computer establishes an internet connection, which will be available 99% of the time, via wifi or cellular networks.

Being that I am a software developer, I will use this device to write production-quality code in languages like JavaScript, Python, Ruby, and Go.

Instead of hardware upgrades, I will scale up or down the services that I use from this computer. If I need a faster development environment for a project, I will pay -- maybe temporarily -- to give my remote development environment more resources. If my photo library gets too big, I will pay for more cloud storage.

## The Editor

I've seen the power of a great IDE like PyCharm, even for dynamic languages. However, I don't want to have to buy and maintain a heavy, expensive computer to run one.

I'm also interested in new applications of code assistance: what about machine learning algorithms that could sweep my code while I sleep? And why can't my automated tests continue running while I walk to the coffee shop with my laptop?

The IDE I want has a fast native UI that communicates with remote servers for its intelligence features. My code, too, is stored on one of these remote servers. These could be third-party servers or ones I control. The editor will have useful suggestions, deep refactoring tools, a debugger, and all the other features that are available on an IDE on a fast PC or Mac. However, the work involved to provide those features will happen on a remote server, with the result displayed instantly in a beautiful UI on my light, low-powered device.

And while a network connection will be required for the deeper intelligence features of this hypothetical editor, the editor will still function without one. Offline, the editor allow editing cached versions files with syntax highlighting, and intelligence services would start again immediately when the network connection is reestablished.

## Hints of Things to Come

There are hints of this future editor around, in the form of language servers that speak the [Language Server Protocol](http://langserver.org/). Visual Studio Code relies on language servers for its intelligence features, although the servers are typically running on the same system as the editor and interacting with local code.

Eclipse Che is an editor that presents a web application that speaks to a REST API for intelligence features. Your code resides on the server that hosts the REST API; your browser runs the editor UI. There are other web applications like Codeanywhere, Cloud9, and Codenvy (built on Eclipse Che) that give you access to remote development environments via the web. However, all of these web-based editors fall short of mature programs like Vim and PyCharm.

The gap between these web applications and mature editors is due in part to web applications having limited access to keyboard shortcuts. Many keystrokes are absorbed by the browser, and some by the OS, and the set of these unavailable keystrokes depends on which browser and OS the user is using. Then there is the fact that mature native editors have accumulated features over years of development, giving them a head start.

Still, the Eclipse Che architecture is close to my ideal: a REST API that provides intelligence features, allowing the UI to be light. Now, maybe someone can build native UIs for Che instead of a web application, or else browsers will start allowing people to run web applications divorced from the browser UI, like you can in Chrome OS, so they can receive more keyboard shortcuts.

## Time to Experiment

Most of what I wanted was possible already, I realized.

While no editor existed that matched my requirements exactly, in the meantime I could use Vim running on a remote server, accessed via SSH. That setup would be less possible if I were a C# developer or built a lot of mobile apps, but for the most part, I'm a web developer.

So I made the switch, and it's been great. Vim over SSH freed me up to try different devices, and I had my eye on a few:

* An iPad with bluetooth keyboard (already owned)
* A Chromebook Plus (pretty cheap)
* A Galaxy S8 Phone with DeX dock (weird, but intriguing)
* A Surface Pro or Surface Book (cost prohibitive)

Since I already owned an iPad, I started there: [Can You Write Code on an iPad?](/tech/can-you-write-code-on-an-ipad/). Then I tried the [Chromebook Plus](/technology/can-you-code-on-a-chromebook-plus/) with a similar setup. Finally, succumbing to insanity completely, I tested [Windows 10 and the Surface Book 2](https://andrewbrookins.com/technology/using-windows-10-and-the-surface-book-2-for-web-development/).
