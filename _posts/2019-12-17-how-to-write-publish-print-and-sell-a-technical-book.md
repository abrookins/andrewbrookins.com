---
title: 'How to Write, Publish, Print, and Sell a Technical Book, Part 1: Preparation'
date: 2019-12-20
author: Andrew
layout: post
permalink: /publishing/how-to-write-publish-print-and-sell-a-technical-book-part-1-preparation/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Publishing, Writing
image:
  feature: typewriter.jpg
manual_newsletter: true
---

I started writing [The Temple of Django Database Performance](https://spellbookpress.com/books/temple-of-django-database-performance/) in January of this year and finished it in November.

This article records everything I learned about the process of writing a technical book while the knowledge is still fresh, both for my future self and anyone interested in doing the same.

## Overview

I will discuss the following topics:

- Inspiration
- Why self-publish?
- Selecting a topic
- Writing the outline
- Preparing the writing tool-chain
- Actually writing the book
- Technical review
- Copy-editing
- Designing the interior and cover
- Choosing a printer
- Building a book landing page
- Taking payments
- Marketing
- Shipping the book to customers

There's a lot of material. You may want to liberate this writing from the internet by printing it.

## A Note About Money

I'm not going to share numbers about my profits from the book. I will, however, share the costs involved in making the book, which marketing approaches have been effective in getting people to buy it, and my conversion rates.

## Inspiration

You no doubt have your own inspiration for writing a technical book. The process of actually writing a book is so grueling that you should write down whatever this inspiration is so that you can refer to it in times of need.

In my case, there are two exemplary books that inspired me and to which I referred often while writing.

<a href="https://www.amazon.com/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321/ref=as_li_ss_il?crid=3VR3MNRHWZR42&keywords=designing+data-intensive+applications&qid=1576620045&sprefix=designing+data-in,aps,264&sr=8-1&linkCode=li3&tag=andrewbrookin-20&linkId=5aeb8d0dc548796aa245ec9475cad866&language=en_US" target="_blank"><img class="auto" border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=1449373321&Format=_SL250_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=andrewbrookin-20&language=en_US" ></a><img src="https://ir-na.amazon-adsystem.com/e/ir?t=andrewbrookin-20&language=en_US&l=li3&o=1&a=1449373321" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

_Designing Data-Intensive Applications_ by Martin Kleppmann is an epic ride through databases and distributed systems. At 616 pages, you have to bring your own motivation to read the whole thing -- I recommend starting a book club at work.

<a href="https://www.amazon.com/Fluent-Python-Concise-Effective-Programming/dp/1491946008/ref=as_li_ss_il?keywords=fluent+python&qid=1576621375&sr=8-3&linkCode=li3&tag=andrewbrookin-20&linkId=f4fb099541d8f7bb6dae4871eb08ca5b&language=en_US" target="_blank"><img class="auto" border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=1491946008&Format=_SL250_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=andrewbrookin-20&language=en_US" ></a><img src="https://ir-na.amazon-adsystem.com/e/ir?t=andrewbrookin-20&language=en_US&l=li3&o=1&a=1491946008" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

_Fluent Python_ is just bursting with the author's love of the Python programming language. It's a joyous book full of excellent detail, including the first reference I'd seen to [The Art of the Meta-Object Protocol](https://amzn.to/38MX5mV).

In addition, I've been following the work of [Julia Evans](https://jvns.ca/) for a while now. Julia writes fun and informative zines on programming and technical topics that sketch a lively overview and leave you thirsty for more. Motivating people to learn is a huge problem in learning design, and she nails it.

<!--She collected some of her zines into a print book this year, titled _Your Linux Toolbox_.-->

<!--<a href="https://www.amazon.com/Your-Linux-Toolbox-Julia-Evans/dp/1593279779/ref=as_li_ss_il?keywords=julia+evans&qid=1576619825&sr=8-1&linkCode=li3&tag=andrewbrookin-20&linkId=f10cc27dd1c4f5f0790e17375219d102&language=en_US" target="_blank"><img class="auto" border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=1593279779&Format=_SL250_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=andrewbrookin-20&language=en_US" ></a><img class="auto" src="https://ir-na.amazon-adsystem.com/e/ir?t=andrewbrookin-20&language=en_US&l=li3&o=1&a=1593279779" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />-->

### But Still, Something was Missing
Aside from reading great technical content, a major piece of my inspiration was the feeling I've had for years that something was missing from the technical book market. There is a type of book I want to buy, but can't usually find. This mythical book is:

- Short (75-100 pages)
- Targeted at experienced software developers
- Focused on a single topic
- Fun to read!

[The Temple of Django Database Performance](https://spellbookpress.com/books/temple-of-django-database-performance/) was my attempt to satisfy all of those points. Read on to see how it turned out.

## Self-Publish or Pitch to Publishers?

Deciding whether to self-publish or pitch your idea to a publisher is a foundational step in any book project. If you expect a publisher to publish the book, you need to make sure at least one of them is interested before you write it!

Self-publish and you can write whatever you want. You take all of the risk, but you also keep your copyright and retain 100% of the royalties.

What's my preference? Having worked for two publishing companies in my career (Dark Horse Comics and O'Reilly Media), you might think that I would prefer traditional publishing, but nope. This article is all about self-publishing!

The problem with publishing companies is that most will want to take portions of your copyright, a majority cut of the royalties, and creative control of your book. Meanwhile, they expect you to do your own marketing. Yikes!

If you're going to do all the work to write a book, you might as well keep 100% of the royalties and retain full creative control.

Having said that, I did not merely self-publish my book. Instead, I created a publishing company: [Spellbook Press](spellbookpress.com). One of my goals is to figure out how to improve the publishing experience for authors.

In the meantime, I recommend that you self-publish.

## Topic Selection

Selecting the topic for your book is huge. HUGE. Here are a few things that directly correspond to the topic:

- Your motivation to finish the book
- How many people will buy the book
- The price that people will pay
- The size of your competition

In my case, I had developed material for a book on creating microservices with the Python web framework Django. That might have been a natural fit to write my first technical book.

There was just one problem: the thing that I was **really excited about** at that moment was not microservices. Instead, I was obsessed with **databases**.

So I considered switching gears. Instead of writing a book on microservices, I would write one about databases. I wondered how small a market could sustain a technical book -- could I make any money by writing about database performance with Django?

Notice how minutely niche the title is. It's not _The Temple of Django Performance_, _The Temple of Database Performance_, or _The Temple of Python Performance_, three possibilities I considered.

No. The book is specifically about getting great database performance while using the Django framework. In fact, the original title was _Supernatural Django ORM Performance_ -- at first it dealt only with Django's Object-Relational Mapper.

There were very few books written on this topic, and I was interested in it. I already knew a lot about Django performance and relational databases, but I was also excited to learn more. It seemed like a great fit.

### The Takeaways

Choose your topic with the following in mind:

- It should be a topic you're excited about
- It should be a topic about which few books have already been written
- It should be a topic that a group of people actually care about (your audience)

It's easy to find topics that you're excited about, and it's also trivial to do a web search to find out how many books are written on a topic. It's harder to estimate the size of a potential book's audience.
 
In my case, I considered writing about Django because **lots of people read my Django blog posts**. I have actual evidence that Django developers exist, and my hypothesis is that they will buy a book positioned as the one book every Django developer should read.

## Writing the Outline

However much you know about the topic you want to write about, I assure you that in order to write a good book about it, you'll need to know more.

Unlike a blog or social media post, you can't just hand-wave around the areas of the topic that you don't understand well. People are buying your book because you are an expert on the topic. You're going to give them a quality product in which no stone is left unturned!

So, how much more do you need to know? Well, you can only find that out by starting to work on **the outline**. This is the document that maps out the sections and chapters in the book.

If you were pitching your idea to a publisher, they would want to see your outline. It's a critical part of the pitch that the publisher uses to decide things like:

- How well you can write
- How well you can organize information
- How much you (say you) know about the topic
- How marketable the content might be

And more.

To you, a self-publisher, the outline has different benefits. It allows you to quickly restructure the entire book without having written any of it.

It's also going to be your first window into areas of the topic that you need to research further.

Here's a very high-level outline (no chapter headings or anything, just
concepts) that I created while preparing to write [The Temple of Django Database Performance](https://spellbookpress.com/books/temple-of-django-database-performance/):

<img src="/images/bookoutline.jpg">

This reflected my early chapter planning: Profilng, Indexing, Requesting Data, Moving Work to the Database, and Advanced Topics.

In the end I combined some of those chapters and simplified their names, so the final chapter list was: Profiling, Indexing, Querying.

## Preparing the Writing Toolchain

When you work with a publisher, the publisher typically has a workflow that all authors use to write their books. That may be writing drafts in Microsoft Word files which are sent around to various reviewers and editors and returned to the author with comments. Or the author might write in AsciiDoc files and receive comments through a custom system maintained by the publisher.

When the writing, review, editing, cover design, interior design, and art is all complete for a book, the publisher then converts it into various file types: a PDF for customers (if desired), a print-specific PDF for the printers, a MOBI/KF8 file for distributing via Amazon Kindle, and an EPUB file for submission to most other ebook markets.

As a self-publisher, you need to develop a toolchain that will allow you to do all of the same things.

Many self-pubilshers write in Markdown ,
