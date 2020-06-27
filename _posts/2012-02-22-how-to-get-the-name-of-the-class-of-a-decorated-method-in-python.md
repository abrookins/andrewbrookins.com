---
id: 808
title: 'Python: How to tell what class a decorated method is in at runtime'
date: 2012-02-22T13:01:23+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=808
permalink: /tech/how-to-get-the-name-of-the-class-of-a-decorated-method-in-python/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
  - Python
---
When profiling a Python app, it&#8217;s helpful to have a decorator that wraps functions and reports details about their performance. Assuming you are doing this to report some metric about the function, you&#8217;ll want the decorator to work with both bound and unbound functions (IE, regular functions and methods of a class), and if the decorator wraps a method, you&#8217;ll probably want to know the name of the class the method belongs to.

There is only one way (_update_: two ways) I&#8217;ve found to do this. They both involve the `inspect` module. (There are obvious ways to do it that don&#8217;t work with decorators.)

You can&#8217;t assume that the first argument in a function always refers to its class because that would break in the case that the function was not a method. However, the strong convention in Python is to name the first argument of methods &#8216;self&#8217;. Relying on this convention, we can easily tell if a function includes such an argument with the `inspect` module.

The `inspect` module&#8217;s `getcallargs` function will map the parameter names from a function&#8217;s signature to its arguments. Given a function `fn` that your decorator wraps, you can call `inspect.getcallargs(fn, *args)` at runtime and discover that the first positional argument is the &#8216;self&#8217; parameter defined in the method&#8217;s signature!

Now, the use of &#8216;self&#8217; is such a strong Pythonic convention that it&#8217;s good enough in most cases to use the presence of such a parameter in a function to know that it&#8217;s a bound function (again, a class method), and you can then inspect the &#8216;self&#8217; argument for its class using `__class__.__name__`.

Here is an example decorator that will print out the class name of a decorated bound function:



_Update_: In Python 2.6, which does not include `inspect.getcallargs`, you can use `inspect.getargspec` to similar effect: