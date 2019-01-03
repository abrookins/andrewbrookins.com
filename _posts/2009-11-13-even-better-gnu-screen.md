---
id: 271
title: Even Better GNU Screen
date: 2009-11-13T09:46:00+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=271
permalink: /tech/even-better-gnu-screen/
categories:
  - Technology
---
GNU Screen is one of my favorite applications because of its simplicity and usefulness. And, as a fairly new user, I am constantly discovering features and awesome ways to interface it with my systems.

Following are some tips and links I&#8217;ve picked up that have vastly improved my screen experience, including how to save region placement, how to use zsh to save history across multiple shell sessions, and how to use ssh-agent with screen to ease remote access.

But before we get into the meat, let&#8217;s talk vocabulary (taken from the GNU docs):

A **screen session** is opened when you launch GNU Screen by typing `screen` in a (pseudo)terminal or via a script.

A **window** is a shell session opened inside of screen when you begin a new screen session or manually open a window with the `^a c` command (that&#8217;s `Control-a` [pause] `c`).

A **region** is a portion of one window that displays the contents of another window. IE, a horizontal or vertical split.

Okay, with vocab out of the way, let&#8217;s get started!

### <span id="Saving_Region_Placement">Saving Region Placement</span>

I was lurking in #screen on Freenode one day when I picked up this handy tip. To save the placement of your vertical and horizontal window splits, just use nested screen sessions.

First, log in to a shell (via ssh, a terminal window, etc.), then open a screen session using the `screen` command.

Inside of screen, open three or four windows (with `^a c`) &#8212; one for each of the windows you want to save the placement of. I usually open windows for `irssi`, `htop` and `iptraf`, for example.

Now, detach the screen with `^a d`. You&#8217;re back at the shell. Verify that screen is still running with the `screen -ls` command, and save the ID number of the session (which appears before `.[terminal].[hostname]`.

For example:

`andrew@levin:~$ screen -ls`

There are screens on:

6718.pts-0.levin (02/08/2009 08:40:36 AM) (Multi, attached)

Here, the ID of the session is 6718.

To begin nesting, open a new screen session by typing `screen` again. Then, use the ID of the first session to reconnect to that session from within the second session (you can verify that two sessions are now running with the `screen -ls` command):

`andrew@levin:~$ screen -ls`

There are screens on:

31333.pts-0.levin (02/08/2009 08:40:36 AM) (Multi, attached)

6718.pts-0.levin (02/03/2009 09:43:53 PM) (Multi, detached)

2 Sockets in /var/run/screen/S-andrew.

`andrew@levin:~$ <strong>screen -r 6718</strong>`

And there you go &#8212; you have just nested one screen session within another.

Now, you can setup your vertical and horizontal window splits, AKA regions, in the first screen session and the settings will persist in the second session until the computer shuts down, the session dies, or you readjust the splits.

**Caveat**: Each nested session incurs an additional `a` in your command sequence.

So, demonstrating the previous example, to setup your persistent splits in the nested session, you would hit: `^a a |` for a vertical split or `^a a s` for a horizontal split.

Or, to tab between regions in the nested session, hit: `^a a tab` (as opposed to switching in the first layer, which would be `^a tab`).

Finally, to swtch windows in the nested layer, hit `^a a [window number]` (IE, `^a a 1`) if you know the identifier for the window, or `^a a "` to list all opened windows.

That&#8217;s it!

### <span id="Zsh__Screen_Common_Shell_History">Zsh Screen = Common Shell History</span>

How many times have I searched my shell history for a recent command only to remember that I executed it in another screen session or window?

The amazing zsh, an excellent replacement for bash, eases command reuse in screen by allowing you to share command history among all shell sessions.

The .zshrc options to do this are `setopt SHARE_HISTORY` and `setopt APPEND_HISTORY`.

For more info on this and other history-related options for your .zshrc, check out [this primer](http://www.acm.uiuc.edu/workshops/zsh/related/hist_expn.html) and some examples at [dotfiles.org](http://dotfiles.org/.zshrc)<a>. Try </a>[urukrama&#8217;s .zshrc file](http://dotfiles.org/%7Eurukrama/.zshrc) to start things off.

### <span id="Ssh-agent__Screen_Easy_Remote_Login">Ssh-agent Screen = Easy Remote Login</span>

The last tip is to setup screen to work with ssh-agent, which will let you more easily connect to systems onto which you&#8217;ve installed a (password encrypted) key. MBrisby will take us out on this one: [GNU screen w/ ssh-agent](http://mbrisby.blogspot.com/2007/07/gnu-screen-w-ssh-agent.html).

### <span id="More_Screen_Love">More Screen Love</span>

For an intro to screen, see Jonathon McPherson&#8217;s [excellent how-to](http://jmcpherson.org/screen.html).

For more great screen tricks (including some good ones I use every day), check out Phil Sung&#8217;s 2008 [blog post](http://psung.blogspot.com/2008/10/stupid-screen-tricks.html).

Happy screening!

GNU Screen is one of my favorite applications because of its simplicity and usefulness. And, as a fairly new user, I am constantly discovering features and awesome ways to interface it with my systems.

Following are some tips and links I&#8217;ve picked up that have vastly improved my screen experience, including how to save region placement, how to use zsh to save history across multiple shell sessions, and how to use ssh-agent with screen to ease remote access.

But before we get into the meat, let&#8217;s talk vocabulary (taken from the GNU docs):

A **screen session** is opened when you launch GNU Screen by typing `screen` in a (pseudo)terminal or via a script.

A **window** is a shell session opened inside of screen when you begin a new screen session or manually open a window with the `^a c` command (that&#8217;s `Control-a` [pause] `c`).

A **region** is a portion of one window that displays the contents of another window. IE, a horizontal or vertical split.

Okay, with vocab out of the way, let&#8217;s get started!

### <span id="Saving_Region_Placement-2">Saving Region Placement</span>

I was lurking in #screen on Freenode one day when I picked up this handy tip. To save the placement of your vertical and horizontal window splits, just use nested screen sessions.

First, log in to a shell (via ssh, a terminal window, etc.), then open a screen session using the `screen` command.

Inside of screen, open three or four windows (with `^a c`) &#8212; one for each of the windows you want to save the placement of. I usually open windows for `irssi`, `htop` and `iptraf`, for example.

Now, detach the screen with `^a d`. You&#8217;re back at the shell. Verify that screen is still running with the `screen -ls` command, and save the ID number of the session (which appears before `.[terminal].[hostname]`.

For example:

`andrew@levin:~$ screen -ls`

There are screens on:

6718.pts-0.levin (02/08/2009 08:40:36 AM) (Multi, attached)

Here, the ID of the session is 6718.

To begin nesting, open a new screen session by typing `screen` again. Then, use the ID of the first session to reconnect to that session from within the second session (you can verify that two sessions are now running with the `screen -ls` command):

`andrew@levin:~$ screen -ls`

There are screens on:

31333.pts-0.levin (02/08/2009 08:40:36 AM) (Multi, attached)

6718.pts-0.levin (02/03/2009 09:43:53 PM) (Multi, detached)

2 Sockets in /var/run/screen/S-andrew.

`andrew@levin:~$ <strong>screen -r 6718</strong>`

And there you go &#8212; you have just nested one screen session within another.

Now, you can setup your vertical and horizontal window splits, AKA regions, in the first screen session and the settings will persist in the second session until the computer shuts down, the session dies, or you readjust the splits.

**Caveat**: Each nested session incurs an additional `a` in your command sequence.

So, demonstrating the previous example, to setup your persistent splits in the nested session, you would hit: `^a a |` for a vertical split or `^a a s` for a horizontal split.

Or, to tab between regions in the nested session, hit: `^a a tab` (as opposed to switching in the first layer, which would be `^a tab`).

Finally, to swtch windows in the nested layer, hit `^a a [window number]` (IE, `^a a 1`) if you know the identifier for the window, or `^a a "` to list all opened windows.

That&#8217;s it!

### <span id="Zsh__Screen_Common_Shell_History-2">Zsh Screen = Common Shell History</span>

How many times have I searched my shell history for a recent command only to remember that I executed it in another screen session or window?

The amazing zsh, an excellent replacement for bash, eases command reuse in screen by allowing you to share command history among all shell sessions.

The .zshrc options to do this are `setopt SHARE_HISTORY` and `setopt APPEND_HISTORY`.

For more info on this and other history-related options for your .zshrc, check out [this primer](http://www.acm.uiuc.edu/workshops/zsh/related/hist_expn.html) and some examples at [dotfiles.org](http://dotfiles.org/.zshrc)<a>. Try </a>[urukrama&#8217;s .zshrc file](http://dotfiles.org/%7Eurukrama/.zshrc) to start things off.

### <span id="Ssh-agent__Screen_Easy_Remote_Login-2">Ssh-agent Screen = Easy Remote Login</span>

The last tip is to setup screen to work with ssh-agent, which will let you more easily connect to systems onto which you&#8217;ve installed a (password encrypted) key. MBrisby will take us out on this one: [GNU screen w/ ssh-agent](http://mbrisby.blogspot.com/2007/07/gnu-screen-w-ssh-agent.html).

### <span id="More_Screen_Love-2">More Screen Love</span>

For an intro to screen, see Jonathon McPherson&#8217;s [excellent how-to](http://jmcpherson.org/screen.html).

For more great screen tricks (including some good ones I use every day), check out Phil Sung&#8217;s 2008 [blog post](http://psung.blogspot.com/2008/10/stupid-screen-tricks.html).

Happy screening!