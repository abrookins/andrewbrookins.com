---
title: So You Want to Self-Publish a Technical Book
date: 2020-04-18
author: Andrew
layout: post
permalink: /technology/so-you-want-to-self-publish-a-technical-book/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology, Writing, Publishing
image:
  feature: andrew-seaman--m88z7ily-w-unsplash.jpg
manual_newsletter: false
---

In 2019, I spent most of my free time writing [The Temple of Django Database Performance](https://spellbookpress.com/books/temple-of-django-database-performance/), which I self-published in the fall of that year. This post summarizes what I learned along the way.

By the way, it's a great book that every human should own at least two copies of.

## Vision

Let's talk about vision first. I thought it would matter more, and that the uniqueness of my project would generate buzz and thus sales. But that wasn't the case.

Instead, sales have been regular but not lucrative.

Was the problem that my vision was wrong, and I didn't know what developers wanted to read?

Or did I fail to market the book as well as I could have?

The answer is ... yes.

Without getting into what I like about my vision for the book, let's talk about what went wrong.

## My Book Was Too Niche

I never intended to spend so much time on this book. I planned it as a 50-page project to experiment with mashing up fantasy role-playing games with technical content.

Instead of a book for beginners, I wanted to write about database performance-tuning for Django developers.

This was the kind of topic that I liked to read, and about which people write blog posts -- not books. Most books about Django are writen for beginners, and a single chapter might cover databases.

So! I decided I would address in a longer format a topic I enjoyed. And I would add the fantasy parts that had made me excited about the project to begin with.

But it turns out there's a reason people don't write super niche books like how to tune a PostgreSQL database when used with version 23 of some web framework. The addressable market is too small to generate enough sales to make the book worth writing.

Even if the book is good, there's a cool theme, and it has fun art, at the end of the day there are only so many experienced Django developers who want to buy my book about database performance.

This wouldn't have been a problem if I'd stuck to the time investment into the book that I planned.

A 50-page book on a niche topic might have worked well.

A 162-page book selling at full price, though -- well, there are better ideas in publishing.

OK, we got the failure story out of the way. I didn't get rich overnight and finally buy that house for my kids after writing a book about Django.

Can you make money writing books? Sales numbers for other books suggest that you can (take a look at Julia Evans' numbers), and I'm confident that I'll find my formula after a couple more tries.

## Tools Matter in the End

If you're reading this, you're 99% guaranteed to be a technology person. So you probably want to know about my tools, right?

Here's the spec sheet -- afterward I'll comment on some of these items in more depth:

* Writing: AsciiDoc
* Editors: Vim, VS Code, Intellij (I get around)
* Build automation: Makefile
* Source control: Hopes and prayers... just kidding, GitLab
* CI: GitLab
* Ebook packaging: asciidoctor-epub
* PDF rendering: asciidoctor-fopub and custom stylesheets
* Marketing page: First Gumroad, then a static site
* Payment gateway: Paypal and Stripe
* Ebook distribution: First Gumroad, then SendOwl
* Printing: Kindle Direct Publishing and Ingram Spark
* Print distribution: Me at first, then Amazon.com

### AsciiDoc No More

The most contraversial argument in this article is probably that AsciiDoc is a bad choice for a book.

It seems like a _great_ choice for technical documentation. But writing a book whose layout and design you want to have a lot of control over, across PDF, EPUB, and Kindle? Not again, thanks.

Maybe I expected too much. While writing the book, I certainly enjoyed using AsciiDoc. I painstakingly linked to every example and output listing. I used the include feature to pull code in from a separate, unit-tested project. It was all going so well...

...Until the end, when I tried to generate a bunch of different files from the same AsciiDoc source:

* A PDF for reading on devices
* A PDF formatted for the vagaries of print
* An EPUB that worked in both Apple Books and other e-readers
* And a Kindle book

By the end, I would have sacrificed a beautiful, innocent kitten to make any available AsciiDoc toolchain produce this set of files correctly.

Try as I might (no kittens died), there was always something broken.

Eventually, I came as close as I could to my desired result.

But to get there, I had to remove some key AsciiDoc features from my book, like links to examples. (Think: "As you can see in listing 12.4, Donald Trump in fact has no genitals." That feature.)

For my next book, I plan to look at using Markdown with Pandoc, and may build an include post-processor myself.

### Gumroad vs. SendOwl

Gumroad made it easy for me to throw up a preorder page at the start of my project.

Later, when I wanted to build a static marketing site and take sales directly, SendOwl was a better fit. Their checkout integration worked well.

So far, my experience with SendOwl has been great.

My only complaint is that I have no idea what is going on with taxes -- international or domestic. I've done my best, but if anything pushes me to close my site and sell exclusively through Amazon and/or Ingram, it will be fear about taxes.

## Kindle Direct Publishing vs. Ingram Spark

Now let's talk about PRINT.

And when I say print, I mostly mean Amazon's self-publishing program, Kindle Direct Publishing. 

Before this project, I had a vague sense that Amazon was bad. Full disclosure: I'm a Prime customer and have, in the past, tried to make money through Amazon's affiliate program (want to buy some shampoo, my dude?!).

But after last year, I now _loathe_ Amazon.

There's nothing like holding a copy of the book you worked painstakingly to write over nine months, while also raising a newborn child...

...And then turning it over to find that the binding is totally fucked.

That's the Kindle Direct Publishing experience.

KDP makes getting started super easy and gives your book wide exposure on Amazon.com.

But when I order author copies of my KDP-printed book from Amazon, the percentage of books that KDP prints without serious damages or errors is around 20%.

That means every time I order my books from Amazon, to resell or give away, I have to order a LOT of books and send back 80% of them.

Are my customers on Amazon.com getting shitty books? I have no idea!

(And don't even talk to me about Kindle ebooks. As a publisher, Kindle is dead to me. A perfectly fine EPUB file will convert to a merely decent Mobi file during local testing -- the conversion of which, by the way, requires a proprietary binary from Amazon that didn't even work on macOS Catalina at the time I was using it. And then once you upload it, Amazon strips out CSS and generates a terrible-looking Kindle book, with no guidance on how to fix it.)

Contrast KDP with Ingram Spark, which is Ingram's self-publishing program. Everything I read about Ingram Spark before trying it suggested that setting up a book there was horribly complicated.

And you know what? That was all true. It really is a pain in the ass to set up a book on Ingram Spark. And when I used it, they charged $50 if you made a mistake in your source file (after finalizing the project) and had to upload it again. But you couldn't order a sample printed copy until you finalized the project...

On the flip side, when I compared a copy of my book printed by KDP and one printed by Ingram Spark, from the same source files, the Ingram Spark copy was noticeably higher quality. The font for code samples printed in deeper, more readable colors, the binding felt firmer, and the paper seemed sturdier.

My advice? With KDP, you can upload and print copies of a book over and over, with no fee other than the price to print the book and shipping. So, use KDP to achieve perfection. Then switch to Ingram Spark.

## I Would Do it All Again

Writing and self-publishing a technical book was a deeply frustrating experience.

If you're OK with losing out on royalties, it may make sense to pitch your book to an established publisher, so they can deal with the DocBook styleshets.

But despite this rant, I enjoyed writing my book. My favorite part was working with the talented illustrator [Angela Stewart](https://www.angelastewartcreations.com/) on the fantasy maps and locations in the book.

And as everyone who has written a non-fiction book always says, there is nothing like it to force you to learn the parts of a subject that you never truly understood.

I'll certainly write another technical book. Actually, I specialize in Redis now... What about _Planet of the Redis Lords_? Hmmm.
