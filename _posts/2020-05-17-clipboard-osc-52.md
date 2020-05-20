---
title: "Copying to the iOS Clipboard Over SSH with Control Codes"
date: 2020-05-19
author: Andrew
layout: post
permalink: /technology/copying-to-the-ios-clipboard-over-ssh-with-control-codes/
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

Let's delve again into copying text to the iOS clipboard from a remote computer over SSH.

Does this sound familiar? It should if you follow my iOS posts because I recently covered [one way to do this](https://andrewbrookins.com/technology/synchronizing-the-ios-clipboard-with-a-remote-server-using-command-line-tools/) using a custom script.

This time, we'll look at a better approach -- the OSC 52 control code.

<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed/s7PHeuMGZGI' frameborder='0' allowfullscreen></iframe></div>

## The Yank Script

It turns out that the [Blink app](https://blink.sh) can do this using a terminal control sequence called OSC 52. If you configure the remote computer to emit this code, Blink will copy text from the that computer into the iOS clipboard.

There's a script called `yank` that works well for this. [Check it out](https://github.com/sunaku/home/blob/master/bin/yank) -- it's pretty short.

You'll drop that script into a directory on your `PATH`, on the remote computer, and make it executable.

Assuming you have a `~/bin` directory like I do, which is on your PATH, you could do the following:

    wget -O ~/bin/yank https://raw.githubusercontent.com/sunaku/home/master/bin/yank

## Configuring tmux

So what can you do with this? I use tmux and Vim, so I configured both tools to pipe copied text to the yank script.

With newer versions of tmux, that looks like this:

```
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'yank > #{pane_tty}'
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'yank > #{pane_tty}' 

```

Translation: I use vi key bindings for tmux's copy commands, so I've configured these commands to pipe the selected text to the yank script.

## Configuring Vim

To configure vim, I created a key binding that pipes whatever I've selected to the "yank" script.

```
" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <C-c> y:<C-U>call Yank(@0)<CR>

```

I picked up this code directly from the [blog post where I first read about OSC 52](https://sunaku.github.io/tmux-yank-osc52.html), where you can find more snippets to use it.

## Limitations

Now, there are two limitations you should know about using OSC 52 for copying and pasting.

1. The Blink app only supports this sequence over SSH, not mosh.
2. The maximum number of bytes you can copy is 74,994, which is about 75 kilobytes.

I'm OK with both of these.

If you've used mosh on an iPad with an app link Blink or Termius, you'll know that it handles mobile networking better than SSH. However, if you already use tmux, reconnecting to a server and running `tmux -u a -d` to attach to your session is a minor annoyance.

I do hope we get support for using OSC 52 over mosh in Blink soon. In the meantime, I'm more than happy to use SSH and get working copy-paste!
