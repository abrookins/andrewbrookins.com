---
id: 974
title: 'An Epic Review of PyCharm 3 from a Vim User&#8217;s Perspective'
date: 2014-02-01T15:17:36+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=974
permalink: /tech/one-year-later-an-epic-review-of-pycharm-2-7-from-a-vim-users-perspective/
aktt_notify_twitter:
  - 'no'
lazyload_thumbnail_quality:
  - default
image: /wp-content/uploads/2013/06/code_completion.png
categories:
  - Python
  - Technology
---
This review is for the Professional Edition of PyCharm 3. I'll try to cut straight to the point while offering some tips from my experience.

My perspective is that of a professional software developer who has used Vim, Emacs, Sublime Text, PyDev and others. For the past year and a half I've used PyCharm for all my Python, JavaScript and CoffeeScript.

# <span id="Vim_emulation_with_IdeaVim">Vim emulation with IdeaVim</span>

I've discarded a lot of editors that claimed to have Vim emulation either built-in or through a plugin. PyCharm's is the best.

## <span id="Whats_good">What’s good</span>

The ex command line is slick, block cursor and line highlighting look great, modal editing is responsive and IdeaVim supports all of the motion commands I use on a regular basis. There is a good list of [all the Vim features the plugin supports](https://andrewbrookins.com/wp-content/uploads/2014/02/index.txt).

Some of the the newer changes are the addition of leader key support, which I was very excited about, and support for an `~/.ideavimrc` file that can have key mappings (`:map`, `:nmap`, `:imap`) and a [limited number](https://github.com/JetBrains/ideavim/blob/master/doc/set-commands.md) of `set` commands.

In addition to that, JetBrains is committed to Vim emulation. The company releases regular updates to IdeaVim, and the plugin has become much more feature-rich and reliable over time.

## <span id="What_needs_work">What needs work</span>

Custom keybindings have come a long way, but without a mappable leader they still work more like they do in Emacs and Sublime Text than in Vim. I don’t want to use backslash as my leader key, so I still end up combining Control, Command, Option (or Alt, Win, etc. on PCs) with various keys to produce unique sequences. I am confident that this will improve once we can [remap the leader key](https://youtrack.jetbrains.com/issue/VIM-650).

So, that's a drag, but I was once a hardcore Vim user and here I am, two plus years of PyCharm later, happy and satisfied.

See the Keyboard Shortcuts section for a more in-depth review of the keybinding system.

# <span id="Code_Completion">Code Completion</span>

Code completion was great in PyCharm 2.7 and it has only gotten better.

## <span id="Whats_good-2">What’s good</span>

There are now two types of completion in the editor: structural, which understands Python and JavaScript objects, and word expansion, which is more like Vim's omnicomplete. Both work very well.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/code_completion.png" alt="Code Completion" width="618" height="316" class="aligncenter size-full" />

With structural completion, PyCharm displays a modal dialog containing fields of an object's class first, followed by fields and methods of its superclasses and mixins. Once you trigger this completion dialog, you can type to filter the selection.

Word expansion is a new feature in PyCharm 3 that lets you complete symbols anywhere in the file, including comments and docstrings. Rather than being aware of a structure or object, the completion works through simple text matching. It's great for writing documentation.

I’ve always found Python completion features in other editors, usually built on the Rope library, slow or unreliable or both. PyCharm’s completion is intelligent and reliable, and works with JavaScript too. You really feel that you're using a well-engineered tool built for the future of programming — editing the meaning of code, not just text. And you can always fall back to simple word expansion when you need to.


## <span id="What_needs_work-2">What needs work</span>

My only request is that word expansion could work across all open files, like it does in Vim, rather than just the current file.

# <span id="Code_Navigation">Code Navigation</span>

What I mean by Code Navigation is the use of keyboard shortcuts that jump you to the definition of a symbol. PyCharm has a couple of these features &#8212; pretty much everything you'd hope from a Python IDE.

## <span id="Whats_good-3">What’s good</span>

The first is Goto Symbol, which opens a popup similar to the one provided for completion of fields on an object, except that it includes symbols across the entire project. I use this when I know where I want to go by name.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/symbol_completion.png" alt="Symbol completion" width="487" height="145" class=" aligncenter size-full" />

More often I use the Goto Declaration feature. This is available by moving your cursor over a symbol and firing a keyboard shortcut (I think it's also available as a mouse action.)

I use these features _all day, every day_ to review APIs and docstrings of library code I’m using. It’s indispensable and works consistently.

This is the feature I’ve had the most trouble getting other editors to do well. Vim and Sublime Text with the rope library, or Jedi, and some integration tweaks — or PyDev in Eclipse — can sometimes give you decent navigation. However, I’ve used all of these extensively and they all failed in some way every day.

With PyCharm, I don't even notice this feature anymore. I just expect to get wherever I want to go, and I do.

## <span id="What_needs_work-3">What needs work</span>

One snag I’ve run into is when using `tox`, which builds multiple sub-environments in a project’s directory, PyCharm will often pick up multiple instances of a symbol in a dependent library. This can sometimes get in the way of surgical `ipdb` debugging sessions (which I still do).

# <span id="Running_Tests">Running Tests</span>

PyCharm’s test runner helps me achieve an uninterrupted flow state while writing tests. It supports all of the testing libraries I've thrown at it, including the Django test runner, nose, Unittest and py.test.

## <span id="Whats_good-4">What’s good</span>

For what seems like a simple feature, it has a huge impact. I’ll try to explain by talking about my experiences with other editors.

You can get a nice system going with Vim or ST 2 and a bunch of plugins, but ultimately your workflow is something like “write tests, switch focus to command-line interface, execute the last command or type a new command to run a specific test or suite, examine output, switch focus back to editor.”

After using PyCharm, I find this workflow primitive and distracting.

In PyCharm, if I want to run a test I’m working on, I hit a keyboard shortcut that detects the test method or class my cursor is within and offers to run or debug it. In the dialog box that opens when I hit this keyboard shortcut I have several options for how to run the test, based on the test runners PyCharm finds for the configured interpreter (nose, Unittest, py.test, etc.). I can type the number of an option to run it.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/running_a_unit_test.png" alt="Running a unit test" width="617" height="429" class=" aligncenter size-full" />

Test output appears in a panel at the bottom of the window. If the test raises an exception, PyCharm converts each line of the stack trace into a hyperlink that opens the file in question at that line when I click on it.

Seems simple, right? After using these features for a year, I can’t live without them. Here’s why:

  * After the tests run, I can hit a keyboard shortcut to jump between the tests I ran (useful if some failed)
  * When I'm writing code, I can hit a keyboard shortcut that reruns the last test immediately (no context switch required)
  * I want to give JetBrains $100 just for turning lines of a stack trace into hyperlinks


## <span id="What_needs_work-4">What needs work</span>

At my day job, we use a `nose` test runner for our Django projects. PyCharm can’t understand that tests in these projects are Django tests, but that the test names should be in the format `nose` expects, not the Django test runner format. I can get around this by fiddling with `py.test` and telling PyCharm to run tests using `py.test`, but this is kludgy.

# <span id="Debugging">Debugging</span>

At first I wasn’t super impressed with using PyCharm’s graphical debugger, compared to my experience with `ipdb`. It’s grown on me over time, though, and now when I try to use `ipdb` I feel that old sadness for Primitive Humanity.

## <span id="Whats_good-5">What’s good</span>

PyCharm lets you set a breakpoint with the mouse or a keyboard shortcut. When you run project code with the debugger, either using a test or a Run action like the Django development server, a special toolbar window slides into view with the debugging context when execution hits your breakpoint.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/debugging_python.png"  alt="Debugging Python" width="734" height="741" class=" aligncenter size-full" />

You can then interact with each frame on the stack by clicking on a list of frames in the debugging panel. A "Variables" tree lets you view the state of each variable in the scope of the current frame.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/debugging_python.png" alt="Debugging Python" width="734" height="741" class=" aligncenter size-full" />

You can also run arbitrary code within the scope of the frame by using the “Evaluate Expression” command (available via keyboard shortcut), or run an interactive console session similar to `ipdb`.

The Evaluate Expression command opens a modal dialog box. The “result” portion of the dialog shows the return result of the expression after you click “Evaluate.” You see the exception class of any exception raised by the expression, but not a stack trace. “Code Fragment Mode” lets you write more than one line for your expression.

The interactive console is useful because you can see standard output (you can't in Evaluate Expression):

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/debugger_interactive_console.png" alt="Debugger interactive console" width="593" height="510" class=" aligncenter size-full" />

In summary, I like the PyCharm debugger better than ipdb because it helps me to avoid switching contexts. With Evaluate Expression, I can remain in a flow state while I debug failing tests, using only keyboard shortcuts. This beats switching to a terminal window and interacting with ipdb. 

## <span id="What_needs_work-5">What needs work</span>

While there is a keyboard shortcut to launch Evaluate Expression, I haven’t found one for the interactive console, which seems to require two mouse clicks (ugh!).

# <span id="Code_Generation">Code Generation</span>

PyCharm has a feature called Intention Actions that provide automated solutions to problems the editor detects in your code. These include using a symbol that isn’t found in the current scope, improper return values and small refactors that can make your code better, among other things.

According to the docs, there are three types of Intention Actions: “Create from usage” (missing symbols), “Quick fixes” (problems your in your code) and “Micro-refactorings” (e.g. convert lambda into function def).

## <span id="Whats_good-6">What’s good</span>

When an intention action is available, you will see an indicator in either the status bar on the bottom of the window, the text itself (if it’s a syntax error or unresolved symbol) or both. Then you can use a keyboard shortcut to trigger a menu of actions available. Doing so is reliable and smooth:

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/intention_action_menu.png" alt="Intention action menu" width="581" height="240" class=" aligncenter size-full" />

While you can use intention actions to create class, class method and function stubs, I don’t often do this. I do regularly use them to fix errors and add import statements.



The result is that I feel like I'm pair programming with an observant coworker who has memorized Python syntax, a small dictionary and PEP8.

## <span id="What_needs_work-6">What needs work</span>

This feature is pretty tight. It could be slightly better if the editor offered to fix antipatterns or offered deeper intelligence in some way.

# <span id="Error_Detection_and_Resolution">Error Detection and Resolution</span>

PyCharm detects several types of errors in your code and will offer to fix them for you through the Intention Action feature. These include the types of errors that you probably already use `pylint` to check for in your editor of choice: syntax errors and PEP8 violations. It also detects spelling mistakes with what appears to be a very limited dictionary.

## <span id="Whats_good-7">What’s good</span>

The main takeaway from this feature is that checking happens in a background thread, so unlike with Vim and syntastic or other editors, passive error checking doesn’t lock the UI.

Beyond simple syntax checks and linting, the editor understands Python in the sense that it can detect common design mistakes, like not closing a resource, and offer automated solutions. It can also detect alternative style choices, like single-versus-double quotations, and offer to change between them.

Erroneous statements are underlined with a red squiggly line by default, but this is configurable. One of the options in the Intention Action menu for an error is to silence it. You can also configure whether PyCharm should check for spelling errors in code, or in comments only (or never).

This is a great feature that looks exactly the same as Intention Actions in “Code Generation.” As with that feature, it feels like working with a pedantic-yet-helpful pair programmer.

# <span id="Refactoring">Refactoring</span>

PyCharm is great at automating several annoying refactoring processes, like renaming methods, variables and modules that may have dozens or hundreds of usages across a project.

## <span id="Whats_good-8">What’s good</span>

This is doable with ack (or grep) and Vim. But would I want to go back to that life? No. Here’s why. Let’s say I want to rename a method with a name like “add” that’s guaranteed to give me false positives from a text-based search like grep. In PyCharm I trigger the refactor menu with a keyboard shortcut:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/refactor_this_menu.png)</figure> 

Alright, great. I have tons of refactoring options. I’m only going to show renaming because that is what I do the most. So, I hit the Enter key on “Rename…” and I’m asked for the new name:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/rename_method_dialog.png)</figure> 

What’s that “Preview” button? Oh, it’s just a sweet tree containing all the occurrences of the symbol.<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/refactor_preview_pane.png)</figure> 

From the preview, I can right-click on any branch of the tree and exclude all sub-items from the operation. There’s a button at the bottom (not in the screenshot) that lets me cancel or do the refactor.

If I want to undo the refactor, all of the changes are rolled up into a single undo, and I get a special dialog box (“Undo renaming method to add_please?”).

This feels like the future of programming. Seriously. I believe that the industry will continue to build development environments that have a deep understanding of how languages, frameworks and platforms work. PyCharm’s refactoring tools feel like just the tip of this iceberg, and yet they still blow away the alternatives. And you can refactor JavaScript, too.

## <span id="What_needs_work-7">What needs work</span>

Nothing. It’s awesome.

# <span id="Pip_and_Virtualenv_Integration">Pip and Virtualenv Integration</span>

Virtualenv and Pip support are woven into PyCharm, and both work pretty well. When you first open a directory of Python code, the editor warns you that the project lacks a Python interpreter. At that point you can choose to use the system Python or a virtualenv Python.

## <span id="Whats_good-9">What’s good</span>

If there is a `requirements.txt` file in the project, PyCharm will check to see if the interpreter contains all of the referenced libraries, and if it doesn't, a warning will flash on screen that offers to download the missing packages for you. That’s handy.

When a project uses a non-standard requirements file name (or multiple requirements files), you can set the name of the requirements file in the Python Integrated Tools section of the settings window.

Because PyCharm knows about Python interpreters, when you create Run actions (or run an automatically created one, e.g. for a test) you can choose which interpreter the action should use. The default is the currently configured project interpreter.

## <span id="What_needs_work-8">What needs work</span>

I’ve heard that PyCharm can detect which virtualenv to use for a project. This probably relies on you having created the virtualenv inside of the project directory structure, which I don't do. I have my virtualenvs in `~/envs` and my source in `~/src`, so I manually configure a Python interpreter for new projects. It's still pretty convenient.

# <span id="Keyboard_Shortcuts">Keyboard Shortcuts</span>

Almost every command in PyCharm has a keyboard shortcut, even some of the commands that might seem available only from the top-screen menus. Many of these are not configured out-of-the-box, so you stumble upon them like lost treasure.

## <span id="Whats_good-10">What’s good</span>

PyCharm includes two features that make finding, using and remapping keyboard shortcuts easy.

The Find Action command (Shift+Command+A on OS X) opens up a searchable menu of commands and options alongside of which is the first currently-mapped keyboard shortcut for the found item. You can run the command anytime — useful when you’re trying to remember the shortcut for a command. This is probably one of the most important features for new users to PyCharm. I encourage you to spend some quality time with it!

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/Find-Action1.png" alt="Find Action" width="1014" height="922" class="alignleft size-full wp-image-1309" />](https://andrewbrookins.com/wp-content/uploads/2014/02/Find-Action1.png)

You configure keyboard shortcuts in the Keymap section of the settings window. The list of available commands is filterable, which helps if you have a vague idea of what you want to do, like "window" or "project," but in my experience you often need to do some internet research to find commands first. Changes you've made from a default keymap are highlighted in blue when you return to the Keymap section.

Once you find a command you want to map or remap, you double-click on it to bring up a context menu. The menu lets you remove a keybinding or add a new one. You can add multiple shortcuts to a single action and multiple commands can have the same shortcut. It’s OK if some shortcuts overlap because not all commands are available all the time, giving you more available key combinations depending on what window (or tool window) is open. If your chosen shortcut is already in use, the editor will warn you and give a list of all the commands that overlap.

## <span id="What_needs_work-9">What needs work</span>

Until recently, there was no way to create keyboard mappings based on the editing mode you were using with IdeaVim (insert, normal mode), and there was no leader key, so all keyboard shortcuts were available all the time — except ones that were only available when a certain tool window was open. Since keyboard shortcuts are like a programming language for your editor, this means you’re stuck with a terrible one with namespace support, like PHP 4.

IdeaVim now supports modal remapping via the `~/.ideavimrc` file, documentation is a little sparse on that and I haven’t dived in yet. It supports a leader key, too, but it’s stuck at ‘’ instead of my preferred ‘,’ so I’ve yet to make use of it.

# <span id="Tab_Split_and_Window_Management">Tab, Split and Window Management</span>

When it comes to splitting the editor into multiple panes, there’s good news and there’s bad news.

## <span id="Whats_good-11">What’s good</span>

PyCharm supports arbitrary window splits in a way that's more intuitive than Sublime Text and somewhat less so than Vim. Typically you’ll have each project open in a separate window, but you can also yank a tab into its own window or detach one of the many different tool panels into a separate window.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/horizontal_split.png" alt="horizontal_split" width="804" height="815" class=" aligncenter size-full" />

PyCharm represents an open file with a tab. I don't use tabs with Vim, so at first it seemed like JetBrains had dumped something foul in my cereal. Tabs have grown on me since then, in large part because the tools the editor includes for jumping between open and recent files mean I don't pay much attention to tabs except when I really need to.

You can configure the editor to either keep adding new rows of tabs as your number of open files fills the current window, or to hide tabs that don't fit. If you let it hide tabs, a small button appears in the upper-right corner of a window when some tabs are hidden. You can click on the button to see a list of hidden tabs. When you use a hidden file, its tab comes out of hiding and an older tabs is hidden in its place.

If you desire ruthless efficiency, you can set a “tab limit” that defaults to ten. If you open more than that number of tabs, PyCharm start closing old ones. You have a couple of options for the tab-closing strategy.

## <span id="What_needs_work-10">What needs work</span>

The bad news is that window splits are not quite the smooth-as-butter experience that you get with Vim. The biggest problem I have is with how PyCharm handles opening a file by name (through the Navigate to File command) from a split when the file is already "open" in another split.

If you do this, your cursor will jump to whatever split the file is already open in. Vim would open the file in the current split, which is the behavior I’ve come to expect. I get why they did it, but I'd prefer this to be a configuration option.

As for windows, PyCharm is a modern OS X application, unlike Vim and even MacVim, so you can have files from multiple projects open in multiple windows galore and it properly tracks the project context for each window.

# <span id="Jumping_to_Open_and_Recent_Files">Jumping to Open and Recent Files</span>

In Vim and Emacs I used plugins like bufexplorer and ibuffer (respectively) to get an overview of open files and to quickly switch back and forth between them. PyCharm’s equivalent features are decent but imperfect.

## <span id="Whats_good-12">What’s good</span>

You can trigger a pop-up containing a list of recently-accessed files (using a keyboard shortcut, naturally). This list is searchable and defaults to the last file you had open. If you start typing, it filters down the list of items.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/recent_files.png" alt="recent_files" width="415" height="454" class=" aligncenter size-full " />
  
<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/searching_for_recent_files.png" data-lazy-type="image" alt="searching_for_recent_files" width="380" height="405" class="aligncenter size-full" />

This is great because I don’t keep track mentally of all 16 files I have open, so I get a helpful list that jogs my memory ("What was that one module I was looking at with the broken thing? Oh yeah.”).

You can also hone this down further with the Recently Edited Files command. This is just the subset of files you've edited in the past N minutes (I don't know how long).

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/recently_edited_files.png" alt="recently_edited_files" width="500" height="291" class=" aligncenter" />

Finally there's the Switcher command. This is similar to the Recent Files list except it operates on your open tabs. By default the keyboard shortcut on OS X is Control+Tab. Unfortunately it is _not_ searchable.

Using these — mostly the recent files list — has become muscle memory in the same way that Vim and Emacs’s buffer management commands did.

## <span id="What_needs_work-11">What needs work</span>

PyCharm needs to do a better job of separating the notion of files on disk with open files. There are plentiful commands to find and switch between files — recent files, recent files edited, files in the project, and so on. But I tend accumulate lots of open files, and I would appreciate an easy way to see a list of all those files, like the Switcher, that is searchable (which the Switcher is not).

# <span id="Jumping_to_Files_on_Disk">Jumping to Files on Disk</span>

Get ready because these features pack heat. Well, at least one of them does (the navigation bar — keep reading).

## <span id="Whats_good-13">What’s good</span>

PyCharm lets you jump to any file in the current project using a fuzzy search against the file name and path, like Sublime Text, Eclipse, Xcode and Vim with certain plugins. It works very well. The UI is similar to “Goto Symbol,” a list of partial matches that filters down as you modify your search text. I use this all day, when I’m not using the Recent Files menu to open files. One really nice thing about it is that with a small tap of a key in the result window you can see "non-project" items too &#8212; these are search results across the entire Python environment, including all of the project libraries. Very useful.

<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/goto_file.png" alt="goto_file" width="491" height="284" class=" aligncenter size-full" />

In PyCharm 3 there is also a new Search Anywhere command that combines searching for project symbols and filenames. I haven't fully transitioned to using this instead of the separate navigation commands because it doesn’t open reliably, but it seems useful.

If you like to see a tree of files, though, PyCharm has a comprehensive one that  
works better than Sublime Text's and NERDTree in Vim. You can easily show and hide the tree with a keyboard shortcut. When the tree is focused, typing filters the visible files. The UX on the filter is nicely done &#8212; matching item are highlighted, and only these are available when you use the up and down arrows.

Other than that, it probably looks like any old file tree, but its context menu is powerful! I don't know the keyboard shortcut to open the context menu, but you can see it by right clicking on a file (as usual).<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/file_tree_context.png)</figure> 

Honestly though, I don't use the tree often because there is something way better called the navigation bar. I’m not sure how to describe it other than that it’s like a keyboard-navigable breadcrumb file tree. I’ll have to show you. Here is what it looks like in its default position (I usually have it hidden by default):<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/navigation_bar_default.png)</figure> 

“Ugh, so crowded!” you probably thought. Yeah, I know, that’s why I have it turned off. But check this out — you can still activate a special floating version of the navigation bar with a keyboard shortcut. I have this command mapped to Command+Up-Arrow and use it all the time.

The Navigation Bar allows you to open a Refactor command on files in the directory tree, which includes the ability to rename, copy and delete them easily without losing your focus. I'm going to be at PyCon Montreal this year, where I'll buy a beer for whoever made this.

## <span id="What_needs_work-12">What needs work</span>

In more recent versions of PyCharm, the refactor commands available from the navigation bar and tree seem to operate on files less reliably — e.g., I try to rename a file, and I definitely highlighted that file, but instead of renaming that file, PyCharm renamed the directory. 

And, as mentioned, the Search Anywhere command would be great, except that it doesn’t always open for some reason — and sometimes even when it does open, it’s slow enough to open that I don’t find myself wanting to use it.

# <span id="Reformatting_Code">Reformatting Code</span>

A seemingly insignificant feature — automated reformatting of selected code to configurable spacing and indentation rules — turns out to be another one I use all day. 

## <span id="Whats_good-14">What’s good</span>

Here’s an example of me correcting spaces and indentation on a block of Cornice code — first I select the problematic lines:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/example_of_badly_formatted_code.png)</figure> 

Then I use my Reformat Code keyboard shortcut to fix the indentation:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/reformatted_code.png)</figure> 

Each language has its own configuration section for this feature. Here’s a screenshot of Python’s:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/code_style_preference_pane.png)</figure> 

Most of the time, this feels like an unconscious extension of my will. It also helps me to ensure that my code is following a project's style guide.

I’ll often sweep whole function definitions with with Reformat Code as I’m writing, to clean up after myself, and then fix the one or two things PyCharm didn’t do quite to my liking.

I use this feature more with JavaScript than Python, and it works very well in those files, too.

## <span id="What_needs_work-13">What needs work</span>

Props aside, Reformat Code doesn’t always understand how I want the reformat to happen because there are ambiguities — for instance, it won’t add a line break for each parameter in a method call to make it a bit more readable when that seems like the best thing to do.

Then there are just plain old errors, like the fact that it won’t reformat docstrings or comments to my configured column width (I had to write my own plugin to do that, Wrap to Column). And it occasionally moves lines to the wrong indent level.

# <span id="The_Terminal">The Terminal</span>

PyCharm 3 offers a built-in terminal emulator. It's a decent terminal that I can keyboard-shortcut into. There are already quality features in the editor to view Git diffs and run management commands, but sometimes I just need a shell, no questions asked.

## <span id="Whats_good-15">What’s good</span>

The terminal has gotten much better throughout PyCharm’s version 3 releases. For a long time I avoided this feature because it used to swallow my tmux command prefix (Control+A), making it impossible to use tmux. However, this has gotten much better in the past couple of releases, so that now I can use PyCharm’s terminal just fine with tmux. I still haven’t converted entirely from iTerm, though — I guess I just like a big terminal window.



## <span id="What_needs_work-14">What needs work</span>

There are two changes that would make the terminal window more usable for me. The first is a keyboard shortcut to maximize the current tool window, so I could easily scale the window to full-screen and drop it back to half or 1/4 screen when I want. The next is a speedup to text input — the current responsiveness of the input feels laggy compared to iTerm.

# <span id="Color_Schemes">Color Schemes</span>

Coming from Vim and Emacs, I’m somewhat dissatisfied with color scheme support in PyCharm. There aren’t many color schemes bundled with the editor, and the selection among community-created color schemes is thin in comparison with Vim’s.

## <span id="Whats_good-16">What’s good</span>

There’s a nice graphical configuration panel that lets you override colors for different languages, and support for importing custom color schemes. Plus, if you use Solarized, the One True Color Scheme, then you’re in luck because there are a couple of decent ports of the color scheme to Intellij-based editors (though I had to fiddle with the default colors in Python, JavaScript and CoffeeScript to avoid vomiting).

Here’s a screenshot of me editing colors for the Solarized Dark scheme and Python:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/color_override_example.png)</figure> 

There is also a new feature called “Look and Feel” that affects your experience with the editor. The Look and Feel choice is a theme for the PyCharm UI chrome, like the tabs, gutter and status bar, which by default are all a metallic gray color.

In my screenshots I’m using the “Darcula” Look and Feel setting, but here’s a screenshot of me using Solarized Light and the default UI Look and Feel:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/default_look_and_feel-1024x573.png)</figure> 

## <span id="What_needs_work-15">What needs work</span>

I’ve had trouble with a color scheme either lacking the option to change the color of some syntax, or using a color for a piece of syntax without giving me the option to change it (I lack a good example of that, but I remember it happened with CoffeeScript).

There are also too few color schemes packages with the editor and too few available from the community. There is also not an easy way to discover new, non-bundled color schemes from within PyCharm, which would be nice.

# <span id="Editing_Backing_Up_and_Restoring_Configuration">Editing, Backing Up and Restoring Configuration</span>

Project and IDE settings are configured using a graphical interface that is searchable. 

## <span id="Whats_good-17">What’s good</span>

The searchable UI is already improvement over Vim, and while Emacs has a UI for configuring settings, I find it difficult to use. I’m not sure I prefer the PyCharm settings UI over a text file, but then again, I don’t get syntax errors changing configuration anymore.

Here's a screenshot of the settings window:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/searching_preferences.png)</figure> 

You can also export and import your settings to and from an XML file, but the result isn’t easily human-editable like a `.vimrc`.

## <span id="What_needs_work-16">What needs work</span>

What I miss is having a single source of configuration “truth” for my editor — like a `.vimrc` file — that I can place in version control and share among computers.

Having to export and import an XML file between installed versions of PyCharm and Intellij IDEA is annoying, and what happens behind the scenes in cases of conflicting settings is not obvious.

# <span id="Snippets">Snippets</span>

PyCharm comes with a yasnippet-like feature called Live Templates. You can find plugins for this type of feature in every editor, and it’s a must-have for languages like Java and JavaScript that require tons of boilerplate.

## <span id="Whats_good-18">What’s good</span>

Live Templates are a decent feature and I’ve used them to create lots of little snippets. Here’s a screenshot of the configuration panel for Live Templates, expanded to show the default JavaScript templates:<figure>

![](https://andrewbrookins.com/wp-content/uploads/2014/02/javascript_live_templates-1024x623.png)</figure> 

If snippets are your thing, then you can find lots of videos of people using PyCharm templates to nice effect. I don't use them very much other than to insert `import ipdb; ipdb.set_trace()`.

## <span id="What_needs_work-17">What needs work</span>

PyCharm needs an easier way to share snippets in a human-readable and human-editable format. I don’t really want to have to point people at an inscrutable XML file.

# <span id="Running_Arbitrary_Code">Running Arbitrary Code</span>

Ok, hold onto your pants — there is no built-in support for creating scratch files (though this is coming in PyCharm 4). You read that right. I know, I know, that has to be a terrible lie, right? Well, it’s the truth. 

## <span id="Whats_good-19">What’s good</span>

Well, as I mentioned, support is coming in PyCharm 4.

And fortunately for my sanity, the [Scratch plugin](http://plugins.jetbrains.com/plugin/?idea&pluginId=4428) adds some nice keyboard shortcuts (and menus) for creating arbitrary files of any type the editor supports, which result in you getting completion and all the other fancy features, as long as you’re referencing symbols that exist in the current project.

## <span id="What_needs_work-18">What needs work</span>

For the last couple of years, I’ve had to use a third-party plugin just to draft code and format one-off snippets of JSON and XML. That seems like a terrible error, so I was happy to hear that the team noticed and tried to fix it in the latest version. 

# <span id="Opening_PyCharm_from_the_Command_Line">Opening PyCharm from the Command Line</span>

The editor will create a charm binary that you can use to open files in PyCharm from the command line.

## <span id="Whats_good-20">What’s good</span>

It works pretty much the same way as using `vim <filename>`.

## <span id="What_needs_work-19">What needs work</span>

The only downside is that files open in your current project. That’s not always what you want, and I’m not sure if there’s a way to tell `charm` to launch them in a new project or in a specific project. Wouldn’t it be miraculous if it could detect the presence of your project files in the directory?

# <span id="Using_Plugins">Using Plugins</span>

Compared to Vim and Emacs, there aren’t as many available plugins.

## <span id="Whats_good-21">What’s good</span>

Fortunately, the lack of an overflowing trove of plugins hasn’t been a problem for me because 90% of the features I used plugins for in Vim are either built into the editor or available as a plugin. There may not be a plugin to post to Orkut for you, though. You’ll have to get down in the mud and cut some Java for that one.

The plugins that are available are all discoverable through a configuration panel from within the editor, which is great. They’re searchable and include details about the current plugin version and author.

Here’s the configuration panel that shows your currently installed plugins:

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/Screen-Shot-2014-10-13-at-10.45.02-AM1.png" alt="Plugins" width="1496" height="1688" class="alignleft size-full wp-image-1311" />](https://andrewbrookins.com/wp-content/uploads/2014/02/Screen-Shot-2014-10-13-at-10.45.02-AM1.png)

And here’s the panel that opens when you want to search for plugins in the plugin repository:

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/02/Screen-Shot-2014-10-13-at-10.45.31-AM1.png" alt="Screen Shot 2014-10-13 at 10.45.31 AM" width="1260" height="996" class="alignleft size-full wp-image-1310" />](https://andrewbrookins.com/wp-content/uploads/2014/02/Screen-Shot-2014-10-13-at-10.45.31-AM1.png)

If you use Sublime Text or Emacs, you already have a tool like this, so it will be familiar and perhaps a little troubling, since occasionally you might have to click a mouse button.

Coming from Vim, this was a great feature. I’ve used several plugin management plugins for Vim and they were decent, but usually lacked a good discovery mechanism.

## <span id="What_needs_work-20">What needs work</span>

We need more plugins. The major blocker to this is that the editor APIs are not clearly documented, and there aren’t many (or perhaps any) really in-depth, high-quality tutorials, videos and other resources for plugin creators. See “Creating Plugins” for more complaints.

# <span id="Creating_Plugins">Creating Plugins</span>

Unlike Sublime Text or Emacs (and less so Vim), you have to really want to create an Intellij or PyCharm plugin. The process is convoluted, under-documented and difficult.

## <span id="Whats_good-22">What’s good</span>

The great thing about writing plugins for PyCharm and Intellij is that they can be very fast without you having to write pieces in C. The JVM is fast. Your plugin won’t block the main thread and the language (Java) is mature.

## <span id="What_needs_work-21">What needs work</span>

Unlike Sublime Text or Vim, you have to use an entirely separate editor to edit plugins — Intellij IDEA Community Edition. The good news is that it’s free, but now you have to maintain another set of keymappings, plugins, and all the rest of that junk.

Plus, while I appreciate that Java on the JVM is fast, it’s not my preferred plugin language, by far.

I’m going to save additional details about writing plugins for a potential future blog post, after I write a couple more Intellij plugins to get experience. However, in summary I’ll say that I had a hell of a time finding comprehensive documentation on the plugin APIs.