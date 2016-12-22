---
id: 1299
title: 'One Year Later: An Epic Review of PyCharm 2.7 from a Vim User&#8217;s Perspective'
date: 2013-10-12T05:40:01+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=1299
permalink: /tech/one-year-later-an-epic-review-of-pycharm-2-7-from-a-vim-users-perspective-older2/
lazyload_thumbnail_quality:
  - default
categories:
  - Django
  - Python
  - Technology
---
This is a review of PyCharm 2.7 that covers all of the features of the editor that I have used on a near-daily basis over the past year. My perspective is that of a professional (and hobby) software developer, occasional open-source contributor and former happy user of Vim.

### <span id="Wait_There_is_newer_version_of_this_post_that_covers_PyCharm_3"><strong>Wait! <a href="/python/one-year-later-an-epic-review-of-pycharm-2-7-from-a-vim-users-perspective/">There is newer version of this post that covers PyCharm 3.</a></strong><br /> </span>

About text editors and me: I&#8217;ve configured the crap out Vim, Emacs and Sublime Text 2, used many plugins and written some of my own, and read [Learning the vi and Vim Editors](http://shop.oreilly.com/product/9780596529833.do) for fun. On my quest for the One True Editor I&#8217;ve frequently dipped into lots of other editors and IDEs, so I may draw some non-Vim comparisons in this review.

I don&#8217;t believe there is One True Editor anymore, and this review isn&#8217;t about claiming that PyCharm is it. What I will do is share the features of PyCharm that I&#8217;ve come to rely on and haven&#8217;t been able to replicate in other editors.

In summary: PyCharm, with the IdeaVim plugin, offers enough parity with Vim to make me happy despite having a few warts, while the editor&#8217;s code navigation, refactoring tools, test runner, debugger and other features I will discuss in this review keep me more focused and joyful than I have ever been writing code.

# <span id="Basic_Facts_About_PyCharm">Basic Facts About PyCharm</span>

Most Python programmers have heard of PyCharm by now. It is an IDE created by JetBrains for use with Python, JavaScript and HTML. I&#8217;ve used versions 2.6 (which I started with last year) and 2.7.

A short list of features include most of the Holy Grails I spent so much time tweaking Vim to provide: highly intelligent code completion and navigation, project management, refactoring and more.

One of the great things about PyCharm is that most of these features _also work with JavaScript_.

Plugins are written in Java or (I think) [Kotlin](http://kotlin.jetbrains.org/).

PyCharm receives multiple updates every year, which include new features, performance enhancements and bug fixes. It costs $199 for a corporate license or $99 for a personal license, with a few other license types available. The company often has limited-time promotional discounts throughout the year.

The editor is closed-source, but is built on the Intellij IDEA platform, which has an open-source Community edition.

# <span id="A_Note_About_Screenshots">A Note About Screenshots</span>

Except where noted, all screenshots are taken using the following setup:

  * A color scheme based on Solarized Dark
  * The &#8220;Darcula&#8221; (sic) UI theme (new in PyCharm 2.7)
  * The Inconsolata font
  * OS X

# <span id="Vim_Emulation_with_IdeaVim">Vim Emulation with IdeaVim</span>

Alright, I know what you came for. Vim versus PyCharm, fight!

Any IDE or editor I pick up has to have good &#8212; really good &#8212; Vim emulation. And by that I mean I expect it to provide much more than vi keybindings. I want an ex command line, rich support for text objects and great search and replace.

PyCharm nails it. JetBrains develops a plugin especially for Vim emulation called [IdeaVim](https://github.com/JetBrains/ideavim) that works with all Intellij IDEA-based editors, including PyCharm. They have a good [list of Vim features the plugin supports](https://andrewbrookins.com/wp-content/uploads/2013/10/index.txt).

The best part about this plugin isn&#8217;t that it&#8217;s open source. That honor goes to it _having a committed JetBrains developer_. Their man Andrey Vlasovskikh is pumping out features and bug fixes all the time.

## <span id="What_it_Feels_Like">What it Feels Like</span>

Nothing can replace Vim, but IdeaVim feels closer than any other editor&#8217;s attempts. After you spend a while learning PyCharm&#8217;s commands and remapping them, you can get a pretty good hybrid of Vim-style commands and custom mappings.

_Note_: If you tried PyCharm before and found IdeaVim lacking, I strongly encourage you to try it again now that Andrey is on the scene.

## <span id="Downsides">Downsides</span>

I expect and desire more from this plugin in the future, especially an easier way to create custom modal key bindings. For now you must use the editor&#8217;s standard key binding mechanism rather than one geared to the peculiarities of the modal interface created by IdeaVim.

Because of this, I have some keyboard shortcuts that feel like they belong to Emacs (Control-X, Control-R to launch the &#8220;Run…&#8221; menu, etc.) where I&#8217;d prefer to use a leader + key combination geared to a specific editing mode. (Only Vim users will understand that sentence.)

# <span id="Code_Completion">Code Completion</span>

Let&#8217;s get into the meat of the review by starting our feature breakdown.

Code completion is very good. Here is a screenshot of me editing code from the open-source Python library [Cornice](https://github.com/mozilla-services/cornice):

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/code_completion1.png" alt="Code Completion" width="618" height="316" class="aligncenter size-full wp-image-976" />](https://andrewbrookins.com/wp-content/uploads/2013/10/code_completion1.png)

PyCharm displays fields of the object&#8217;s class (`_attributes` is a field of `CorniceSchema`) first, followed by fields and methods of its superclasses.

Once you trigger this completion menu, you can type letters to narrow down the selection. E.g., typing &#8220;_att&#8221; here would reduce the list down to the first field.

## <span id="What_it_Feels_Like-2">What it Feels Like</span>

I&#8217;ve used completion features before in Vim and Sublime Text 2, using the &#8220;rope&#8221; library or matches from symbols across a project or in all open buffers. There is a big difference in how these features feel. Rope-based completion was always unreliable, slow or both. Completion features like Vim&#8217;s ability to match symbols across all open buffers are fast, but they feel built on an outdated tooling metaphor. Their unit of work is text.

PyCharm&#8217;s completion, on the hand, seems to operate on _the meaning of code_ in a way that is more reliable and robust than Rope&#8217;s, and works with JavaScript too. You feel that you&#8217;re using an intelligent and well-engineered tool built for the future of programming &#8212; editing code, not text.

## <span id="Downsides-2">Downsides</span>

What I miss about Vim is its ability to complete words _anywhere_: in docstrings, arbitrary strings and comments. PyCharm&#8217;s completion stumbles here and can&#8217;t seem to complete the name of the class you&#8217;re working on if you refer to it inside of a docstring.

# <span id="Code_Navigation">Code Navigation</span>

In other words, a keyboard shortcut that will take you to the definition of a symbol.

When I want to go to a symbol by name, I type my keyboard shortcut for the &#8220;Goto Symbol&#8221; command, which asks me for a symbol name and filters down the symbols found in the project _and_ in all its dependencies:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/symbol_completion1.png" alt="Symbol completion" width="487" height="145" class="aligncenter size-full wp-image-979" />](https://andrewbrookins.com/wp-content/uploads/2013/10/symbol_completion1.png)

In the above screenshot, I triggered &#8220;Goto Symbol&#8221; (Command-R in my setup) and typed &#8220;Cornic&#8221;, at which point it completed to two different symbols. I hit the Enter key to immediately open the `cornice.schemas` module and arrive at the definition of `CorniceSchema`.

I could have used a special click combination or keyboard shortcut to trigger this command on any symbol in an open file.

I use this feature _all day, every day_ to review APIs and docstrings of library code I&#8217;m using. It&#8217;s simply indispensable. But the best part is that it works well and consistently.

## <span id="What_it_Feels_Like-3">What it Feels Like</span>

This is the feature I&#8217;ve had the most trouble getting other editors to do well. Vim and Sublime Text 2 with the &#8220;rope&#8221; library and some integration tweaks &#8212; or PyDev in Eclipse &#8212; can sometimes give you decent navigation. However, I&#8217;ve used all of these extensively and they all failed several times a day. Furthermore, it was not always clear _why_ they failed. The end result? Sadness, anger and a sense of Primitive Humanity falling to darkness.

PyCharm, on the other hand, just works. The feeling is that a team of smart people engineered a product to make your life easier. You feel supported. Then eventually you forget that the feature is even there, and you expect to be able to jump to definitions in any editor.

## <span id="Downsides-3">Downsides</span>

I haven&#8217;t found any. It&#8217;s badass.

However, there are rare occasions when PyCharm can&#8217;t wade through all of the metaclass magic or whatever a framework is doing to define a symbol, and it fails. But these are extremely rare in my experience and generally not a problem with frameworks the editor has special support for, e.g. Flask and Django.

# <span id="Running_Tests">Running Tests</span>

PyCharm&#8217;s test runner helps me achieve an uninterrupted flow state while writing tests. For what seems like a simple feature, it has a huge impact. I&#8217;ll try to explain by talking about my experiences with other editors.

You may have a nice system going with Vim or ST 2 &#8212; maybe it involves a Tmux pane dedicated to running tests, or a command that you run in the editor that shells out to Bash or Z Shell. Maybe you just switch back and forth between an editor window and the shell. I tried all of these.

Ultimately, your workflow is probably something like &#8220;write tests, switch focus to command-line interface, execute the last command or type a new command to run a specific test or suite, examine output, if an error occurs note line number, switch focus back to editor.&#8221;

After using PyCharm, I will never go back to this workflow.

In PyCharm, if I want to run a test I&#8217;m working on, I hit a keyboard shortcut that detects the test my cursor is within and offers to run or debug it. The small window that pops up looks like this:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/running_a_unit_test1.png" alt="Running a unit test" width="617" height="429" class="aligncenter size-full wp-image-980" />](https://andrewbrookins.com/wp-content/uploads/2013/10/running_a_unit_test1.png)

I can type the number 1 or Enter key to run the test, the number 0 to run all unit tests in the current module (`test_schemas` in this example), or the right arrow key for more options. Here&#8217;s an example of the contextual menu that opens when I hit the right arrow key:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/run_context_menu1.png" alt="Contextual menu of the &quot;Run...&quot; dialog" width="671" height="338" class="aligncenter size-full wp-image-981" />](https://andrewbrookins.com/wp-content/uploads/2013/10/run_context_menu1.png)

The default action is run, but I can debug the code (which will allow me to stop at breakpoints in my code or in library code), or I can run a coverage report. I also have a keyboard shortcut that launches a similar window but uses Debug as the default action instead of Run.

So here&#8217;s what it looks like when I run the test:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/unit_test_output1.png" alt="Unit test output" width="956" height="320" class="aligncenter size-full wp-image-989" />](https://andrewbrookins.com/wp-content/uploads/2013/10/unit_test_output1.png)

A new editor pane slides into view (I have mine docked to the bottom of the window). It shows a summary of test results in the left side (&#8220;OK&#8221;), the number of tests it ran, the time tests took to run and any output.

Seems simple, right? After using this feature for a year, I can&#8217;t live without it. Here&#8217;s why:

  * Keyboard shortcuts to jump back and forward between the tests you run (if you ran a suite)
  * A keyboard shortcut that reruns the last test immediately (no context switches required)
  * _Each frame of a stack trace in test output is a link that opens the line in the text referenced in that frame_. So simple, and yet I want to give JetBrains $100 for doing this.

A coverage report looks like this:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/coverage_report1.png" alt="Coverage report" width="712" height="350" class="aligncenter size-full wp-image-990" />](https://andrewbrookins.com/wp-content/uploads/2013/10/coverage_report1.png)

The coverage report is nice, but sort of bells-and-whistles. I rarely run it because I&#8217;m not often checking coverage as I work.

## <span id="What_it_Feels_Like-4">What it Feels Like</span>

What I hope to convey about the test runner is that I can spend a couple of hours working in a single window, writing code, running tests, checking output, jumping to specific lines of a stack trace, setting a breakpoint and debugging a test &#8212; all without having to switch contexts.

Smoke up your bum? No. It may sound like I still &#8220;switch contexts&#8221; in the moment that the editor asks me for input about how to run a test, but it actually feels like an extension of my will. I don&#8217;t even notice that PyCharm is doing anything &#8212; I&#8217;m focused on the code under test, the test and its output. I never found that experience using an editor plus command line interface, even after writing a test runner plugin from scratch for Sublime Text 2.

## <span id="Downsides-4">Downsides</span>

All of that devotion aside, there is one downside to the test runner. When you rerun a test, the output from the last test run is cleared away. That is unfortunate because when I&#8217;d rather not fool with the debugger, I use print statements to check on misbehaving state, and sometimes it&#8217;s helpful to see changes over the course of running a test multiple times.

I hope someday there will be a &#8220;persistent output&#8221; option, like in Chrome&#8217;s console. Maybe I should open a ticket for that…

# <span id="Debugging">Debugging</span>

I used to feel pretty elite doing all of my debugging in ipdb and the command line. I had a keyboard shortcut in Vim that would inject an &#8220;import ipdb; ipdb.set_trace()&#8221; statement on the current line. Then I&#8217;d go to town.

At first I wasn&#8217;t super impressed with using PyCharm&#8217;s graphical debugger, compared to my experience with ipdb. It&#8217;s grown on me over time, though, and now when I try to use ipdb I feel that old sadness for Primitive Humanity.

Before I explain why I like the debugger better than ipdb, let me show you a screenshot of me debugging Cornice:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/debugging_python1.png" alt="Debugging Python" width="734" height="741" class="aligncenter size-full wp-image-991" />](https://andrewbrookins.com/wp-content/uploads/2013/10/debugging_python1.png)

So, let&#8217;s talk about the screenshot. I&#8217;ve set a breakpoint on the blue line with the red dot on it (too bad I cropped the line number out of the screenshot, right?) and ran a test that triggered the code in the current frame.

PyCharm&#8217;s debugger is paused in `_validate_fields`. The current line is highlighted. Variables in scope are listed in the lower-right quadrant of the screen, next to the list of frames; both areas are part of a window pane that slid into view after I executed a &#8220;Debug&#8221; action within a test I was writing.

I can now interact with the state of the program visually, through the &#8220;Variables&#8221; tree, or imperatively using either the &#8220;Evaluate Expression&#8221; command or an interactive console session akin to ipdb. These are all useful tools, so let&#8217;s examine them in more detail.

In the following screenshot of the &#8220;Variables&#8221; the tree you can see the container object `request` expanded to show its members (this doesn&#8217;t always work, and I&#8217;m not sure why):

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/debugger_variable_tree1.png" alt="Debugger variable tree" width="630" height="403" class="aligncenter size-full wp-image-992" />](https://andrewbrookins.com/wp-content/uploads/2013/10/debugger_variable_tree1.png)

The following is a screenshot of what running the &#8220;Evaluate Expression&#8221; command looks like:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/evaluate_expression_dialog1.png" alt="Evaluate expression dialog" width="511" height="489" class="aligncenter size-full wp-image-993" />](https://andrewbrookins.com/wp-content/uploads/2013/10/evaluate_expression_dialog1.png)

This dialog window opens up in front of the editor. It isn&#8217;t modal, so you can continue to interact with your code or the debugger behind it.

The &#8220;result&#8221; portion of the window shows the return result of the expression after you click &#8220;Evaluate.&#8221; Standard output appears in the &#8220;Console&#8221; window, which I&#8217;ll show in the next screenshot. You see the exception class of any exception raised by the the expression, but not a stack trace. &#8220;Code Fragment Mode&#8221; lets you write more than one line for your expression.

The other way to interact with the running program is through the &#8220;console.&#8221; While there is a keyboard shortcut to launch &#8220;Evaluate Expression,&#8221; I haven&#8217;t found one for the console, which seems to require _two mouse clicks_ (ugh!).

First you have to click on the &#8220;Console&#8221; tab of the debugging window, which looks like this:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/debugger_console1.png" alt="Debugger console" width="891" height="358" class="aligncenter size-full wp-image-994" />](https://andrewbrookins.com/wp-content/uploads/2013/10/debugger_console1.png)

Here you can see standard output from the code currently being debugged. (My screenshot is of different code than in the last screenshot.) The console window to the right is where standard output from any code executed in &#8220;Evaluate Expression&#8221; appears.

To make the console interactive you have to click the &#8220;Show command line&#8221; button on this window (ugh! WTF! I just clicked &#8220;Console&#8221;!). Which drops you here:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/debugger_interactive_console1.png" alt="Debugger interactive console" width="593" height="510" class="aligncenter size-full wp-image-995" />](https://andrewbrookins.com/wp-content/uploads/2013/10/debugger_interactive_console1.png)

Before you ask, I don&#8217;t know what the &#8220;##teamcity&#8221; stuff is about. TeamCity is a continuous integration product that JetBrains makes, and which I&#8217;ve never used.

So, back to the &#8220;Console/Command Line.&#8221; This is like an ipdb session where you can use Python to interact with your Python &#8212; except that you can&#8217;t control the debugger using text commands. I spent a lot of time in this window when I first started using PyCharm&#8217;s debugger, and it&#8217;s pretty nice, but not much better than &#8220;Evaluate Expression.&#8221;

## <span id="What_it_Feels_Like-5">What it Feels Like</span>

In a sentence: ipdb on steroids.

I like it better than ipdb for the same reason that I like the test runner better than using a command line &#8212; no context switches. As long as you stick to &#8220;Evaluate Expression,&#8221; you can remain in a flow state while you debug the program, using only keyboard shortcuts. Check it out:

  * Write some code
  * Add a breakpoint using a keyboard shortcut
  * Run a test in debugging mode using a keyboard shortcut
  * Evaluate an expression using a keyboard shortcut
  * Jump between frames using a keyboard shortcut; maybe evaluate more code
  * Close the Debug window using a keyboard shortcut

This is a pretty nice debugging workflow and it beats the hell out of switching to a terminal window and interacting with ipdb. I don&#8217;t have to think about ipdb&#8217;s wacky command line interface &#8212; e.g., how to print more or less lines of code around the code I&#8217;m debugging after I run the &#8220;line&#8221; command a couple of times, or any of that other annoying stuff that ipdb forces on me. I&#8217;m in there looking at some state, then I&#8217;m back out ASAP and working again.

## <span id="Downsides-5">Downsides</span>

No keyboard shortcut (that I&#8217;m aware of) to launch &#8220;command line&#8221; mode of the Console while in a debugging session.

# <span id="Code_Generation">Code Generation</span>

PyCharm has a feature called &#8220;Intention Actions&#8221; that provide automated solutions to known problems the editor detects in your code. &#8220;Problem&#8221; may be the wrong word, as these situations may be problems, such as using a symbol that isn&#8217;t found in the current scope, or they may be small refactors that can make your code better, or they may simply offer a helping hand, e.g. by generating a documentation stub.

According to the docs, there are three types of Intention Actions: &#8220;Create from usage&#8221; (missing symbols), &#8220;Quick fixes&#8221; (problems your in your code) and &#8220;Micro-refactorings&#8221; (e.g. convert lambda into function def).

When an Intention Action is available, you will usually see some indicator in either the status bar on the bottom of the window, the text itself (if it&#8217;s a syntax error or unresolved symbol) or both. Then you can use a keyboard shortcut to trigger a menu of actions available.

Whew, that was a lot of detail. The point is that these actions usually generate code. In the following screenshot I typed the symbol &#8220;Request&#8221; and PyCharm could not find it in scope, so I triggered the Intention Action menu with a keyboard shortcut:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/intention_action_menu1.png" alt="Intention action menu" width="581" height="240" class="aligncenter size-full wp-image-996" />](https://andrewbrookins.com/wp-content/uploads/2013/10/intention_action_menu1.png)

I&#8217;m given a few options. The most common is that I want to add an import statement for an unresolved symbol, but I could also create a class, function or parameter. Hitting the right-arrow key on any of these will present further options, such as where in scope I want to add the new code (e.g., in the current function, class or module), and enter will use a default.

I don&#8217;t often create a class or method with this feature, but I do regularly use it to fix errors and add import statements.

## <span id="What_it_Feels_Like-6">What it Feels Like</span>

This might seem like a bells-and-whistles feature, or even bloat &#8212; which is what it feels like in Vim when saving a large file causes a 1 &#8211; 2 second delay for syntax checking. However, on a 2008 MacBook Pro, I rarely experienced lag that appeared to be caused by this feature. And the editor hums on more recent hardware.

Instead of annoying, this feels like pair programming with an observant coworker who has memorized Python syntax, a small dictionary and PEP8. Who you can tell to shut up without any social retribution.

## <span id="Downsides-6">Downsides</span>

None. However, I assume this feature will make you sad if you run PyCharm on a Linux machine with 4 GB of RAM or less, but I wouldn&#8217;t recommend that for other reasons (fonts, as I&#8217;ll discuss later).

# <span id="Error_Detection_and_Resolution">Error Detection and Resolution</span>

PyCharm detects several types of errors in your code and will offer to fix them for you. These include the types of errors that you probably already use pylint to check for in your editor of choice: syntax errors and PEP8 violations. It also detects spelling mistakes with what appears to be a very limited dictionary.

Beyond these simple scans, the editor &#8220;knows about&#8221; Python in the sense that it can detect common design mistakes, like not closing a resource, and offer automated solutions. It can also detect alternative style choices, like single-versus-double quotations, and offer to change between them.

Erroneous statements are underlined with a red squiggly line by default, but this is configurable. One of the options in the Intention Action menu for an error is to silence it. You can also configure whether PyCharm should check for spelling errors in code, or in comments only (or never).

## <span id="What_it_Feels_Like-7">What it Feels Like</span>

This is a great feature that I won&#8217;t spend too much time on because I&#8217;ve already partially described it in &#8220;Code Generation.&#8221; As with that feature, it feels like working with a pedantic-yet-helpful pair programmer.

## <span id="Downsides-7">Downsides</span>

Same as &#8220;Code Generation.&#8221; Running background error detection on code as you write it is probably resource-intensive, especially for thousand-plus-line-files. I haven&#8217;t had any problems though.

# <span id="Refactoring">Refactoring</span>

If you haven&#8217;t used refactoring tools before, this is a feature that automates the rather laborious process of doing things like renaming a method or variable that may have dozens or hundreds of usages across a project.

Doable with ack (or grep) and Vim. But would I want to go back to that life? No. Here&#8217;s why &#8212; let&#8217;s say I want to rename a method with a name like &#8220;add&#8221; that&#8217;s guaranteed to give me false positives from a text-based search like grep. In PyCharm I trigger the refactor menu with a keyboard shortcut:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/refactor_this_menu1.png" alt="Refactor This menu" width="589" height="558" class="aligncenter size-full wp-image-997" />](https://andrewbrookins.com/wp-content/uploads/2013/10/refactor_this_menu1.png)

Alright, great. I have tons of refactoring options. I&#8217;m only going to show renaming because that is what I do the most. So, I hit the Enter key on &#8220;Rename…&#8221; and I&#8217;m asked for the new name:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/rename_method_dialog1.png" alt="Rename method dialog" width="504" height="190" class="aligncenter size-full wp-image-998" />](https://andrewbrookins.com/wp-content/uploads/2013/10/rename_method_dialog1.png)

What&#8217;s that &#8220;Preview&#8221; button? Oh, it&#8217;s _just a sweet tree containing all the occurrences of the symbol_:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/refactor_preview_pane1.png" alt="Refactor preview pane" width="660" height="583" class="aligncenter size-full wp-image-999" />](https://andrewbrookins.com/wp-content/uploads/2013/10/refactor_preview_pane1.png)

From the preview, I can right-click on any branch of the tree and exclude all sub-items from the operation. There&#8217;s a button at the bottom (not in the screenshot) that lets me cancel or do the refactor.

If I want to undo the refactor, all of the changes are rolled up into a single undo, and I get a special dialog box (&#8220;Undo renaming method to add_please?&#8221;).

## <span id="What_it_Feels_Like-8">What it Feels Like</span>

The future. Seriously. I believe that the industry will continue to build more intelligent tools &#8212; not &#8220;text editors&#8221; anymore, but development environments that have a deep machine understanding of how languages, frameworks and platforms work. PyCharm&#8217;s refactoring tools feel like just the tip of this iceberg, and yet they still blow away the alternatives. And you can refactor JavaScript, too.

## <span id="Downsides-8">Downsides</span>

None that I&#8217;ve found.

\# Window and Split Management

Personally, I won&#8217;t even use an editor that can&#8217;t split editor panes well (I&#8217;m
  
looking at you, Eclipse).

So, there&#8217;s good news and there&#8217;s bad news.

Good news: PyCharm has windows and splits. Typically you&#8217;ll have each project
  
open in a separate window, but you can also yank a tab into its own window or
  
detach one of the many different tool panels into a separate window. Here is
  
what a horizontal split looks like &#8212; a vertical looks pretty much the same:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/horizontal_split1.png" alt="horizontal_split" width="804" height="815" class="aligncenter size-full wp-image-1055" />](https://andrewbrookins.com/wp-content/uploads/2013/10/horizontal_split1.png)

Bad news: There are some downsides, which I&#8217;ll discuss in &#8220;Downsides.&#8221;

\## What it Feels Like

Way better than Eclipse, more fluid than Sublime Text 2, but sub par compared to
  
Vim. In fact I just try not to think about Vim when I&#8217;m using window splits
  
because doing so fills me with longing.

Coming from Vim, there are fewer keyboard shortcuts/split commands available:
  
split horizontally, split vertically, change split orientation, unsplit, unsplit
  
all, goto next splitter and goto previous splitter.

I haven&#8217;t found myself pining for more commands, though, so I don&#8217;t consider
  
this a downside, just something to mention.

The UI for splits is bulkier than Vim owing to the fact that each split creates
  
a new gutter, margin and tab area, and each file in the split receives a tab.

\## Downsides

Window splits are not quite the smooth-as-butter experience that I remember from Vim. The biggest problem I have is with opening a file from one split that is already &#8220;open&#8221; in another split.

If you do this in PyCharm, your cursor will jump to whatever split the file is already open in. Vim would just open the file in the current split, which is the behavior I&#8217;ve come to expect. At the very least I&#8217;d like this to be a configuration option.

\# Managing Open Files

PyCharm represents an open file with a tab. I didn&#8217;t use tabs with Vim, so at
  
first it seemed like JetBrains had dumped something foul in my cereal. Now
  
they&#8217;ve grown on me &#8212; in large part because of the tools the editor includes
  
for jumping between open and recent files.

\## Tabs

Here&#8217;s what a single row of tabs looks like:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/tabs1.png" alt="tabs" width="683" height="369" class="aligncenter size-full wp-image-1054" />](https://andrewbrookins.com/wp-content/uploads/2013/10/tabs1.png)

By default, PyCharm will continue to stack editor tabs on new lines as you add
  
files, so you can see all open files clearly:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/multiline_tabs1.png" alt="multiline_tabs" width="617" height="314" class="aligncenter size-full wp-image-1052" />](https://andrewbrookins.com/wp-content/uploads/2013/10/multiline_tabs1.png)

You can also configure it to keep tabs to one line, which hides the lesser-used
  
tabs in the current editor instance (each split is an editor instance):

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/hidden_tabs1.png" alt="hidden_tabs" width="705" height="361" class="aligncenter size-full wp-image-1049" />](https://andrewbrookins.com/wp-content/uploads/2013/10/hidden_tabs1.png)

Then you get a little button that opens a list of all the tabs (and I believe you can configure a keyboard shortcut for this too):

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/tab_context1.png" alt="tab_context" width="527" height="279" class="aligncenter size-full wp-image-1048" />](https://andrewbrookins.com/wp-content/uploads/2013/10/tab_context1.png)

If you desire ruthless efficiency, you can set a &#8220;tab limit&#8221; that defaults
  
to ten. If you open more than that number of tabs, PyCharm start closing old
  
ones. You have a couple of options for the tab-closing strategy.

BUT WAIT, THERE&#8217;S MORE.

\## Jumping to a Recent File or Tool Window

In Vim and Emacs I used plugins like bufexplorer and ibuffer (respectively) to
  
get an overview of open files and to quickly switch back and forth between them.

PyCharm has a couple of features like this. First is the list of recent files,
  
shown here triggered by a keyboard shortcut:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/recent_files1.png" alt="recent_files" width="415" height="454" class="aligncenter size-full wp-image-1047" />](https://andrewbrookins.com/wp-content/uploads/2013/10/recent_files1.png)

This list is searchable and defaults to the last file I had open. As soon as I
  
start typing, it filters down the list of items:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/searching_for_recent_files1.png" alt="searching_for_recent_files" width="380" height="405" class="aligncenter size-full wp-image-1046" />](https://andrewbrookins.com/wp-content/uploads/2013/10/searching_for_recent_files1.png)

This is great because I don&#8217;t even keep track mentally of files I may have
  
opened 16 files ago &#8212; by then I usually just jump to the file by name, which
  
I&#8217;ll discuss in the &#8220;Managing Project Files&#8221; section. You could always do that,
  
but I find that the recent files list is faster.

Note that you can open a tool window by name from this window, not just files.

You can also view a list of recently \*edited\* files &#8212; not just ones that you
  
viewed, with a different keyboard shortcut:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/recently_edited_files1.png" alt="recently_edited_files" width="500" height="291" class="aligncenter size-full wp-image-1045" />](https://andrewbrookins.com/wp-content/uploads/2013/10/recently_edited_files1.png)

There&#8217;s yet another way to show a list like this, too, which is called the
  
&#8220;Switcher.&#8221; This is basically like Alt-Tab or Command-Tab, where you hold down a
  
key combo and tab between options rather than search. I don&#8217;t use it.

\## What it Feels Like

I don&#8217;t even notice these features anymore because they&#8217;re muscle memory. Most
  
of the time I&#8217;m using them to jump back and forth between a few open files I&#8217;m
  
working on &#8212; or more often, the immediate last file.

I for sure notice when they&#8217;re missing from other editors though&#8230;

\## Downsides

I&#8217;m happy with a list of recent files, but I&#8217;d prefer an option to show all the
  
files open in the editor, like ibuffer and bufexplorer do. I&#8217;d also like to be
  
able to close files from the same menu.

\# Managing Project Files

Get ready because these features pack heat. Well, at least one of them does (the navigation bar &#8212; keep reading).

PyCharm lets you jump to any file in the current project using a fuzzy search,
  
like Sublime Text 2, Eclipse, Xcode and Vim with certain plugins. It works well
  
&#8212; maybe not quite as fuzzy as ST 2, but good enough. The UI is similar to &#8220;Goto
  
Symbol,&#8221; a list of partial matches that filters down as you modify your search
  
text:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/goto_file1.png" alt="goto_file" width="491" height="284" class="aligncenter size-full wp-image-1044" />](https://andrewbrookins.com/wp-content/uploads/2013/10/goto_file1.png)

I use this all day, when I&#8217;m not using the Recent Files menu to open files.

If you like to see a tree of files, though, PyCharm has a comprehensive one that
  
works way better than Sublime Text 2&#8217;s and NERDTree in Vim:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/file_tree1.png" alt="file_tree" width="479" height="642" class="aligncenter size-full wp-image-1043" />](https://andrewbrookins.com/wp-content/uploads/2013/10/file_tree1.png)

It probably looks like any old file tree, but it has quite a few options for
  
each file in a context menu opened by right clicking:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/file_tree_context1.png" alt="file_tree_context" width="377" height="694" class="aligncenter size-full wp-image-1042" />](https://andrewbrookins.com/wp-content/uploads/2013/10/file_tree_context1.png)

Honestly though, I never use this tree because there is something \*way better\*
  
called the navigation bar. I&#8217;m not sure how to describe this other than it&#8217;s
  
like a keyboard-navigable breadcrumb file tree. I&#8217;ll have to show you &#8212; here is
  
what it looks like in its default position (I usually have it hidden by
  
default):

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/navigation_bar_default1.png" alt="navigation_bar_default" width="744" height="332" class="aligncenter size-full wp-image-1041" />](https://andrewbrookins.com/wp-content/uploads/2013/10/navigation_bar_default1.png)

&#8220;Ugh, so crowded!&#8221; you probably thought. Yeah, I know, that&#8217;s why I have it
  
turned off. But check this out &#8212; you can still activate a special floating
  
version of the navigation bar with a keyboard shortcut:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/navigation_bar_floating1.png" alt="navigation_bar_floating" width="584" height="350" class="aligncenter size-full wp-image-1056" />](https://andrewbrookins.com/wp-content/uploads/2013/10/navigation_bar_floating1.png)

And it does a great job of showing directory contents:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/navigation_bar_directory1.png" alt="navigation_bar_directory" width="502" height="428" class="aligncenter size-full wp-image-1053" />](https://andrewbrookins.com/wp-content/uploads/2013/10/navigation_bar_directory1.png)

Meanwhile, PyCharm has refactoring options specific to files, which you can trigger directly from the navigation bar:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/refactor_file_from_navigation_bar1.png" alt="refactor_file_from_navigation_bar" width="248" height="149" class="aligncenter size-full wp-image-1050" />](https://andrewbrookins.com/wp-content/uploads/2013/10/refactor_file_from_navigation_bar1.png)

In this screenshot, I&#8217;ve triggered the &#8220;rename&#8221; refactor action for this file:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/rename_file1.png" alt="rename_file" width="358" height="211" class="aligncenter size-full wp-image-1051" />](https://andrewbrookins.com/wp-content/uploads/2013/10/rename_file1.png)

I&#8217;m not sure a few screenshots can convey how awesome it is that you can move,
  
rename and delete files all from the keyboard, without having to use a shell, sidebar
  
or tool window. Who at JetBrains was responsible for making this happen? I want to buy
  
you a rad stuffed animal.

\## What it Feels Like

Like all of my favorite PyCharm features, this one simply fades into my
  
experience of editing &#8212; until I ever try to use another editor and I&#8217;m rudely
  
awakened. I can&#8217;t imagine pausing from a coding session to rename some files in
  
a shell or even a sidebar tree anymore, or \*God forbid\* doing anything other
  
than fuzzy search on recent files or project files to jump around.

\## Downsides

None that I&#8217;ve found. These features are tight.

# <span id="Reformatting_Code">Reformatting Code</span>

A seemingly insignificant feature &#8212; automated reformatting of selected code to configurable spacing and indentation rules &#8212; turns out to be another one I use all day. Here&#8217;s an example of me correcting spaces and indentation on a block of Cornice code &#8212; first I select the problematic lines:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/example_of_badly_formatted_code1.png" alt="Example of badly formatted code" width="715" height="169" class="aligncenter size-full wp-image-1000" />](https://andrewbrookins.com/wp-content/uploads/2013/10/example_of_badly_formatted_code1.png)

Then I use my Reformat Code keyboard shortcut to fix the indentation:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/reformatted_code1.png" alt="Reformatted code" width="682" height="207" class="aligncenter size-full wp-image-1001" />](https://andrewbrookins.com/wp-content/uploads/2013/10/reformatted_code1.png)

Each language has its own configuration section for this feature. Here&#8217;s a screenshot of Python&#8217;s:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/code_style_preference_pane1.png" alt="Code style preference pane" width="807" height="651" class="aligncenter size-full wp-image-1002" />](https://andrewbrookins.com/wp-content/uploads/2013/10/code_style_preference_pane1.png)

## <span id="What_it_Feels_Like-9">What it Feels Like</span>

Another unconscious extension of my will &#8212; that is, when it works.

Often, Reformat Code doesn&#8217;t understand how I want the reformat to happen because there are ambiguities &#8212; for instance, it won&#8217;t add a line break for each parameter in a method call to make it a bit more readable when that seems like the best thing to do.

Then there are just plain old errors, like the fact that it won&#8217;t reformat docstrings or comments to my configured column width (I had to [write my own plugin](http://plugins.jetbrains.com/plugin/7234) to do that). Or that it occasionally it moves lines to the wrong indent level.

Still, I&#8217;ll often sweep whole function definitions with with Reformat Code as I&#8217;m writing, to clean up after myself, and then fix the one or two things PyCharm didn&#8217;t do quite to my liking.

I think I use this feature more with JavaScript than Python, and it works very well in those files, too.

## <span id="Downsides-9">Downsides</span>

The inability to reformat comments and docstrings to a column width is a drag. They even released a separate feature that I thought was supposed to do this very thing &#8212; &#8220;Fill Paragraph.&#8221; Except that I could never get it to work, and at present the issue tracker has several bugs in various states against Fill Paragraph that seem not to be resolved.

Unrelated to my personal vendetta, the general sense that PyCharm can&#8217;t make everybody happy in ambiguous cases, even with configurable behavior for code style, is something I&#8217;m willing to accept. Would you expect your paint brush to paint the picture for you? I think not.

# <span id="Color_Schemes">Color Schemes</span>

Coming from Vim and Emacs, I&#8217;m somewhat dissatisfied with color scheme support in PyCharm. There aren&#8217;t many color schemes bundled with the editor, and the selection among community-created color schemes is thin in comparison with Vim&#8217;s.

I&#8217;ve also had trouble with a color scheme either lacking the option to change the color of some syntax, or using a color for a piece of syntax without giving me the option to change it (I lack a good example of that, but I remember it happened with CoffeeScript).

Still, there are upsides. There&#8217;s a nice graphical configuration panel that lets you override colors for different languages, and support for importing custom color schemes.

Plus, if you use [Solarized, the One True Color Scheme](https://github.com/altercation/solarized), then you&#8217;re in luck because there are a couple of decent ports of the color scheme to Intellij-based editors (though I had to fiddle with the default colors in Python, JavaScript and CoffeeScript to avoid vomiting).

Here&#8217;s a screenshot of me editing colors for the Solarized Dark scheme and Python:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/color_override_example1.png" alt="Color override example" width="619" height="685" class="aligncenter size-full wp-image-1003" />](https://andrewbrookins.com/wp-content/uploads/2013/10/color_override_example1.png)

There is also a new feature called &#8220;Look and Feel&#8221; that affects your experience with the editor. The Look and Feel choice is a theme for the PyCharm UI chrome, like the tabs, gutter and status bar, which by default are all a metallic gray color.

In my screenshots I&#8217;m using the &#8220;Darcula&#8221; Look and Feel setting, but here&#8217;s a screenshot of me using Solarized Light and the default UI Look and Feel:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/default_look_and_feel-1024x5731.png" alt="Default Look And Feel" width="1024" height="573" class="aligncenter size-large wp-image-1004" />](https://andrewbrookins.com/wp-content/uploads/2013/10/default_look_and_feel1.png)

## <span id="What_it_Feels_Like-10">What it Feels Like</span>

Adequate. The graphical configuration panel is a nice touch &#8212; and since you can export your color scheme overrides, you can include these customizations in your editor settings backups.

## <span id="Downsides-10">Downsides</span>

Too few color schemes packages with the editor and too few available from the community. No way to discover new, non-bundled color schemes from within PyCharm.

# <span id="Project_Support">Project Support</span>

One thing everyone expects from an IDE is good project support, and PyCharm does this very well.

Creating projects is super easy, especially if you already have a directory of code and you just want to edit it with PyCharm. In that case, there is an &#8220;Open Directory&#8221; option that automatically builds a project configuration for a directory containing Python code. If the directory is under version control, PyCharm will detect this and ask you to confirm the location of the source control root (which it has detected). Usually the only step I need to take after that is to go into the project configuration and set a custom Python Interpreter, since I use Virtualenv &#8212; which indexes all of the symbols used for completion and navigation.

There is also a form wizard that you can use to create a new project from scratch.

When you open a new project (or directory), you can do so in the current window, which switches out the active project, or you can open it in a new window.

When closing and reopening projects, all of your files, window splits and window positions are restored. There is no &#8220;persistent undo&#8221; option like in Vim, so you can&#8217;t press an Undo keyboard shortcut and undo the last action you did before closing the editor. However, the editor&#8217;s embedded version control system, &#8220;Local History,&#8221; keeps track of _all_ changes to files in your project, including loading external changes, so you can easily undo previous changes with a nice diff-like interface.

Code style settings are project-specific, so if you work on multiple open-source (or whatever) projects with competing style guides, PyCharm can cope with that, and you can use the &#8220;Reformat Code&#8221; command to automate keeping your work in line with the team&#8217;s style.

## <span id="What_it_Feels_Like-11">What it Feels Like</span>

If you&#8217;ve used Sublime Text 2 or other IDEs, this is familiar ground, with a nice GUI and some extra Python-specific settings like the location of the project interpreter.

Projects in PyCharm feel like one unified piece of a collection of well-engineered features. They make the experience a little bulkier than with Vim, but the tradeoff is that you get all of the crazy-awesome contextual features like navigation and completion as a result.

## <span id="Downsides-11">Downsides</span>

If you&#8217;re coming from Vim, then you might have mixed feelings about project support, since they are a metaphor central to PyCharm.

When I first started using the editor, I didn&#8217;t like to be so locked into the idea of a project. Opening random files from the command line seemed awkward because they opened in the current project. On the other hand, I spent a long time trying to get a decent project management workflow (managing a collection of files related to a single project) working in Vim without success. I tried sessions and project plugins, and none of my approaches worked well with all of my plugins correctly &#8212; one plugin would set the CWD to the current file, while another plugin needed CWD set to the project directory to work. Etc.

Ultimately, I&#8217;m happy to have project support and I can live with the fact that running `charm <filename>` opens a file in my current project. That seems like a logical choice.

# <span id="Editing_Backing_Up_and_Restoring_Configuration">Editing, Backing Up and Restoring Configuration</span>

Project and IDE settings are configured using a graphical interface that is searchable. I&#8217;m not sure I prefer it over a text file, but then again, I don&#8217;t get syntax errors changing configuration anymore.

What I do miss is having a single source of configuration &#8220;truth&#8221; for my editor &#8212; like a `.vimrc` file &#8212; that I can place in version control and share among computers. With PyCharm, you can easily export and import your settings, but you have to remember to export them, and the resulting file isn&#8217;t exactly human-readable.

So, here&#8217;s what the settings panel looks like &#8212; there&#8217;s a searchable tree on the left side of the window (and there are more settings than I&#8217;ve included in the screenshot):

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/preferences_panel-466x10241.png" alt="Preferences panel" width="466" height="1024" class="aligncenter size-large wp-image-1005" />](https://andrewbrookins.com/wp-content/uploads/2013/10/preferences_panel1.png)

If you type in the search box, the tree live-updates by filtering down the list of panels to ones in which it found a hit:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/searching_preferences1.png" alt="Searching preferences" width="978" height="688" class="aligncenter size-full wp-image-1006" />](https://andrewbrookins.com/wp-content/uploads/2013/10/searching_preferences1.png)

Then you … type in the boxes. It&#8217;s pretty straight-forward.

## <span id="What_it_Feels_Like-12">What it Feels Like</span>

Belittling, to a Vim user, though the search feature is nice.

I like the option of having a GUI to modify settings, but I prefer editing a text file so I can easily keep it in version control. I also like having programmatic access to configuration options &#8212; switching options based on the current OS, just to take one example. Say goodbye to spending lots of time editing your configuration file.

Still, _say goodbye to spending lots of time editing your configuration file_. Seriously, I&#8217;m pretty sure you won&#8217;t miss it. I don&#8217;t.

## <span id="Downsides-12">Downsides</span>

No central source of truth about editor configuration in a human-readable text file. You must use a GUI to change settings (though it&#8217;s a nice one).

# <span id="Snippets">Snippets</span>

PyCharm comes with a yasnippet-like feature called Live Templates. You can find plugins for this type of feature in every editor, and it&#8217;s a must-have for languages like Java and JavaScript that require tons of boilerplate.

Anyway, it&#8217;s a decent feature and I&#8217;ve used it to create lots of little snippets. Here&#8217;s a screenshot of the configuration panel for Live Templates, expanded to show the default JavaScript templates:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/javascript_live_templates-1024x6231.png" alt="JavaScript Live Templates" width="1024" height="623" class="aligncenter size-large wp-image-1007" />](https://andrewbrookins.com/wp-content/uploads/2013/10/javascript_live_templates1.png)

You can&#8217;t tell from the screenshot, but that&#8217;s actually _the extent of the templates for JavaScript_. Python &#8212; the language this editor was principally designed for &#8212; has even less. Just one! All it does is generate a `super` call for you.

## <span id="What_it_Feels_Like-13">What it Feels Like</span>

It feels the same as any other snippet-like feature you&#8217;ve used over the years, but with a GUI for editing and creating them.

## <span id="Downsides-13">Downsides</span>

You can export Live Templates as part of a settings export, into an XML file, but once again, you can&#8217;t include them as part of a configuration file in version control that the editor reads and writes to.

The default set of templates is also pretty light. You&#8217;ll end up writing a bunch of your own or searching GitHub for someone&#8217;s exported settings file designed for a machine to read &#8212; ugh.

# <span id="Running_Arbitrary_Code_Scratch_plugin">Running Arbitrary Code (Scratch plugin)</span>

Ok, hold onto your pants &#8212; there is no built-in support for creating scratch files.

You read that right. I know, I know, that has to be a terrible lie, right? Well, it&#8217;s the truth. To write code in PyCharm you must create a named file that becomes associated with the project. BUT WAIT, THERE&#8217;S A PLUGIN.

Fortunately for my sanity, the [Scratch plugin](http://plugins.jetbrains.com/plugin/?idea&pluginId=4428) adds some nice keyboard shortcuts (and menus) for creating arbitrary files of any type the editor supports, which result in you getting completion and all the other fancy features, as long as you&#8217;re referencing symbols that exist in the current project.

## <span id="What_it_Feels_Like-14">What it Feels Like</span>

It felt like a bunch of crap before I found Scratch. Now I don&#8217;t really mind, except when I consider that I had to download a plugin just to create a scratch file.

## <span id="Downsides-14">Downsides</span>

Too obvious to mention.

# <span id="Opening_Files_from_the_Command_Line">Opening Files from the Command Line</span>

The editor will create a `charm` binary that you can use to open files in PyCharm from the command line. It works well.

## <span id="What_it_Feels_Like-15">What it Feels Like</span>

Opening files with `vim <filename>`.

## <span id="Downsides-15">Downsides</span>

Files open in your current project. That&#8217;s not always what you want, and I&#8217;m not sure if there&#8217;s a way to tell `charm` to launch them in a new project or in a specific project.

# <span id="Plugins">Plugins</span>

Compared to Vim, there aren&#8217;t many available plugins. This hasn&#8217;t been a problem for me because 90% of the features I used plugins for in Vim are either built into the editor or available as a plugin. There may not be a plugin to post to Orkut for you, though. You&#8217;ll have to get down in the mud and cut some Java for that one.

The plugins that _are_ available are all discoverable through a configuration panel from within the editor, which is great. They&#8217;re searchable and include details about the current plugin version and author.

Here&#8217;s the configuration panel that shows your currently installed plugins:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/installed_plugins-1024x5321.png" alt="Installed Plugins" width="1024" height="532" class="aligncenter size-large wp-image-1008" />](https://andrewbrookins.com/wp-content/uploads/2013/10/installed_plugins1.png)

And here&#8217;s the panel that opens when you want to search for plugins in the plugin repository:

[<img src="https://andrewbrookins.com/wp-content/uploads/2013/10/plugins_from_repository-1024x5951.png" alt="Plugins from repository" width="1024" height="595" class="aligncenter size-large wp-image-1009" />](https://andrewbrookins.com/wp-content/uploads/2013/10/plugins_from_repository1.png)

## <span id="What_it_Feels_Like-16">What it Feels Like</span>

If you use Sublime Text 2 or Emacs, you already have a tool like this, so it will be familiar and perhaps a little troubling, since occasionally you might have to click a mouse button.

Coming from Vim, this was a great feature. I&#8217;ve used several plugin management plugins for Vim and they were decent, but usually lacked a good discovery mechanism.

\*\*Update\*\*: As of PyCharm 2.7.3, a great feature of plugin management is that if you export your settings and then import them from a new editor installation, PyCharm will download the plugins for you. Voila!

## <span id="Downsides-16">Downsides</span>

The only problem I had with this feature &#8212; an inability to export plugins in a settings file and then automatically download the plugins on a new install &#8212; has been added since I wrote this article. 

So there aren&#8217;t any downsides. Awesome! 

# <span id="Writing_Plugins">Writing Plugins</span>

Unlike Sublime Text 2 or Vim, you have to use an entirely separate editor to edit plugins &#8212; Intellij IDEA Community Edition. The good news is that it&#8217;s free.

The bad news? You have to write plugins in Java.

I&#8217;m going to save additional details about writing plugins for a potential future blog post, after I write a couple more Intellij plugins to get experience. However, in summary I&#8217;ll say that I didn&#8217;t mind writing Java but I had a hell of a time finding comprehensive documentation on the plugin APIs.

## <span id="What_it_Feels_Like-17">What it Feels Like</span>

It feels like you&#8217;re writing Java despite your love of Python. From an entirely different editor with its own configuration file. Because you are.

## <span id="Downsides-17">Downsides</span>

The only real downsides to writing Intellij plugins that I&#8217;ve found &#8212; in my small amount of experience &#8212; are that the API documentation is pretty sparse and you have to upload plugins to a central plugin repository administered by JetBrains. That&#8217;s how they make plugins discoverable, and I assume they run some malware detection on uploaded plugins. Right? Right??