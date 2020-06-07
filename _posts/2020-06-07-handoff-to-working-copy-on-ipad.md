---
title: "Handoff from Vim over SSH to Working Copy on iPad"
date: 2020-06-07
author: Andrew
layout: post
permalink: /technology/handoff-from-vim-to-working-copy-on-ipad/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - iOS, technology
image:
  feature: garage.jpg
manual_newsletter: false
---
# “Handing Off” from Vim on a Remote Server to Working Copy on an iPad

This tip scratches an itch that I sometimes have while writing code on an iPad.

Usually, I write code on a remote server using Vim. About the only touch interactivity that I get with Vim over SSH is scrolling, which my terminal emulator Blink must send as an ANSI control sequence that Vim understands.

You can see in this video that it’s ... not nothing. But it’s also deeply cursed.

<img src=“/images/scrolling-vim-ssh.gif”/>

I like to _write_ code in Vim, but when I’m just reading through code on an iPad? In that case, Working Copy is my jam. The app has a great search feature and is, of course, touch native.

So how hard is it to tell Vim to hand off the file I’m editing to Working Copy on my iPad?

Thanks to the x-callback-url specification, this is pretty easy. Here are the parts:

1. First: you have Vim set up to copy text into the iPad clipboard over SSH. Read [my post](https://andrewbrookins.com/technology/copying-to-the-ios-clipboard-over-ssh-with-control-codes/) to learn how to do this if you haven’t yet.
2. A custom Vim command that builds a Working Copy x-callback-url for the Git repository and file in the current Vim buffer.
3. An iPad Shortcut that opens whatever x-callback-url is in the system clipboard.

Once you have a Shortcut, to do the handoff you’ll run your function in Vim first. That’ll copy the Working Copy x-callback-url to the iPad’s clipboard. Then you can run your Shortcut from the home screen, the Dock (⌘ + Option + D), or from search (⌘ + Space).

My advice if you use search to run the Shortcut — which I do — is to name it so that it’s the first result after you type just a few letters. Something weird like “2workingcopy” works. Then all you have to do is type a few characters and press Enter, which launches the first result in the list — your Shortcut.

Wrapping up: This is an example of the fun stuff you can do by combining access to the iPad’s clipboard from a remote system with x-callback-urls and Shortcuts. Poke around and see what else you can automate — then let me know if you find anything cool!