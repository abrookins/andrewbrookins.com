---
title: Command Line Clipboard Sync with Unix Tools and iOS
date: 2019-04-08
author: Andrew
layout: post-dark
permalink: /technology/command-line-clipboard-sync-with-unix-tools/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Unix, technology
image:
  feature: ipad23.jpg
manual_newsletter: true
---

When developing on a remote computer over SSH, one problem has vexed me: how do you synchronize the remote clipboard with your primary machine? This problem is even more difficult on iOS, where traditional approaches don't work.

## Using an X Server

If the remote computer's operating system is Linux, the typical approach is to run an X server locally and SSH to the remote machine with X forwarding turned on. You can either run a graphical terminal like gnome-terminal over X, or use `xsel` from the command line (e.g., `cat file.txt | xsel --clipboard`) to copy to the clipboard, letting the X server synchronize the clipboard.

However, there are a few problems with X forwarding:

- There is no X server available for iOS
- You can't use X forwarding if the remote machine is running macOS
- If your client machine is a Mac, the XQuartz server can't handle high-resolution displays like the built-in one on modern Mac laptops
- The X protocol has not aged well: even terminal programs like gnome-terminal lag excessively; browsers visibly paint down the screen...

In my experience, X forwarding works best if you use a terminal native to the primary machine -- not over X -- and only run the X server for clipboard sync. Your command line tools should pipe to `xsel`.

However, X forwarding isn't an option if your client device is an iPad, or if your development machine is running macOS.

## The Woes of pbcopy

If you are connecting from an iPad to a Mac, you might think that the "Universal Clipboard" feature of iOS and macOS will save you, but it won't. The macOS tool most similar to `xsel` is `pbcopy`, which allows you to pipe command line output into the macOS clipboard. However, `pbcopy` doesn't sync with other devices over Universal Clipboard, so if you copy a line in Vim or tmux (the tools I use) on a remote Mac, that text won't be in the clipboard of your iPad running SSH.

Can we do better? Yes -- sort of...?

## The Simplest Solution that Could Possibly Work

Before we write any code, what's the simplest solution to this problem that could possibly work? The best I've found is a combination SSH, `pbcopy`, and `pbpaste`. This solution only applies in the following situation:

- You are using iOS or macOS as the client
- You are using macOS as the server

This is pretty simple, it's Mac-only, and it requires you to manually sync the clipboard.

On the server, you 


## Command Line Clipboard Sync with Unix Tools

Everything before this section was an elaborate introduction to the question that I tackled last weekend instead of doing anything productive: can we implement command line clipboard sync using _only_ Unix tools and make it work on iOS?

If your first thought is there must be an app for this already, you are missing the point. _This exercise is designed to make you avoid more important work._ Relish it.

After fooling around with shell scripts, here is the design I finished with:

- We redirect all "paste" actions from the tools running on the server to a new script, `clip`
- `clip` directs its input to a clipboard file structured as "log" and hosted on cloud file sharing -- e.g., Dropbox or iCloud
- Client devices that support file change poling, e.g. macOS or Linux machines, watch their copy of the clipboard file with a `watchclip` script
- `watchclip` watches a file for changes using the `fswatch` utility, and when a change is found it uses the `lastclip` script to copy the last clipped item into the local system's clipboard
- Client devices that do _not_ support file watching, like iOS, use system automation to connect directly to the remote machine over SSH, run `lastclip`, and send the output to the iPad system clipboard

Because I spent part of my weekend on this problem of dubious utility, let's dig into each item in the design and really spend some time on it.

## The clip Script

If we want to synchronize clipboard contents between multiple machines, we need to store the clipboard contents somewhere other than the system clipboard. That is what the `clip` script does. It's pretty short:

```bash
#!/bin/zsh
CLIPBOARD=~/icloud/Documents/clipboard.txt # 1
echo ♕ >> $CLIPBOARD                       # 2
cat - >> $CLIPBOARD | pbcopy               # 3

```

It's a three-line script, but there are a few arcane invocations at work:

1. Thing
2. Doodle

Ever since reading the book _Designing Data-Intensive Applications_ by Martin Kleppmann, I've been looking for a reason to use log-structured storage.
