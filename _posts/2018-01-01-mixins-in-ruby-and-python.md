---
title: 'Mixins in Python and Ruby Compared'
date: 2018-01-01
author: Andrew
layout: post
permalink: /technology/mixins-in-python-and-ruby-compared/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology, Ruby, Python
image:
  feature: david-clode-smaller.jpg
---

The venerable "mixin" is a technique I learned as a Python developer. Now, after writing Ruby code for the past year, I'm excited to compare how these two languages approach mixins, including similarities, differences, and traps. There will be code!

## Table of Contents
{:.no_toc}
* TOC
{:toc}

## What is a Mixin?

If you are unfamiliar with the term "mixin," here is my attempt at a definition:

 > Code that is shared among objects without being part of a concrete base class.

 I hope you get the idea, but if not, the code in this article may paint a clearer picture. For more details on the definition and etymology of the term, see [Appendix A](#appendix-a-definition-and-etymology-of-mixin).

## Mixins in Python

In Python, you implement a mixin by creating a class. Client classes then inherit the mixin class, often with other mixin classes and possibly a concrete base class.

I always end a mixin class name with "Mixin," which is a Python convention[^1].

### Adding Instance Methods

Let's say we're building a game and want to share movement behaviors around as discrete pieces of code. Various actors in the game will be able to move in ways like running and flying, so we'll create mixins for these behaviors:

```python
class RunnerMixin:
    def max_speed(self):
        return 4


class SortaFastHero(RunnerMixin):
    """This hero can run, which is better than walking."""
    pass


class SortaFastMonster(RunnerMixin):
    """This monster can run, so watch out!"""
    pass


```

(Set aside now any expectation you might have that code in this post will make sense beyond being simple examples of mixins.)

So, `RunnerMixin` is a class that provides an instance method, `max_speed`. `RunnerMixin` is inherited by `SortaFastHero` and `SortaFastMonster`. Instances of both of these classes will have a `max_speed` method.

Note that there is nothing actually different here between the two child classes simply sharing a base class. However, we've communicated our intent about `RunnerMixin` with its name: this is a mixin. That is, the class won't provide concrete base class functionality; its scope will be limited to "running."

In the future, we may add concrete base classes for monsters and heroes, which might look something like this:

```python
class SortaFastHero(RunnerMixin, BaseHero):
    """This hero can run, which is better than walking."""
    pass


class SortaFastMonster(RunnerMixin, BaseMonster):
    """This monster can run, so watch out!"""
    pass


```

In this example, the `SortaFastHero` and `SortaFastMonster` classes pick up running-related functionality with `RunnerMixin` and other, unspecified stuff from `BaseHero`. Presumably as we add game features, these classes might get new mixins added to their list of superclasses.

This is the basic concept: mixins in Python work via inheritance -- usually multiple inheritance. When an object receives a method call, the method is found via the Method Resolution Order algorithm[^2].

All of the fine details of how mixins work in Python follow from their using inheritance.

### Adding Class Methods

Adding class methods via mixins is simple in Python, since we're only talking about inheritance. Any methods you define in a class with the `staticmethod` or `classmethod` decorators will be inherited by child classes.

### Trap: The Order of Superclasses Matters!

There's an important gotcha about mixin classes related to Python's Method Resolution Order, which is that parent classes are searched from _left to right_. Check it out:

```python
class CuriouslySlowHero(WalkerMixin, RunnerMixin):
    """This hero is confused."""
    pass

```

The first `max_speed` method found is used -- and in this case, it's the one provided by `WalkerMixin`.

~~~
  In [4]: CuriouslySlowHero().max_speed()
  Out[4]: 1

~~~

This example can be fixed with a slighty different design that we'll check out later. However, the gotcha is evident. To say it once again: parent classes are searched left to right. For this reason, you want to stack up your mixins on the left, and your concrete base class (or classes) on the far right.

### Adding Instance Variables

Mixins in Python can add state to an object instance through any of the usual methods otherwise available to superclasses, such as:

- Adding an `__init__` method and hoping that child classes use `super` properly
- Manually adding attributes with `setattr`
- Adding class variables, which are also available on object instances

An example of adding an instance variable via a mixin follows:

```python
class RunnerMixin:
    def __init__(self, legs):
      # Instance variable
      self.legs = legs

    @property  # This is now a property because they look nicer!
    def max_speed(self):
        return MAX_SPEED * self.legs


```

Let's talk about that `legs` instance variable.

First of all, it's only going to be available if the class inheriting from `RunnerMixin` calls `super` in its `__init__` method!

Second, when using `super`, the child class needs to provide a `legs` argument. And if this is, say, parent class #3, the two classes before it also need to use `super` with a `legs` argument! Using `**kwargs` in `__init__` methods can make this easier to deal with, but keep it in mind.

### Adding Class Variables

Now let's add some class variables. These are variables that will become available on classes that mix in this class _and_ on instances of the class. Class variables are also available regardless of `super` use.

```python
class RunnerMixin:
    # Class variables
    MAX_SPEED = 4
    SPEEDS = range(MAX_SPEED)

    def __init__(self, legs):
      # Instance variable
      self.legs = legs

    @property
    def max_speed(self):
        return MAX_SPEED * self.legs


```

So, we added the class variables `MAX_SPEED`, an integer, and `SPEEDS`, a list of the speed values that runner pieces will support.

---
**Quick note on variables**: Python variables are effectively references, or labels pointing at values, to use a metaphor from _Fluent Python_.

---

A variable defined within the body of a class (a class variable) provides a reference to the same value, shared across both instances of the class and the class itelf (e.g., `RunnerMixin.MAX_SPEED`).

The behavior around changing class variables after they're defined depends on whether the values are immutable or mutable objects:

- If you were to use an update-in-place operation on an immutable value provided by a class variable, e.g. `SortaFastMonster().MAX_SPEED += 1`, the variable that you used will change to refer to a new value. The original value doesn't change. If you used the operation on a class instance, only that instance's variable will point to the new value.

- Mutable objects updated in place, for example `SortaFastMonster().SPEEDS += [25]` _will_ change in place. All class instances and the class itself will continue pointing to the same -- now changed -- value!

Sidenote: the behavior of mutable class variables is similar to the common Python gotcha that providing a mutable object as a default for a method parameter (e.g., `def set_speeds(speeds=[0, 1, 2])`) shares the same object instance with all callers[^3]!

### A Full Example of Python Mixins

This post would be incomplete without a full example of using Python mixins!

```python
class WalkerMixin:
    @property
    def max_speed(self):
        return 1


class RunnerMixin:
    @property
    def max_speed(self):
        return 4


class FlierMixin:
    @property
    def max_speed(self):
        return 10


class SortaFastHero(RunnerMixin):
    """This hero can run, which is better than walking."""
    pass


class CuriouslySlowHero(WalkerMixin, FlierMixin):
    """The order of this class's parents made her curiously slow!"""
    pass


class FastestHero(FlierMixin, RunnerMixin):
    """The fastest hero can fly, of course."""
    pass


class Board:
    """An imaginary game board that doesn't do anything."""

    def move(self, piece, actions_spent):
        """Move a piece on the board.

        ``piece`` should be movable
        ``actions_spent`` is the number of actions taken to move

        """
        # Fictitious piece-moving machinery here
        return actions_spent * piece.max_speed


def main():
    board = Board()
    rows = (
        ('Hero', 'Total spaces moved'),
        ('a sorta fast hero', board.move(SortaFastHero(), 2)),
        ('a curiously slow hero', board.move(CuriouslySlowHero(), 2)),
        ('the fastest hero', board.move(FastestHero(), 2))
    )
    print('\n')
    for description, movement in rows:
        print("\t{:<22} {:>25}".format(description, movement))


if __name__ == '__main__':
    main()

```

Read it and try to figure out what it does! The output is as follows:

~~~
  $ python3 powers.py

          Hero                          Total spaces moved
          a sorta fast hero                              8
          a curiously slow hero                          2
          the fastest hero                              20

~~~

### Bonus: Refactoring

How can we fix that curiously slow hero? Well, we could correct the order of the parent classes. But what if we could design a way to get the maximum speed of a piece without requiring mixin classes to be in a certain order?

One idea is that we could rely on a concrete base class to accumulate available actions provided by mixin classes and then pick the fastest. Let's try that refactor:

```python
import collections


Action = collections.namedtuple('Action', ['speed', 'name'])


class WalkerMixin:
    WALK_SPEED = 1

    def actions(self):
        return super().actions() + [
            Action(speed=self.WALK_SPEED, name='walk')
        ]


class RunnerMixin:
    RUN_SPEED = 4

    def actions(self):
        return super().actions() + [
            Action(speed=self.RUN_SPEED, name='run')
        ]


class FlierMixin:
    FLY_SPEED = 10

    def actions(self):
        return super().actions() + [
            Action(speed=self.FLY_SPEED, name='fly')
        ]


class BaseHero:
    def actions(self):
        return []

    @property
    def fastest_action(self):
        return sorted(self.actions(), key=lambda action: action.speed,
                      reverse=True)[0]

    @property
    def max_speed(self):
        return self.fastest_action.speed


class SortaFastHero(RunnerMixin, BaseHero):
    """This hero can run, which is better than walking."""
    pass


class NoLongerSlowHero(WalkerMixin, FlierMixin, BaseHero):
    """This hero is no longer confused about her powers."""
    pass


class FastestHero(FlierMixin, RunnerMixin, BaseHero):
    """The fastest hero can fly, of course."""
    pass


class Board:
    """An imaginary game board that doesn't do anything."""
    def move(self, piece, actions_spent):
        """Move a piece on the board.

        ``piece`` should be movable
        ``actions_spent`` is the number of consecutive actions taken to move

        Return the total spaces that ``piece`` moved on the board.
        """
        return actions_spent * piece.max_speed


def main():
    board = Board()
    rows = (
        ('Hero', 'Total spaces moved'),
        ('a sorta fast hero', board.move(SortaFastHero(), 2)),
        ('a no longer slow hero', board.move(CuriouslySlowHero(), 2)),
        ('the fastest hero', board.move(FastestHero(), 2))
    )
    print('\n')
    for description, movement in rows:
        print("\t{:<22} {:>25}".format(description, movement))


if __name__ == '__main__':
    main()

```

Well, that got more complicated, didn't it? To summarize the change, we went from mixins that provided a `max_speed` property to mixins that provided a list of `Action`s, each with a speed, and a base class that found the fastest action. 

I'm not sure if the second version is better or worse, and in any event the code is completely fake, but we can examine the output and see that we've at least fixed our curiously slow hero:

~~~
  $ python3 powers_refactored.py

          Hero                          Total spaces moved
          a sorta fast hero                              8
          a no longer slow hero                         20
          the fastest hero                              20

~~~


## Mixins in Ruby

After switching from Python to Ruby for work this year, I was surprised to find that mixins are incorporated more deeply into Ruby than they are in Python.

Instead of multiple inheritance like in Python, Ruby gives us the `include`, `extend`, and `prepend` keywords, and a `module` class. When combined, these tools are perfect for creating mixins!

### Adding Instance Methods

In Ruby, you use a module to contain mixin functionality. "Module" here refers not to a library (or "package" in Python), but to a language construct similar to a namespace[^4].

To add instance methods to a class via mixins, you create a module with a method inside it, and then `include` the module from within a class.

```ruby
module Runnable
  def max_speed
    4
  end
end

# This hero can run, which is better than nothing.
class SortaFastHero
  include Runnable
end

```

So, `SortaFastHero` is a class that includes `Runnable`. This doesn't look like inheritance, so how does it work? Well, that's where things get exciting!

When you `include` a module within a class definition, a "singleton" class is created, in effect a copy of the module, and inserted as the ancestor of the including class. So in the case of the example, a singleton class containing the methods from `Runnable` is now in the inheritance hierarchy for `SortaFastHero`, even though its superclass is reported as `Object`:

~~~
  irb(main):016:0> SortaFastHero.superclass
  => Object

  irb(main):017:0> SortaFastHero.ancestors
  => [SortaFastHero, Runnable, Object, Kernel, BasicObject]


~~~

Ah, `include` does rely on inheritance after all! You can think of `include` as manipulating the inheritance hierarchy of a class. Once a mixin module's methods are copied into a singleton class and placed into the inheritance hierarchy of a class, Ruby is able to find them at runtime on instances of that class using its normal method resolution algorithm.

---
**Quick note on `prepend`**: We won't discuss `prepend`, except to say that it works the same way as `include`, but where `include` inserts a singleton class for an included module as the direct parent of the including class, `prepend` inserts it _before_ the prepending class in the hierarchy. The result is that at runtime, Ruby will search the mixin for methods _first_, before the prepending class, which is pretty handy if you want to override behavior in a class without subclassing it!

---

### Adding Class Methods

While `include` makes methods from a module available as receivers on instances of a class, `extend` does so for the class itself. That is, methods in the module become class methods of the target class. (In fact, we can use `include` for both tasks, as we'll soon see.)

When `extend` copies methods, it does so by creating a new singleton class and inserting it into the inheritance hierarchy of the _metaclass_ of the target class.

---
**Quick note on metaclasses**: The _metaclass_ of a class is a singleton class created alongside the class to hold its class methods (as opposed to instance methods).

---

By creating a new singleton class and adding it to the hierarchy of the target class's metaclass, `extend` makes those methods available when Ruby searches through the class's ancestors to find class methods at runtime.

So it does basically the same thing as `include`, but with a different target -- the class's metaclass rather than the class itself. You can see this in `irb`:

~~~
  irb(main):020:0> class AnotherHero
  irb(main):021:1>   extend Runnable
  irb(main):022:1> end

  irb(main):027:0> AnotherHero.ancestors
  => [AnotherHero, Object, Kernel, BasicObject]

  irb(main):029:0> AnotherHero.superclass
  => Object

  irb(main):035:0> AnotherHero.singleton_class.ancestors
  => [#<Class:AnotherHero>, Runnable, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, Kernel, BasicObject]

  irb(main):039:0> AnotherHero.max_speed
  => 4


~~~

Once again, a singleton class is inserted, but this time it's linked to the metaclass (`singleton_class`) of `AnotherHero` rather than the class itself.

### Using `include` for class methods

Often `include` is used to mix in instance methods _and_ class methods. This is done by implementing a `self.included` method in the module, like so:


```ruby
module Runnable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def max_speed
    4
  end

  class ClassMethods
    def description
      "runnable"
    end
  end
end

class SortaFastHero
  include Runnable
end

```

The `included` method is a hook that Ruby calls when a module is included. With this double-duty approach to `include`, the hook is used to run an `extend` on the including class to link methods from `ClassMethods` to the including class's metaclass.


### Trap: The Order of Included Modules Matters!

The use of inheritance behind the scenes of `include` leads to an intriguing property: the order that you `include` modules matters. Singleton classes are created and inserted into the class hierarchy in the order that you call `include`, which means that they're searched for method definitions at runtime in reverse order: the last included module first, up to the first.

An example is in order:

```ruby
# This hero is confused about her powers.
class CuriouslySlowHero
  include Flyable
  include Walkable
end

```

In IRB:

~~~
  irb(main):019:0> CuriouslySlowHero.new.max_speed
  => 1


~~~

This is similar to the importance of superclass ordering with Python mixins. Later in this article, we'll refactor this Ruby code in a way similar to our final Python example.

### Adding Instance Variables

You can add instance variables from a module by using an `initialize` method, along with all the usual `attr_*` helpers.

```ruby
module Runnable
  attr_reader :legs

  def initialize(legs)
    @legs = legs
  end

  def max_speed
    MAX_SPEED * legs
  end
end

```

For this to work, however, the class including the module needs to call `super` from its initialize method! As with Python, arguments to mixin initializers must be passed successfully up through `super` calls. (My gut feeling is that if you are doing a lot of this, the design of your mixins may be problematic.)

### Adding Class Variables

Any class variables you set in a mixin will be available on the including class. Take this even simpler `Runnable` mixin that only has a class constant:

```ruby
module Runnable
  MAX_SPEED = 1
end

class RunningHero
  include Runnable
end

```

We can access `MAX_SPEED`:

~~~
irb(main):015:0> RunningHero::MAX_SPEED
=> 1


~~~

Note, however, that if you use `extend`, the class variable will only exist on the extending class's metaclass, which probably isn't what you want!

```ruby
class RunningHero
  extend Runnable
end

```

And the output:

~~~
  irb(main):019:0> RunningHero::MAX_SPEED
  NameError: uninitialized constant RunningHero::MAX_SPEED
          from (irb):19
          from /Users/andrew/.rbenv/versions/2.3.3/bin/irb:11:in `<main>`

  irb(main):018:0> RunningHero.singleton_class::MAX_SPEED
  => 1


~~~

### A Full Example of Ruby Mixins

Let's check out a full example of Ruby mixins, following the same design that we used for the Python example (that is, super basic).

```ruby
module Walkable
  def max_speed
    1 
  end
end

module Runnable
  def max_speed
    4
  end
end

module Flyable
  def max_speed
    10
  end
end

# This hero can run, which is better than nothing.
class SortaFastHero
  include Runnable
end

# This hero is confused about her powers.
class CuriouslySlowHero
  include Flyable
  include Walkable
end

# The fastest hero can fly, of course.
class FastestHero
  include Flyable
end

# An imaginary game board that doesn't do anything.
class Board
  # Move a piece on the board.
  #
  # ``piece`` should be movable
  # ``actions_spent`` is the number of consecutive actions taken to move
  #
  # Return the total spaces that ``piece`` moved on the board.
  def move(piece, actions_spent)
    # Fake piece-moving machinery here
    actions_spent * piece.max_speed
  end
end

board = Board.new

rows = [
  ['Hero', 'Total spaces moved'],
  ['a sorta fast hero', board.move(SortaFastHero.new, 2)],
  ['a curiously slow hero', board.move(CuriouslySlowHero.new, 2)],
  ['the fastest hero', board.move(FastestHero.new, 2)]
]

puts

rows.each do |description, movement|
  printf "\t%-22s %25s\n", description, movement
end

```

As with the Python version, see if you can figure out what it does.

If we run it, this is the output:

~~~
  $ ruby powers.rb

      Hero                          Total spaces moved
      a sorta fast hero                              8
      a curiously slow hero                          2
      the fastest hero                              20


~~~

As with the Python example, "a curiously slow hero" shows one potential pitfall of Ruby mixins, which is that the order of include statements matters.

### Bonus: Refactoring

As in the Python example, we can address the flaw in our Ruby code that leads to a curiously slow flying hero either by changing the order of our operations or by choosing a new design.

I've taken a crack at refactoring the Ruby code to use the same design as the refactored Python code -- a series of mixins that provide `Action` classes, each with a speed, and a concrete base class that picks the fastest one.

```ruby
Action = Struct.new('Action', :speed, :name)

module Walkable
  WALK_SPEED = 1

  def actions
    super + [
      Action.new(speed = WALK_SPEED, name = 'walk')
    ]
  end
end

module Runnable
  RUN_SPEED = 1

  def actions
    super + [
      Action.new(speed = RUN_SPEED, name = 'run')
    ]
  end
end

module Flyable
  FLY_SPEED = 10

  def actions
    super + [
      Action.new(speed = FLY_SPEED, name = 'fly')
    ]
  end
end

module Movable
  def actions
    []
  end

  def fastest_action
    actions.sort { |action| action.speed }.last
  end

  def max_speed
    fastest_action.speed
  end
end

class Hero
  include Movable
end

# This hero can run, which is better than nothing.
class SortaFastHero < Hero
  include Runnable
end

# This hero is no longer confused about her powers.
class NoLongerSlowHero < Hero
  include Flyable
  include Walkable
end

# The fastest hero can fly, of course.
class FastestHero < Hero
  include Flyable
end

# An imaginary game board that doesn't do anything.
class Board
  # Move a piece on the board.
  #
  # ``piece`` should be movable
  # ``actions_spent`` is the number of consecutive actions taken to move
  #
  # Return the total spaces that ``piece`` moved on the board.
  def move(piece, actions_spent)
    # Fake piece-moving machinery here
    actions_spent * piece.max_speed
  end
end

board = Board.new

rows = [
  ['Hero', 'Total spaces moved'],
  ['a sorta fast hero', board.move(SortaFastHero.new, 2)],
  ['a no longer slow hero', board.move(NoLongerSlowHero.new, 2)],
  ['the fastest hero', board.move(FastestHero.new, 2)]
]

puts

rows.each do |description, movement|
  printf "\t%-22s %25s\n", description, movement
end

```

And the output of the script:

~~~ 
$ ruby powers_refactored.rb

    Hero                          Total spaces moved
    a sorta fast hero                              2
    a no longer slow hero                         20
    the fastest hero                              20


~~~

Ah! Fixed! But is this code any beter? I'll have to get back to you on that.

## Summary

What have we learned together? Let's review the most salient points:

- You create mixins in Python using inheritance -- usually, multiple inheritance
- You create mixins in Ruby with modules and `include`, `extend`, and `prepend`, which all work by manipulating the class hierarchy behind the scenes
- In Python, the order in which mixin classes appear in a class's list of superclasses matters!
- In Ruby, the order of `include`, `extend`, and `prepend` statements matters!

I enjoyed writing up this article, especially because it forced me to learn how Ruby actually implements `include`, `extend`, and `prepend`, and I hope you got something out of reading it!

## Appendix A: Definition and Etymology of "Mixin"

Wikipedia's definition of "mixin" is as follows:

> [A] mixin is a class that contains methods for use by other classes without having to be the parent class of those other classes.

That's decent, though as we saw, "methods for use by other classes" is not the end of the story in Python and Ruby!

But where did this term, "mixin," come from? The best reference I could find to the origin of the term is this comment in an article from a 2001 issue of _Linux Journal_[^5]:

> The grapevine informs me that Symbolics' object-oriented Flavors system is most likely the earliest appearance of bona fide mix-ins. The designers were inspired by Steve's Ice Cream Parlor in Cambridge, Massachusetts where customers started with a basic flavor of ice cream (vanilla, chocolate, etc.) and added any combination of mix-ins (nuts, fudge, chocolate chips, etc.). In the Symbolics system, large, standalone classes were known as flavors while smaller helper classes designed for enhancing other classes were known as mix-ins.

"Flavors" was an object-oriented extension to Lisp[^6], proving once again that everything decent was already done long ago, in Lisp.

## Appendix B: Additional Reading

There are some great blog posts, lectures, and books that cover Python and Ruby internals if you want to read more about what goes on behind the scenes in both of these approaches to mixins.

For Python, you'll want to read anything on multiple inheritance. My favorite book on Python is <a target="_blank" href="https://www.amazon.com/gp/product/1491946008/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=1491946008&linkCode=as2&tag=andrewbrookin-20&linkId=eaf281ad80f2f800b1ec06541b85528f">Fluent Python: Clear, Concise, and Effective Programming</a>, which covers the topic well. 

Going deeper into Python internals, there's the lecture series, [CPython internals: A ten-hour codewalk through the Python interpreter source code](http://pgbovine.net/cpython-internals.htm). And this read-through of CPython code around attribute access touches on the code that makes class variables available to class instances, [How Does Attribute Access Work?](https://medium.com/stepping-through-the-cpython-interpreter/how-does-attribute-access-work-d19371898fee)

Ruby seems to have more published, high-quality books than Python. At least, that's my feeling -- maybe I don't know all the good Python books. [Ruby Under a Microscope: An Illustrated Guide to Ruby Internals](https://www.amazon.com/gp/product/1593275277/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=1593275277&linkCode=as2&tag=andrewbrookin-20&linkId=62f51f5cc314d8797c839d1bb6f62949) does a great job of explaining things like exactly which data structures are used to implement Ruby classes and metaclasses. And my favorite "light reading" book on Ruby so far is [Effective Ruby: 48 Specific Ways to Write Better Ruby](https://www.amazon.com/gp/product/0133846970/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0133846970&linkCode=as2&tag=andrewbrookin-20&linkId=ffe47d0f5aa28b8ac51667a1b2913ca9).

And those are absolutely affiliate links, so feel free to buy everything you've ever dreamed of and desired on Amazon after clicking them.

## Footnotes

[^1]: [The Hitchhiker's Guide to Python: Reading Great Code](https://books.google.com/books?id=4yXtDAAAQBAJ&pg=PT218&lpg=PT218&dq=python+naming+convention+for+mixins&source=bl&ots=Xv3JZk7aUL&sig=cd9l0orKQYwlJlOgZniTofLp2eI&hl=en&sa=X&ved=0ahUKEwjLzrfNjKzYAhUS3GMKHakaBbEQ6AEIbjAK#v=onepage&q&f=false)

[^2]: [The Python 2.3 Method Resolution Order](https://www.python.org/download/releases/2.3/mro/). Python 3 always uses "new-style" classes, so this approach, using the  C3 Method Resolution Order, is the same.

[^3]: [The Hitchhiker's Guide to Python: Common Gotchas](http://docs.python-guide.org/en/latest/writing/gotchas/#mutable-default-arguments)

[^4]: [Class: Module](https://ruby-doc.org/core-2.4.0/Module.html)

[^5]: [Using Mix-ins with Python](http://www.linuxjournal.com/node/4540/)

[^6]: [Flavors: A non-hierarchical approach to object-oriented programming](http://www.softwarepreservation.org/projects/LISP/MIT/nnnfla1-20040122.pdf)
