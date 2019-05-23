---
title: Copying to the iOS Clipboard from Linux and macOS Servers over SSH Using Linux Command-Line Tools
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

When developing on a remote computer over SSH from iOS, one problem has vexed me: how do you synchronize the remote clipboard with your primary machine's clipboard?

Because I like to screw around, I spent some time on a recent weekend seeing how far I could get on this problem using only UNIX/Linux command line tools -- that is, without writing any code.

## How Should it Work?

Ideally, when you copy text into the iOS clipboard, you should be able to paste it onto the remote machine, and when you copy something into the remote machine's clipboard, you should be able to paste it into an iOS app.

You can already select text with your finger in an SSH app and copy to the iOS system clipboard, as long as all the text you want to copy is visible on the screen. But how do you copy large amounts of text from inside a text editor like Vim, copy command output via pipes, or copy from the scrollback buffer within a  `tmux` session?

In all of these cases -- not only using when your finger -- you should be able to copy text on the remote server and then paste it into any iOS app. That's the dream, anyway.

## When the Remote Machine is Running Linux

If the remote computer's operating system is Linux, the typical approach on macOS, Windows, or Linux is to run an X server locally and SSH to the remote machine with X forwarding turned on. You can then either run a graphical terminal like gnome-terminal over X, or use `xsel` from the command line (e.g., `cat file.txt | xsel --clipboard`) to copy to the clipboard, letting the X server synchronize the clipboard.

However, no iOS app that I'm aware of supports X forwarding over SSH. An [X Server app exists](https://itunes.apple.com/us/app/id1440418587#?platform=ipad), but it didn't even support pasting from the iOS system clipboard, let alone synchronizing the X clipboard and the iOS system clipboard.

So, X forwarding is out. However, we'd like to access the clipboard. How far can we get using just UNIX/Linux command line tools and an SSH app on iOS like [Blink Shell](https://www.blink.sh)?

### With a Running X Windows Session

If you're connecting to a Linux machine that has a running X Windows session, perhaps your primary desktop machine, you can log in via SSH and set the `DISPLAY` environment variable -- either via your `.bashrc`/`.zshrc` file or manually -- to use the existing session's X clipboard.

You would set `DISPLAY` like this:

    export DISPLAY=:0

**TIP**: If you don't know which display your X session is using and `:0` doesn't work, run `w -oush` to see the list of login shells. At least one of these will be a tty with a display like `:0`. You can also automate this using a command like `w -hs | awk '{print $3}' | sort -u | head`.

After exporting `DISPLAY`, you can use `xsel --clipboard` to copy and paste from command-line applications like Vim and `tmux` into the X clipboard. There are many tutorials that explain how to do this, so if you haven't set this up yet, do some web searching and come back when it works. However, I assume that if you are running X Windows, you have probably already set up your command-line tools to copy to the X clipboard.

Now, the question is: how do we get the X clipboard contents into the _iOS_ system clipboard?

#### Getting the Clipboard Contents Using Blink Shell

Blink is an SSH app for iOS that in addition to having a nice command-line interface to SSH and moSH (the "mobile shell"), also has an interactive shell with access to a small number of command-line utilities.

While I recommend Blink generally for its SSH features, you can use this shell to manipulate the iOS system clipboard with `pbcopy` and `pbpaste`. `pbcopy` is similar to `xsel --clipboard` in that it accepts content via pipes, like `echo test | pbcopy`. Meanwhile, calling `pbpaste` will output the iOS system clipboard contents to standard out.

So the simplest thing you can do -- again, only if you are running an X Windows session on the remote computer already -- is the following:

- Connect to the remote machine in one Blink terminal
- Manipulate the `DISPLAY` env var
- Copy text into the X clipboard via tmux, Vim, or other command-line tools
- Keep a second terminal open, but disconnected, to use the local Blink shell. Whenever you need to synchronize the remote clipboard to the iOS clipboard, run a command like `ssh <host> "DISPLAY=:0 xsel --clipboard" | pbcopy`, which will connect to the remote machine, output the clipboard, and then pipe that output to `pbcopy`, which will copy it into the iOS system clipboard.

%% Screenshot

#### Getting the Clipboard Contents Using the Shortcuts App

If you don't want to spend money on Blink Shell, you can also use the free Shortcuts app from Apple to create a shortcut that connects to the remote machine, outputs the X clipboard, and then copies that output to the iOS system clipboard.

You will create a new Shortcut and add the "Run Script over SSH" command. Then you will fill out authentication details (it only supports user/password authentication, not SSH keys) and the command to run. That should be something like `DISPLAY=:0 xsel --clipboard`.

%% Screenshot

If you are the sort of person who would enjoy speaking the words "Hey Siri, clipboard" to execute this shortcut, then you can also give it a "Siri Phrase."

Aside from being able to run your Shortcut with a voice command, it will also appear in Spotlight results, so you can press Command+Space to open Spotlight, start typing your Shortcut name, and then press Enter to run it

However, an unfortunate reality of Shortcuts is that there is no way to complete their execution without tapping the screen. Bummer, dude.

### Without a Running X Windows Session

Of course, not everyone is running a full Linux desktop with an X Windows session. Many of us use a headless VM for remote development. How can we access the system clipboard in that environment?

#### clip.txt

The last question was sort of a trick. When developing on a headless Linux server over SSH, there is no "system clipboard." The closest thing is the X clipboard, which won't be running without a display.

If we want to copy text within Linux programs like Vim and `tmux` in a headless environment and somehow expose that text to the iOS clipboard, then we need to build our own lightweight clipboard. Let's call it `clip.txt`.

#### Storing Multiple Items

The "clipboard" concept is a single-item buffer in some operating systems, while on others it can store multiple items. Because a multi-item clipboard is a little more fun, that is what we will create.

We will create this multi-item clipboard in a file called `clip.txt`. To support storing multiple items, let's use a "log" structure: we'll append new items to the end, and read the last item to determine the current clipboard content.

In order to distinguish multi-line clipboard items from each other and from single-line items, we will use a unicode symbol as an entry delimiter. The symbol will be White Chess Queen Emoji, ♕ (code point U+2655).

We could start getting very fancy indeed with these entries, like storing them in a structured format and including Lamport timestamps to help replicate the logs across multiple machines. However, let us pull back from that abyss for the moment.

#### Writing to the Clipboard with the "clip" Script

Now that we know we'll store our clipboard contents in the file `clip.txt`, we need a way to append items to that file. We _could_ just `echo` or `cat` text to the end of the file, like `echo pants >> ~/clip.txt`. However, we want to add our White Queen delimiter, so let's create a `clip` script that will serve as the command-line interface for copying things to `clip.txt`.

Here is an example `clip` script:

```bash
#!/bin/zsh
CLIPBOARD=${CLIPBOARD:=~/Dropbox/clip.txt}  # 1
echo ♕ >> $CLIPBOARD                        # 2
cat - >> $CLIPBOARD                         # 3
```

It's only four lines, but there are a few arcane invocations at work:

1. Use the `CLIPBOARD` environment variable if set; otherwise use a default value.
2. Append White Chess Queen to the end of the clipboard file.
3. Append standard input (piped content) to the clipboard file.

As you can see, I'm going to throw caution to the wind and store my `clip.txt` in Dropbox. We'll explore encryption options later in this post.

Does our `clip` script work? Let's try it out.

        $ echo test | clip
        $ echo "hello\nthere\nmatey" | clip
        $ cat ~/Dropbox/clip.txt
        ♕
        test
        ♕
        hello
        there
        matey

Looks like it works!

**TIP**: I placed my `clip` script in `~/bin`, which is on my zsh path.

#### Reading from the Clipboard with the "lastclip" Script

Now that we can write items to the clipboard, let's write a script to read the last item.

```bash
#!/bin/zsh
CLIPBOARD=${CLIPBOARD:=~/Dropbox/clip.txt}       #1
cat $CLIPBOARD | tac - | awk '/♕/{exit}1' | tac  #2
```

1. Again, we provide a default for the `CLIPBOARD` environment variable.
2. We use `tac` to reverse the contents of the clipboard file so that we scan it from end to beginning, look for the first White Queen with `awk`, and then run `tac` again on the matching item so that if it has multiple lines they are sorted correctly again.

Let's test it out! I've saved this script as `~/bin/lastclip`, again because `~/bin/` is on my path.

```bash
    $ lastclip
    hello
    there
    matey
```

It worked! Okay, now we need to get this output into the iOS system clipboard.

#### Getting the Clipboard Contents Using Blink Shell

As with the section on [using a running X Windows session](#with-a-running-x-window-session), you know that the Blink Shell app gives you access to a local shell on iOS with a few commands.

Among these commands are `ssh` and `pbcopy`. Using these, we can pipe the last clipboard item from the Linux server into the iOS system clipboard.

In the following screenshot, I use Blink to execute the `lastclip` command on the remote server (I've named my server "dracula" because I like monsters, not because I view this entire exercise as a waste of time and money) and pipe its contents to `pbcopy` on iOS.

%% Screenshot

Then, as shown in the next screenshot, I can switch to Apple Notes and use the Command-V keyboard shortcut to paste from the iOS system clipboard. Thanks to `pbcopy`, the content of the clipboard is the last clipboard item from the remote server, which gets pasted into Notes.

%% Screenshot

Success! It just took a couple of shell scripts, a $20 SSH app, and manual intervention to run the command! What it lacks in convenience it makes up in satisfaction, right?

#### Getting the Clipboard Contents Using the Shortcuts App

As in the [initial Shortcuts example](getting-the-clipboard contents-using-the-shortcuts-app), you can use the Shortcuts app to create a shortcut to perform roughly the same action.

The only difference is that the SSH command to run is `lastclip`.

%% Screenshot

And as mentioned before, if you would like to be a wizard you can give it a "Siri Phrase" that sounds like magic, like "exemplum."

## Interlude: Removing the Manual Step

Having to manually run a Shortcut or `ssh` command to copy the clipboard to iOS is weak.

Wouldn't it be great if you could store the clipboard in Dropbox or iCloud Drive and watch for changes in that file from iOS, then run either the Blink command or Shortcut when the file changed?

Wouldn't it be _so great_ if the `clip` script could publish events to a remote log that iOS devices could subscribe 

blinkshell://run?cmd="ssh+dracula+lastclip+|+pbcopy"

## Interlude: How Best to Use the "clip" Script

So far, we have done some interesting things. Having to manually 

## When the Machine is Running macOS

Having covered possibilities for getting the contents of a "clipboard" from a remote Linux machine into the local iOS clipboard, let us examine the options for doing so if the remote machine is instead running macOS.

### The Woes of pbcopy

If you are connecting from an iPad to a Mac, you might think that the "Universal Clipboard" feature of iOS and macOS will save you, but it won't. The macOS tool most similar to `xsel` is `pbcopy`, which allows you to pipe command line output into the macOS clipboard. However, `pbcopy` doesn't sync with other devices over Universal Clipboard, so if you copy a line in Vim or tmux (the tools I use) on a remote Mac, that text won't be in the clipboard of your iPad running SSH.



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



## The Woes of pbcopy

If you are connecting from an iPad to a Mac, you might think that the "Universal Clipboard" feature of iOS and macOS will save you, but it won't. The macOS tool most similar to `xsel` is `pbcopy`, which allows you to pipe command line output into the macOS clipboard. However, `pbcopy` doesn't sync with other devices over Universal Clipboard, so if you copy a line in Vim or tmux (the tools I use) on a remote Mac, that text won't be in the clipboard of your iPad running SSH.

Can we do better? Yes -- sort of...?

## The Simplest Solution that Could Possibly Work

Before we write any code, what's the simplest solution to this problem that could possibly work? The best I've found is a combination SSH, `pbcopy`, and `pbpaste`. This solution only applies in the following situation:

- You are using iOS or macOS as the client
- You are using macOS as the server

This is pretty simple, it's Mac-only, and it requires you to manually sync the clipboard.

On the server, you 

