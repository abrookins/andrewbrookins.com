---
title: 'Starting a Publishing Company: Month 1'
date: 2019-02-04
author: Andrew
layout: post
permalink: /publishing/starting-a-publishing-company-month-1/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Publishing
image:
  feature: openbook.jpg
manual_newsletter: true
---
I started a publishing company! Spellbook Press launched this week, taking preorders for our first book, [Supernatural Django ORM Performance](https://gumroad.com/products/MeGbM). Check it out!

## The Idea

I've wanted to run a publishing company for years. I've also known for a long time that I want to publish short, focused technical books on niche topics.

However, it was only last fall that I felt strongly enough about the theme of the company to start working. The concept I decided on was **focused books between 30 and 100 pages on technical topics with a fantasy theme**.

For examples of well-done technical titles within this page range, see ["The Log"](https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying) by Jay Kreps or [Jesse Storimer's books](https://www.jstorimer.com/pages/books).

Aside from the length, I wanted every book to follow certain rules inspired by D&D adventures. For example:

- The cover would feature a full-color fantasy illustration
- The experience level would be explicit ("For adventurers level 1-3")
- The interior would contain fantasy art and maps of technical concepts

## Cover Design

I first envisioned publishing stapled-together books with a design similar to the iconic 1st Edition Dungeons & Dragons modules from the 80s. If you haven't seen these books, they look like this:

[![Adventure Module U3: The Final Enemy](https://www.drivethrurpg.com/images/44/17071.jpg)](https://www.drivethrurpg.com/product/17071/U3-The-Final-Enemy-1e?it=1)

As I doodled cover mockups, I became less certain that technical books using a D&D-inspired cover would appeal to readers. Instead, I tried to combine fantasy art with enough whitespace that the cover would fit in on a bookshelf with the likes of O'Reilly and Pragmatic Programmers. That way, if I could get a print version of the book on the shelf at my favorite local book store, [Powell's Books](https://powells.com), someone might buy it.

![Django Microservices](/images/django-microservices-mockup.png)

In my "refined" version of the cover design, there is a meaningful color (probably for series identification), a fantasy illustration, and runes on some combination of the front, back, and spine.

Now I just need is a designer -- but I can't afford paying someone yet.

To help with this, I decided to publish two books in 2019 instead of one, so that I could use the first book to bootstrap better design for the second. The first book would be a shorter title on performance-tuning the Django ORM that I would give myself permission to botch design on. The second would be a longer book on building microservices with Django, with better design.

The image I hacked together for **Supernatural Django ORM Performance** with the Shutterstock editor and a piece of stock art looks like this:

![Supernatural Django ORM Performance](/images/orm-perf-small.jpg)

This isn't a cover that I want to publish, but I'd like to see if it's good enough to sell preorders.

I'm still torn between having a "weird" design that stands out and a normal-ish cover with a fantasy illustration. But at least now I can run an experiment: will anyone preorder?

## Interior Design
So, the exterior will feature a fantasy illustration. But what about the interior? Here is my mockup:

![Chapter Interior](/images/chapter-interior.png)

The most important element of the interior design of a Spellbook Press book is **the map**. Every book will have a fantasy-themed map of the concepts in the book, and every chapter will have a map of the concepts in the chapter. For an example of this, see the book *Designing Data-Intensive Applications*, by Martin Kleppmann.

The other distinctive element of the interior design is that the books will be scattered with fantasy illustrations and bits of themed text. For example, a blurb might appear in a sidebar or chapter introduction from a powerful wizard who expresses his disdain for vile unbounded queries.

{% include newsletter.html %}

## Learning Features

Aside from the text itself, I intend to build additional learning features into each book.

- Every book will offer **an audio version** at a higher price tier, and if video ends up being a popular request, then I will develop the same content from the book as a series of 3-5 minute videos.

- Every chapter will include **a quiz** in the text

The example application featured in both Django books I'm writing this year is a learning web app called Spellbook Quest that I plan to tie into the books. So, in the future, you could use Quest to keep track of your learning goals, add non-Spellbook content to a goal like "Learn Django Models," and complete quizzes from your Django Spellbooks interactively.

## Press Ethics

I think about ethics almost as much as I think about books and technology, and Spellbook Press will reflect this thinking.

Just as I believe that every software developer [serves the common good first](/technology/what-are-we-doing-here-software-engineering/), businesses must do the same. To serve the common good with Spellbook Press, I am committed to:

- Seeking [B Corporation](https://bcorporation.net/) certification in 2020
- Using 100% renewable power in all business operations
- Using technology and products that have the least harmful impact on the environment
- Developing [fair contracts](https://www.authorsguild.org/where-we-stand/fair-contracts/) with writers based on guidance from the Author's Guild
- Buying from Portland, Oregon, and United States businesses as often as is possible
- Employing workers at fair market rates
- Seeking out diverse authors, artists, and designers to work with
- Releasing an annual Social Responsibility report with details on all these commitments


## Experience Report: Month 1

What is it like to start a publishing company? I can tell you about my first month in business. Here is what I accomplished in January:

- Chose two topics for 2019: Django ORM performance and Django microservice design
- Put in about 40 hours of development work on code samples
- Told at least 10 people personally that I was starting a publishing company
- Reached out to publishing industry and artist acquaintances in my neighborhood to network
- Picked a name -- "Spellbound Press," which I had to revise to "Spellbook Press" because there was already a Spellbound River Press
- Read half of Joe Biel's [A People's Guide to Publishing](https://microcosmpublishing.com/catalog/books/3663) -- highly recommended
- Registered my business with Oregon State
- Designed a simple logo with [Logojoy](https://logojoy.com/)
- Registered [spellbookpress.com](https://spellbookpress.com) and signed up for [@SpellbookPress](https://twitter.com/SpellbookPress) on Twitter

I'm happy that services like Shutterstock and Logojoy exist. With zero design skills, I can still launch a business. Thanks, internet! By the way, here's the logo I chose:

![Spellbook Press](/images/publisher-logo.png)

## What I Want to Publish

*Supernatural Django ORM Performance* is an example of one type of book I want to publish: short, focused, and technical.

Along these lines, in 2020 I plan to publish at least one more book on the following topics:

- Building microservices with Django
- Deploying Django apps on Kubernetes
- Building microfrontends with Django and React

However, there are a slew of topics I want to publish short books about. In 2020 I'd like to publish topics like the following:

- Creating interactive text adventures with Twine or other tools
- In-depth explanations of a particular algorithm or protocol, like RAFT
- Building applications for IPFS
- Using Neovim, Visual Studio Code, Intellij IDEs, or Emacs
- Writing plugins for Neovim and other editors
- Primers on HIPAA, GDPR, and other regulations for programmers
- Histories of MUDs, BBSes, or IRC
- High-performance REST APIs with Falcon
- Deep explanations of how Docker layers work
- Monitoring Kubernetes-hosted applications in GCP and AWS
- Behind the scenes stories or architecture reviews of open-source projects
- The Gremlin query language and a graph database like Titan
- Adding inventory control to a Unity game
- Serverless web apps with Python and Google Cloud Platform
- Programming on Chromebooks, iPads, or Desktop Linux
- Dungeons and Dragons for programmers, or other "topic you love, but for programmers" books
- Interviews with programmers on a theme ("How did you get started in iOS development?")
- Path from programmer to manager

## Follow Me!

Want to hear more about this? Join my newsletter or follow [@SpellbookPress](https://twitter.com/SpellbookPress). If you have an idea for a book about one of the subjects I listed, get in touch! My email is "a @ andrewbrookins.com".
