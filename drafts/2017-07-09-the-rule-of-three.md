# The Rule of Three

> Wherever two or three are gathered in my name, I am there.

-- Jesus

Many programmers, including me, feel a desire to create reusable components early in the development process. More often than not, this leads to building the wrong abstraction.

The process goes something like this:

- Write part of a feature
- Realize that what you just wrote could be made reusable
- Begin writing a reusable component
- Notice that the complexity of the task has suddenly grown
- Feel so invested that you continue until you produce ... something

This happened so often during my first few years of programming that I have to conclude I'm sick, but eventually I discovered [^1] an antidote!

It's quite simple: **when reusing code, copy it once, and only abstract the third time**. This is the "rule of three."

The principle behind the rule is that it's easier to make a good abstraction from duplicated code than it is to refactor the wrong abstraction.

## What is the Point of the Rule of Three?

Good question. I mean, you want to avoid writing the wrong abstraction. If you don't have a sense for why that is, let's explore two aspects of bad abstractions: writing such code and trying to maintain it.

### Writing Bad Abstractions

At first, you don't notice this process at all. You start working on a new concept used in one place. "One place... so far!" you tell yourself, and you build a "reusable" piece with a piece that uses it. Of course, there are problems. You fix the problems, but fixing them now involves refactoring both the reusable piece and the piece that uses it. Pretty soon, you're confused about whether new code should go into the reusable piece or the other piece. Every change involves more work than expected. Eventually, you deliver the two pieces and move on, a little shaken.

The confusion about what goes into the reusable piece versus the piece that uses it is key. You're confused because you tried to make something reusable too early.

The next stage of awareness is that you notice half-way through building a reusable piece for a new concept that you aren't sure about the best way to make it reusable. You're starting to fall behind, but instead of continuing down the path, you tell your team you took a false turn. You deliver one piece a little late.

In my opinion the next stage is that ideas to build reusable pieces come to you continually, but you ignore these ideas unless you or someone else has already copied code once, and this is now the third time it will be used. Only *then* do you try to build something reusable, and you do so with caution.

In any event, a year or two later, another team comes along and rewrites the entire codebase.


### Maintaining Bad Abstractions

Bad abstractions are hard to extend. They're often both too specific, because they were written with a single use case in mind, or they're needlessly generic in an attempt to cover many possible use cases.

Worse, you usually stumble onto this code while trying to fix a bug or add a small feature; there's no time to fix the bad abstraction.

## Consequences of the Rule of Three

- Freedom
- You have to copy code, which adds a maintenance burden
- It's easier to make a good abstraction from copied code than to refactor a bad abstraction
- You make the right abstraction -- or none at all, because it wasn't needed

# The Opposite

I'm not sure if there's a name for this. It's writing bad software: everything is copied everywhere, nothing is reusable, everything is a bunch of spaghetti. (And just hacks to get things done fast?)

[^1] Actually my old boss Keith Fahlgren hammered the Rule of Three into my brain.
