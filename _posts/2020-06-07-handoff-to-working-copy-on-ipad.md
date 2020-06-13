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
  - iOS
  - technology
image:
  feature: garage.jpg
manual_newsletter: false
---
This tip scratches an itch that I sometimes have while writing code on an iPad.

Usually, I write code on a remote server using Vim. About the only touch interactivity that I get with Vim over SSH is scrolling, which my terminal emulator Blink must send as an ANSI control sequence that Vim understands.

You can see in this video that it’s ... not nothing.

<div class="full-size-wrapper">
    <video autoplay loop muted class="full-size">
        <source src="/assets/video/vim-scroll-ssh.mp4" type="video/mp4">
    </video>
</div>

I like to _write_ code in Vim, but when I’m just reading through code on an iPad? In that case, Working Copy is my jam. The app has a great search feature and exposes a touch-native interface to Git.

So how hard is it to tell Vim to hand off the file I’m editing to Working Copy on my iPad?

Thanks to X-Callback URLs, this is pretty easy. Here are the moving parts:

1. A custom Vim command that builds a Working Copy X-Callback URL for the Git repository and file in the current Vim buffer.
2. An iPad Shortcut that opens an X-Callback URL from the system clipboard.

**Important note**: This technique depends on you being able to copy text from Vim to your iPad's clipboard via SSH. Read [my post](https://andrewbrookins.com/technology/copying-to-the-ios-clipboard-over-ssh-with-control-codes/) to learn how to do this if you haven’t yet.

## Building a Working Copy URL from Vim

I use Vim, so I'm going to detail a Vimscript function to build the Working Copy X-Callback URL that you need to open your current file in Working Copy. However, if you use Emacs you can easily adapt this function to elisp.

Here it is:

```vimscript
function! BuildWorkingCopyUrl()
    let url = "working-copy://open?repo=" . systemlist("basename `git rev-parse --show-toplevel`")[0] ."&path=" . fnamemodify(expand("%"), ":~:.")
    call Yank(url)
endfunction

```

Working Copy supports an "open" command via the X-Callback URL `working-copy://open?repo=<repo-name>&path=<path-to-file>`. We use `git rev-parse --show-toplevel` to get the base repository name, and then a Vim command to get the filename in the current buffer. 
    
Finally, we call the `Yank()` function. I won't detail `Yank()` because I spent an entire blog post on it already. However, you should know that this copies the URL into the *iPad*'s clipboard.

I bind this function to a leader-key-prefixed keybinding:

```vimscript
    nnoremap <silent> <Leader>wc :call BuildWorkingCopyUrl()<CR>

```

So now if I want to hand off a file to Working Copy, I press `,wc` and then run an iPad shortcut. Let's talk about that Shortcut next.
    
## The Shortcut

This is the easy part! Once you can copy text into the iPad clipboard from a remote machine, you can do all kinds of stuff with it.

**Note**: If you haven't used Shortcuts before, they're iOS's visual programming system. Think Automator meets Scratch. I'm not going to delve into how they work, so look up a tutorial and play around if you're lost at this point.

You're going to create a new Shortcut with a single Action. Search for "callback" and select the "Open X-Callback URL" Action. Then in the choice section after the word "Open" choose "Clipboard".

Save the Shortcut and give it a search-friendly name. I named mine 2workingcopy.

<img src="/images/callback-shortcut.PNG">

## The Final Product

Once you have a Shortcut, to do the handoff you’ll run your function in Vim first. That’ll copy the Working Copy X-Callback URL to the iPad’s clipboard. Then you can run your Shortcut from the home screen, the Dock (⌘ + Option + D), or from Spotlight (⌘ + Space).

<div class="full-size-wrapper">
    <video autoplay loop muted class="full-size">
        <source src="/assets/video/handoff-working-copy.mp4" type="video/mp4">
    </video>
</div>

Wrapping up: This is an example of the fun stuff you can do by combining access to the iPad’s clipboard from a remote system with X-Callback URLs and Shortcuts. Poke around and see what else you can automate — then let me know if you find anything cool!
