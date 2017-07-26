---
title: 'The Rule of Three'
date: 2017-07-13
author: Andrew
layout: post
permalink: /technology/the-rule-of-three/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology
---
Many programmers feel a desire to create reusable components early in the development process. I know I do! So why does following that urge so often lead to building the wrong abstraction?

The process goes something like this:

- Start writing a feature
- Realize that part of it is used in two places
- Begin writing a reusable component to avoid repeating yourself

After all, one of the first things many programmers learn when they start working in teams on real projects is, "don't repeat yourself." Reduce, reuse, abstract!

Taken to the extreme, this drive to remove duplication is a toxin of the mind, yielding problem-ridden components that solve too-specific problems and thus require constant modification rather than extension. This is the opposite problem of extreme code duplication, but the result is practically the same; in either case, you have to make more changes than necessary to get anything done. All is not lost, however. Some of us have discovered an antidote[^1].

It's simple: **when reusing code, copy it once, and only abstract the third time**. This is the "rule of three."

The principle behind the rule is that it's easier to make a good abstraction from duplicated code than it is to refactor the wrong abstraction. That's my take, anyway.

## What is the Point of the Rule of Three?

Good question. I mean, you want to avoid writing the wrong abstraction. If you don't have a sense for why that is, let's explore two aspects of bad abstractions: writing and maintaining them.

### Writing Bad Abstractions

The first stage of awareness is not noticing this problem at all. You start working on a new concept used in only one place. (Junior developers especially don't seem to need even code duplication to fall into this trap.) "One place... so far!" you tell yourself, expecting that you'll need another one like it soon enough. So you build a "reusable" piece with a piece that uses it. Of course, there are problems. Fixing the problems now involves refactoring both the reusable piece and the piece that uses it. Pretty soon, you're confused about whether new code should go into the reusable piece or the other piece. Every change involves more work than expected. Eventually, you deliver the two pieces and move on, a little shaken.

The confusion about what goes into the reusable piece versus the piece that uses it is a sign that something might be wrong. You may be confused because you tried to make something reusable too early.

Note that everything about this stage can also occur even if there are two pieces that use the abstracted piece; it's just a little more likely that the abstraction is useful.

The next stage of awareness is that you notice the abstraction might be wrong half-way through building a reusable piece. Instead of continuing down that path, you document your idea, tell your team you took a false turn, and get back to work.

The next stage is that ideas to build reusable pieces come to you continually, but you ignore these unless you or someone else has already copied code once, and this is now the third time it will be used. Only *then* do you try to build something reusable.

In any event, a year or two later, another team comes along and rewrites the entire codebase.

### Maintaining Bad Abstractions

Bad abstractions are hard to extend. They're either too specific, because they were written without enough known use cases, or needlessly generic in an attempt to cover too many possible use cases.

Worse, you usually stumble onto this code while trying to fix a bug or add a small feature somewhere else; there's little time to fix the bad code, which has enmeshed itself in the rest of the project.

Of all the reasons that code can be low quality, bad abstractions are the hardest to see at first. Most code is somewhat difficult for the uninitiated to penetrate, but there are types of quality problems like lack of test coverage that breed obviously problematic code: untested paths with lots of comments and paranoid exception handling, for example. Bad abstractions, on the other hand, can have 100% test coverage and only break when you try to change something that depends on them.

So beware!

## Consequences of the Rule of Three

Let's be real. We're talking about allowing code duplication in the service of avoiding bigger problems. There are consequences:

- Practicing the rule is difficult, and feels kind of like letting fields lie fallow
- There is a reason for the "don't repeat yourself rule": copying code adds a maintenance burden

Despite these consequences, the rule of three is one of the great mind hacks that programmers can use to avoid doing unnecessary work and to produce better abstractions, leading to more software of higher quality delivered on time. That is, if you can accept a little duplication. Try it a bit and see for yourself!

[^1]: One of my former bosses, Keith Fahlgren, hammered the Rule of Three into my brain.
