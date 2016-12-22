---
id: 776
title: 'Make Sublime Text 2 More like Vim: Wrap Code, Go To Last Edit, Jump Back, and More'
date: 2012-01-19T06:16:46+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=776
permalink: /tech/make-sublime-text-2-more-like-vim-wrap-code-goto-last-edit-and-more/
aktt_notify_twitter:
  - 'no'
amazon_search:
  - sublime text
categories:
  - Technology
---
I&#8217;ve been trying out Sublime Text 2 as a replacement for Vim. While I enjoy using it and I experienced the &#8220;Wow, this does 90% of what Vim does&#8221; moment, I kept a running list of all the features in the remaining 10% that I relied on every day.

These included:

  * Better code wrapping (`gq`)
  * Go to last edit (`'.`)
  * Go to file in Ack search output
  * Display full path to current file (`:echo expand('%:p')<CR>`)
  * Jumping back and forward through files

However, Sublime Text 2 has a great Python API and I was able to whip up plugins for these tasks that perform just as well as in Vim.

_Update_: I also found the navigationHistory plugin, which does a pretty good job of back/forward jumps.

_Update_: The following plugins may not work with Sublime Text 3. If you’d like to donate some money to help me update them, you can [do so here](http://www.gofundme.com/2qtxgg). And patches are always welcome, of course.

## <span id="Better_code_wrapping">Better code wrapping</span>

Vim&#8217;s reformat text command (`gq`) can take multiple paragraphs and text in comments and flow them to the current textwidth setting. Some people don&#8217;t care about this, but I prefer to keep lines of code less than 80 characters wide, so I can open multiple files side-by-side. (Also, Pep-8.)

Sublime Text 2 had a &#8220;wrap&#8221; feature, but it failed to intelligently wrap comments, it joined separate paragraphs together and it wouldn&#8217;t reflow selected text (only the paragraph around the cursor).

The plugin I wrote creates a Wrap Code command (mapped to `gq` in Vintage mode) that works reasonably on commented lines of code (and uncommented lines), multiple paragraphs and selected text, thanks to the `codewrap.py` module written by Nir Soffer.

[Download the WrapCode plugin on Github.](https://github.com/abrookins/WrapCode)

## <span id="Go_to_the_last_edit_location">Go to the last edit location</span>

I&#8217;m used to typing `'.` in a buffer in Vim to move the cursor to the last edit. Great feature. Totally underrated.

If you use Vintage mode in Sublime Text 2, you&#8217;ll quickly discover that this command does nothing &#8212; worse than nothing, in fact, as it seems to refocus your cursor somewhere other than the text of the buffer, forcing you to use your mouse to recover.

While I couldn&#8217;t bind my plugin to the `'.` command without forking Vintage mode, I bound it to `Super+'` and it works the same as Vim&#8217;s.

[Download the GotoLastEdit plugin on Github.](https://github.com/abrookins/GotoLastEdit)

## <span id="Easily_open_search_results">Easily open search results</span>

Another thing I missed about Vim was its Ack plugin. The &#8220;Find in Files&#8221; feature of Sublime Text 2 is great, but it didn&#8217;t provide an easy way to quickly open a file listed in the search results via the keyboard (you can double-click on a line to open it, though).

So I wrote a plugin that, in a Search Results window, allows you to do one of the following via the keyboard:

  * On a &#8220;matched&#8221; line in the search output, open its file at the line of the match
  * On a file path in the search output (without a line number), open the file in a new tab

[Download the OpenSearchResult plugin on Github.](https://github.com/abrookins/OpenSearchResult)

## <span id="Display_full_path_to_file_in_status_bar">Display full path to file in status bar</span>

I use Vim in OS X&#8217;s full screen mode, with no tabs or status line. Working this way, I don&#8217;t have reference to the path of the current file. Of course, I know the name of the file because I usually typed it, but sometimes the full path is important; e.g., if I have two Mercurial branches of the same code in different directories.

So, I have a command mapped to `,F` that displays the full path. Then it silently goes away after a moment. I love that command.

I couldn&#8217;t find an ideal way to implement this in Sublime Text 2, other than to create a command that would toggle displaying the path to the current file in the status bar. It works well enough for me, however.

[Download the FilenameStatus plugin on Github.](https://github.com/abrookins/FilenameStatus)

## <span id="Jumping_back_and_forward">Jumping back and forward</span>

One of Vim&#8217;s most awesome features is Control-O/Control-I to jump back and forward &#8212; maybe I can generalize to say that _all_ of Vim&#8217;s jump commands are part of its &#8220;killer app&#8221; status.

Sublime Text 2 doesn&#8217;t have a feature like this, but someone on the internet has packaged a version of Martin Aspelli&#8217;s `navigationHistory` plugin, which comes close.

[Download the navigationHistory plugin on Github.](https://github.com/marram/sublime-navigation-history)

## <span id="Installing_the_plugins">Installing the plugins</span>

You install these plugins the same way as other Sublime Text 2 plugins, by downloading the files and dropping them into the Packages directory.

See [this documentation](http://sublimetext.info/docs/en/extensibility/plugins.html) for more details if you need additional help installing plugins.

The default key bindings are intended for Vintage mode and are oriented for OS X.