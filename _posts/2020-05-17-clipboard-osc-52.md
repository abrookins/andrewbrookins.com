---
title: "Copying to the iOS Clipboard Over SSH with Control Codes"
date: 2020-05-19
author: Andrew
layout: post-dark
permalink: /technology/copying-to-the-ios-clipboard-over-ssh-with-control-codes/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Fiction
image:
  feature: 
manual_newsletter: false
---

Today, let's delve into how you can copy text into the iOS clipboard from a remote computer over SSH.

Does this sound familiar? It should if you follow my iOS posts because I recently covered [one way to do this](https://andrewbrookins.com/technology/synchronizing-the-ios-clipboard-with-a-remote-server-using-command-line-tools/) using a custom script.

This time, we'll look at a better approach.

## Who Needs This?

Typically, if you're a programmer working on a remote computer, you want to be able to copy text into the iOS clipboard.

## The Yank Script

It turns out that the Blink app can do this using a terminal control sequence called OSC 52. If you configure the remote computer to emit this code, Blink will copy text from the that computer into the iOS clipboard.

There's a script called `yank` that works well for this. [Check it out](https://github.com/sunaku/home/blob/master/bin/yank) -- it's pretty short.

You'll drop that script into a directory on your PATH, on the remote computer, and make it executable.

Here, assuming you have a `~/bin` directory like I do, which is on your PATH, you could do the following:

    wget -O ~/bin/yank https://raw.githubusercontent.com/sunaku/home/master/bin/yank

## Configuring tmux
So what can you do with this? I use tmux and vim, so I configured both tools to pipe copied text to the yank script.

With newer versions of tmux, that looks like this:

   bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'yank > #{pane_tty}'
   bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'yank > #{pane_tty}' 

In my case, I use vi key bindings for tmux's copy commands, and I've configured these commands to pipe the selected text to the yank script.

## Configuring Vim

To configure vim, I created a special vim key binding. The binding pipes whatever I've selected to the "yank" script, which, again, tells Blink to copy that text.



Let's see this actually working.

Check it out - here's me copying from tmux.

And you can see it copied into my iOS clipboard because I was able to paste the copied text using Command-V on my external keyboard.

Now let's try vim. I select some text, and then run my special key binding.

And you can see it copied the text because, once again, I was able to paste it.

Now, there are two things you should know about using the OSC 52 control sequence for copying and pasting.

First is that the Blink app only supports this sequence over SSH, not mosh, which is otherwise known as the mobile shell.

Second, the maximum number of bytes you can copy is 74,994. That’s about 75 kilobytes.

And that's all I've got! OSC 52 is pretty cool, and I hope we get support for using it over Mosh in Blink soon. In the meantime, it's a simple solution for copying and pasting over SSH.

