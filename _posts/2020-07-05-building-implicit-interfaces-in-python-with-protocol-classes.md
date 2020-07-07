---
title: Building Implicit Interfaces in Python with Protocol Classes
date: 2020-07-05
author: Andrew
layout: post
permalink: /technology/building-implicit-interfaces-in-python-with-protocol-classes/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - technology
  - Python
image:
  feature: IMG_Jul52020at90431PM.jpg
manual_newsletter: false
---

Python 3.8 shipped one of the coolest features I've seen in a recent Python version: protocol classes.

This feature lets you build interfaces and check that objects satisfy them implicitly, much like you can in Go. You might call this _static duck-typing_.

Intrigued? Let's check out how protocol classes work by writing some code.


## The Five-Minute Version

If you just want to see how this works, check out the following code. It doesn't do much -- but it _does_ fail static type-checking with `mypy`...

```python
from typing import Protocol


class Flyer(Protocol):
    def fly(self) -> None:
        """A Flyer can fly"""


class FlyingHero:
    """This hero can fly, which is BEAST."""
    def fly(self):
        # Do some flying...


class RunningHero:
    """This hero can run. Better than nothing!"""
    def run(self):
        # Run for your life!
   

class Board:
    """An imaginary game board that doesn't do anything."""
    def make_fly(self, obj: Flyer) -> None:   # <- Here's the magic
        """Make an object fly."""
        return obj.fly()


def main() -> None:
    board = Board()
    board.make_fly(FlyingHero())
    board.make_fly(RunningHero())  # <- Fails mypy type-checking!


if __name__ == '__main__':
    main()


```

Did you catch that?!

We have a `Flyer`, a `FlyingHero`, and a `Board`. The `Board` can make things fly -- but it can only make things fly that _can fly_.

This doesn't mean the `Board` can only make things fly that subclass `Flyer`. Notice that `FlyingHero` **doesn't subclass `Flyer`**.

Protocol classes allow us to define an interface, called a protocol, and use static type-checking via mypy to verify that objects satisfy the interface -- without classes having to declare that they satisfy the interface or subclass anything.

So, why is this called a "protocol" and what kinds of things is it good for?

Let's go deeper to answer those questions.


## Protocols

The built-in function `len()` works with any object that has a `__len__()` method. Objects don't have to declare that they have a `__len__()` method or subclass any special classes to work with `len()`.

Python programmers call this state of affairs a protocol, and the most common example is probably the iteration protocol. So is "protocol" in this context just a fancy word for "interface?"

Not exactly.

A protocol usually entails a set of methods that begin and end with double-underscores that define some behavior like iteration.

But exactly what's in that set of methods? Until Python 3.5, you had to find documentation to answer that question.

Python 3.5 defined the methods in each protocol formally, but did so using abstract base classes in the [collections.abc](https://docs.python.org/3.5/library/collections.abc.html) module.

If you wanted to hook into a protocol, you could use an ABC as documentation -- but you couldn't use `mypy` to check that an object implemented the protocol unless the object subclassed one of these ABCs.

That goes against the nature of protocols because they've always relied on duck typing, or the ability of a Python program to check the behavior of an object -- through its attributes and methods -- rather than its type. 

Where am I going with all this?

Well, Python 3.8 fixed the problem by creating machinery that `mypy` could use to check if an object implements a protocol: protocol classes.


## Protocol Classes

While interfaces are explicit in Java, Python's protocols have always been ... well, invisible!

Python 3.8's protocol classes make protocols more explicit. In effect, protocols become more like interfaces in Go.

First, you define a protocol class:

```python
class Flyer(Protocol):
    def fly(self) -> None:
      """A Flyer can fly"""

```

Then you can use the protocol class as a type annotation and `mypy` will check that an object implements the protocol.


```python
class Board:
    """An imaginary game board that doesn't do anything."""
    def make_fly(self, obj: Flyer) -> None:   # <- Here's the magic
        """Make an object fly."""
        return obj.fly()

```

The code `obj: Flyer` is the important part -- this is the type annotation that `mypy` can now use to check if `obj` implements the `Flyer` protocol.


So, what can you use this for?

Any time you would use an interface in another language, you can now do the same thing with protocol classes in Python.

Where previously you might have defined an ABC and subclassed it as a way to define (and type-check, with `mypy`) an interface, you can now use a protocol class.

This is especially useful if you're writing a library and want to make it easier for users to hook into your system with custom types.

For more on the reasoning behind this feature, [check out the PEP](https://www.python.org/dev/peps/pep-0544/) that proposed it.


## A Longer Example

I extracted the five-minute example that started this post from a longer, but still single-file, example.

I present it to you here, as in programming listings found in the paper magazines of yore.

```python
"""
protocol_classes.py: An example of using protocol classes.
"""

from dataclasses import dataclass
from enum import Enum
from typing import Any
from typing import Protocol


class Direction(Enum):
    N = 'n'
    E = 'e'
    S = 's'
    W = 'w'
    NE = 'ne'
    SE = 'se'
    SW = 'sw'
    NW = 'nw'


@dataclass
class Movement:
    """A movement by an object in a direction."""
    obj: Any
    distance_meters: int
    direction: Direction


class Waiter(Protocol):
    def wait(self, actions_spent: int, direction: Direction) -> Movement:
        """A Waiter can wait"""


class Flyer(Protocol):
    def fly(self, actions_spent: int, direction: Direction) -> Movement:
        """A Flyer can fly"""


class Runner(Protocol):
    def run(self, actions_spent: int, direction: Direction) -> Movement:
        """A Runner can run"""


class BaseHero:
    @property
    def max_speed(self) -> int:
        return 1

    def wait(self, actions_spent: int, direction: Direction) -> Movement:
        return Movement(obj=self, distance_meters=0, direction=direction)


class RunningHero(BaseHero):
    """This hero can run, which is better than nothing."""
    @property
    def run_speed(self) -> int:
        return self.max_speed * 2

    def run(self, actions_spent: int, direction: Direction) -> Movement:
        return Movement(obj=self,
                        distance_meters=self.run_speed * actions_spent,
                        direction=direction)


class FlyingHero(BaseHero):
    """This hero can fly, which is BEAST."""
    @property
    def fly_speed(self) -> int:
        return self.max_speed * 5

    def fly(self, actions_spent: int, direction: Direction) -> Movement:
        return Movement(obj=self,
                        distance_meters=self.fly_speed * actions_spent,
                        direction=direction)


class Board:
    """An imaginary game board that doesn't do anything."""
    def make_wait(self, obj: Waiter, direction: Direction,
                  actions_spent: int) -> Movement:
        """Make an object wait.

        ``obj`` is the object to make wait
        ``actions`` is the number of consecutive actions taken to wait

        Returns the total distance in meters that ``piece`` moved on the board
        while waiting (could happen...).
        """
        return obj.wait(actions_spent, direction)

    def make_run(self, obj: Runner, direction: Direction,
                 actions_spent: int) -> Movement:
        """Make an object run.

        ``obj`` is the object to make run
        ``actions`` is the number of consecutive actions taken to move

        Returns the total distance in meters that ``obj`` moved on the board.
        """
        return obj.run(actions_spent, direction)

    def make_fly(self, obj: Flyer, direction: Direction,
                 actions_spent: int) -> Movement:
        """Make an object fly.

        ``obj`` is the object to make fly
        ``actions`` is the number of consecutive actions taken to move

        Returns the total distance in meters that ``obj`` moved on the board.
        """
        return obj.fly(actions_spent, direction)


def main() -> None:
    board = Board()
    waiter_move = board.make_wait(BaseHero(), Direction.N, 2)
    runner_move = board.make_run(RunningHero(), Direction.NW, 2)
    flyer_move = board.make_fly(FlyingHero(), Direction.S, 2)
    heroes = (('Hero', 'Total spaces moved (M)'),
              ('a waiting hero', waiter_move.distance_meters),
              ('a running hero', runner_move.distance_meters),
              ('a flying hero', flyer_move.distance_meters))
    print('\n')
    for description, movement in heroes:
        print("\t{:<22} {:>25}".format(description, movement))


if __name__ == '__main__':
    main()


```

---

Photo by Alex Smith.

