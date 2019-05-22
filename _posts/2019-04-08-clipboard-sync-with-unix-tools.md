---
title: Copying to the iOS Clipboard from Linux and macOS Servers over SSH
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

When developing on a remote computer over SSH from iOS, one problem has vexed me: how do you synchronize the remote clipboard with your primary machine's clipboard? I spent some time on a recent weekend seeing how far I could get on this problem using "just" 

## How Should it Work?

Ideally, when you copy text into the iOS clipboard, you should be able to paste it from that clipboard onto the remote machine, and when you copy something into the remote machine's clipboard, you should be able to paste it from that clipboard into iOS.

It is easy enough to select text within an SSH app and copy to the iOS system clipboard, then paste that text into another app. Copying t but how do you copy large amounts of text from inside a text editor like Vim, copy command output with a command-line tool like `xsel`, or copy from the scrollback buffer within a  `tmux` session?

In all of these cases -- not only using when your finger -- you should be able to copy text on the remote server into the iOS system clipboard and then paste it into any iOS app. That's the dream.

## When the Remote Machine is Running Linux

If the remote computer's operating system is Linux, the typical approach on macOS, Windows, or Linux is to run an X server locally and SSH to the remote machine with X forwarding turned on. You can then either run a graphical terminal like gnome-terminal over X, or use `xsel` from the command line (e.g., `cat file.txt | xsel --clipboard`) to copy to the clipboard, letting the X server synchronize the clipboard.

However, no SSH apps that I'm aware of on iOS support X forwarding -- certainly not to the extent that they synchronize the clipboard. An [X Server app exists](https://itunes.apple.com/us/app/id1440418587#?platform=ipad), but it didn't even support pasting from the iOS system clipboard, let alone synchronizing the X clipboard to the iOS system clipboard.

So, X forwarding is out. However, we'd like to access the clipboard. How far can we get using just Unix/Linux command line tools and an SSH app on iOS like [Blink Shell](https://www.blink.sh)?

### With a Running X Windows Session

If you're connecting to a Linux machine that has a running X Windows session, perhaps your primary desktop machine, you can log in via SSH and set the `DISPLAY` environment variable -- either via your `.bashrc`/`.zshrc` file or manually -- to use the existing session's X clipboard.

You would set `DISPLAY` like this:

    export DISPLAY=:0

**TIP**: If you don't know which display your X session is using and `:0` doesn't work, run `w -oush` to see the list of login shells. At least one of these will be a tty with a display like `:0`.

After exporting `DISPLAY`, you can use `xsel --clipboard` to copy and paste from command-line applications like Vim and `tmux` into the X clipboard. There are many tutorials that explain how to do this, so if you haven't set this up yet, do some web searching and come back when it works. However, I assume that if you are running X Windows, you have probably already set up your command-line tools to copy to the X clipboard.

Now, the question is: how do we get the X clipboard contents into the _iOS_ system clipboard?

#### Option 1: Using Blink Shell

Blink is an SSH app for iOS that in addition to having a nice command-line interface to SSH and moSH (the "mobile shell"), also has an interactive shell with access to a small number of command-line utilities.

While I recommend Blink generally for its SSH features, you can use this shell to manipulate the iOS system clipboard with `pbcopy` and `pbpaste`. `pbcopy` is similar to `xsel --clipboard` in that it accepts content via pipes, like `echo test | pbcopy`. Meanwhile, calling `pbpaste` will output the iOS system clipboard contents to standard out.

So the simplest thing you can do -- again, only if you are running an X Windows session on the remote computer already -- is the following:

- Connect to the remote machine in one Blink terminal
- Manipulate the `DISPLAY` env var
- Copy text into the X clipboard via tmux, Vim, or other command-line tools
- Keep a second terminal open, but disconnected, to use the local Blink shell. Whenever you need to synchronize the remote clipboard to the iOS clipboard, run a command like `ssh <host> "DISPLAY=:0 xsel --clipboard" | pbcopy`, which will connect to the remote machine, output the clipboard, and then pipe that output to `pbcopy`, which will copy it into the iOS system clipboard.

<!-- TODO: Gif/screenshot; needs X Windows running somewhere -->

#### Option 2: Using the Shortcuts App

If you don't want to spend money on Blink Shell, you can also use the free Shortcuts app from Apple to create a shortcut that connects to the remote machine, outputs the X clipboard, and then copies that output to the iOS system clipboard.



## Without a Running X Windows Session


## clip.txt

If you are developing over SSH on Linux, there is no such thing as the "system clipboard." The closest thing is the X clipboard.

If we want to copy text within Linux programs like Vim and `tmux` and expose that text somehow to the iOS clipboard, and we don't have access to the X clipbiard,

Ever since reading the book [Designing Data-Intensive Applications](https://www.amazon.com/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321) by Martin Kleppmann, I've been looking for a reason to use log-structured storage.

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
