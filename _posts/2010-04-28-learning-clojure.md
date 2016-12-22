---
id: 176
title: Learning Clojure
date: 2010-04-28T07:51:13+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=176
permalink: /tech/learning-clojure/
categories:
  - Technology
---
Clojure is a new functional language for the JVM. This post is a collection of links, articles, screencasts and free books I&#8217;ve found to help me learn the language and understand functional program design.

[<img src="https://andrewbrookins.com/wp-content/uploads/2010/04/clojure-icon1.gif" alt="clojure icon" title="clojure-icon" width="100" height="100" class="alignleft size-full wp-image-180" />](https://andrewbrookins.com/wp-content/uploads/2010/04/clojure-icon1.gif)

## <span id="Key_features">Key features</span>

Here are some key features of Clojure that I find extremely interesting:

  * Designed for concurrency
  * A Lisp dialect &#8211; functional, not mixed-paradigm like Scala
  * Compiles to Java bytecode
  * Easy interoperability with Java libraries
  * Immutable data structures
  * Manage state with transactions

A lot of this seems to blow away the languages I use on a regular basis, like Ruby and PHP. Furthermore I&#8217;ve had some misgivings lately about the gaggle of run-times I end up using as a multi-language programmer using mostly interpreted languages. So the fact that Clojure compiles to Java bytecode is a real selling point for me, despite my historical avoidance of Java.

## <span id="An_editor">An editor</span>

You&#8217;ll need an editor to start working with Clojure. Though I&#8217;m a Vim user, I could not get [VimClojure](http://kotka.de/projects/clojure/vimclojure.html) working right on my machine. Drop me a line if you got it running &#8211; hurray for you! 

If you are on Windows, I recommend the super-easy-to-install [Clojure Box](http://clojure.bighugh.com/). After a couple of clicks, you&#8217;ll have Emacs and a working Clojure REPL. &#8220;REPL&#8221; stands for Read/Eval/Print/Loop. It&#8217;s like IRB for Ruby; an interactive development tool. Emacs makes it easy to pass code into the REPL from an editing buffer, which of course you could do with a bit more elbow grease from Vim using a REPL you spawned on the command line. 

## <span id="Some_theory">Some theory</span>

Now you need to beef up on why Clojure is awesome. The best place is the horse&#8217;s mouth: Rich Hickey, the creator of Clojure, has released a number of essays, screencasts and lecture notes describing the benefits of his language. 

### <span id="Screencasts">Screencasts</span>

  * [Rich&#8217;s podcasts](http://itunes.apple.com/us/podcast/clojure/id275488598) on iTunes
  * Various screencasts on [Channels.com](http://www.channels.com/episodes/3590109)
  * A video on [concurrency in Clojure](http://blip.tv/file/812787)
  * A video on [state and identity](http://www.infoq.com/presentations/Value-Identity-State-Rich-Hickey)

### <span id="Essays">Essays</span>

  * [Rationale for Clojure](http://clojure.org/rationale)
  * On [state and identity](http://clojure.org/state)

## <span id="Syntax">Syntax</span>

Time to start writing some code! A great place for an overview is the [Clojure home page](http://clojure.org/getting_started). However, the site can be a little overwhelming or, if you read it a bunch of times, underwhelming. So it is time to branch out and see what the world has to offer. 

What we are looking for are introductory examples of Clojure code and more advanced samples of real code. 

### <span id="Blog_posts">Blog posts</span>

  * [Clojure for the Non-Lisp Programmer](http://www.moxleystratton.com/article/clojure/for-non-lisp-programmers)
  * [Clojure Programming Cookbook](http://en.wikibooks.org/wiki/Clojure_Programming/Examples/Cookbook) and [Clojure Programming](http://en.wikibooks.org/wiki/Clojure_Programming)
  * [Building an Ikeda map with Clojure](http://www.bestinclass.dk/index.php/2009/09/chaos-theory-vs-clojure/)
  * Rich Hickey&#8217;s [code for an Ikeda map](http://paste.lisp.org/display/87799)
  * [Cellular automation visualization in Clojure](http://www.bestinclass.dk/index.php/2009/10/brians-functional-brain/)

### <span id="Not-Free_Books">Not-Free Books</span>

Sometimes, you just need to read a book. Right now, there isn&#8217;t much published about Clojure &#8211; but I recommend Stuart Halloway&#8217;s _Programming Clojure_.

  * [Programming Clojure](http://www.pragprog.com/titles/shcloj/programming-clojure), by Stuart Halloway
  * Rich Hickey&#8217;s [list of books that influenced Clojure](http://www.amazon.com/Clojure-Bookshelf/lm/R3LG3ZBZS4GCTH)

Otherwise, a bunch of books are in &#8220;alpha&#8221; or pre-release stages from the major book publishers, so the dearth of material should improve by the end of 2010 and early 2011, I assume.

## <span id="Functional_programming">Functional programming</span>

The big elephant in the room! The design of Clojure programs is &#8212; or _ought_ to be &#8212; different than those written in object-oriented languages like Ruby and Java. I am still wrestling with functional program design, but thanks to the Clojure community and a lot of Googling I have found some sources to help. 

### <span id="Free_books">Free books</span>

Since Clojure is a Lisp, reading books on Lisp seems like the best approach to learning about the kind of designs that fit naturally into Clojure. Of course, there is also the awesome factor that your programs can interact with Java libraries, which changes things. But if, like me, you have never programmed in a Lisp or any functional language, then &#8212; _first things first_, as the saying goes. 

  * [Practical Common Lisp](http://www.gigamonkeys.com/book/) &#8212; hurray, Peter Siebel!
  * [On Lisp](http://lib.store.yahoo.net/lib/paulgraham/onlisp.pdf), by Paul Graham
  * [The Structure and Interpretation of Computer Programs](http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-4.html#%_toc_start)

### <span id="Blog_posts-2">Blog posts</span>

  * [Lisp for the Web](http://www.adampetersen.se/articles/lispweb.htm) &#8212; a web app in Lisp: awesome!

## <span id="Community">Community</span>

Really, the best thing would probably be to join the [Clojure Google group](http://groups.google.com/group/clojure?pli=1), and to search the archives for questions you might have. A lot of OO language people seem to wash up on the Clojure beach and they (we) tend to have similar questions.