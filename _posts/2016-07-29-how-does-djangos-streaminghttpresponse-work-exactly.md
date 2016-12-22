---
id: 1373
title: 'How does Django&#8217;s StreamingHttpResponse work, exactly?'
date: 2016-07-29T11:19:45+00:00
author: Andrew
layout: post
guid: https://andrewbrookins.com/?p=1373
permalink: /django/how-does-djangos-streaminghttpresponse-work-exactly/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Django
---
This post tries to explain just what goes on when you use Django&#8217;s `StreamingHttpResponse`.

I will discuss what happens in your Django application, what happens at the Python Web Server Gateway Interface (WSGI) layer, and look at some examples.

This content is also available as [a README with an example Django project](https://github.com/abrookins/streaming_django).

## So, what even is a <code>StreamingHttpResponse</code>?

Most Django responses use `HttpResponse`. At a high level, this means that the body of the response is built in memory and sent to the HTTP client in a single piece.

Here&#8217;s a short example of using `HttpResponse`:

<div class="highlight highlight-source-python">
  <pre>    <span class="pl-k">def</span> <span class="pl-en">my_view</span>(<span class="pl-smi">request</span>):
        message <span class="pl-k">=</span> <span class="pl-s"><span class="pl-pds">'</span>Hello, there!<span class="pl-pds">'</span></span>
        response <span class="pl-k">=</span>  HttpResponse(message)
        response[<span class="pl-s"><span class="pl-pds">'</span>Content-Length<span class="pl-pds">'</span></span>] <span class="pl-k">=</span> <span class="pl-c1">len</span>(message)

        <span class="pl-k">return</span> response</pre>
</div>

A `StreamingHttpResponse`, on the other hand, is a response whose body is sent to the client in multiple pieces, or &#8220;chunks.&#8221;

Here&#8217;s a short example of using `StreamingHttpResponse`:

<div class="highlight highlight-source-python">
  <pre>    <span class="pl-k">def</span> <span class="pl-en">hello</span>():
        <span class="pl-k">yield</span> <span class="pl-s"><span class="pl-pds">'</span>Hello,<span class="pl-pds">'</span></span>
        <span class="pl-k">yield</span> <span class="pl-s"><span class="pl-pds">'</span>there!<span class="pl-pds">'</span></span>

    <span class="pl-k">def</span> <span class="pl-en">my_view</span>(<span class="pl-smi">request</span>):
        <span class="pl-c"># <span class="pl-k">NOTE</span>: No Content-Length header!</span>
        <span class="pl-k">return</span> StreamingHttpResponse(hello)</pre>
</div>

You can read more about how to use these two classes in [Django&#8217;s documentation](https://docs.djangoproject.com/en/1.9/ref/request-response/). The interesting part is what happens next &#8212; after you return the response.

## When would you use a <code>StreamingHttpResponse</code>?

But before we talk about what happens after you return the response, let us digress for a moment: why would you even use a `StreamingHttpResponse`?

One of the best use cases for streaming responses is to send large files, e.g. a large CSV file.

With an `HttpResponse`, you would typically load the entire file into memory (produced dynamically or not) and then send it to the client. For a large file, this costs memory on the server and &#8220;time to first byte&#8221; (TTFB) sent to the client.

With a `StreamingHttpResponse`, you can load parts of the file into memory, or produce parts of the file dynamically, and begin sending these parts to the client immediately. **Crucially,** there is no need to load the entire file into memory.

## A quick note about WSGI

Now we&#8217;re approaching the part of our journey that lies just beyond most Django developers&#8217; everyday experience of working with Django&#8217;s response classes.

Yes, we&#8217;re about to discuss the [Python Web Server Gateway Interface (WSGI) specification](https://www.python.org/dev/peps/pep-3333/).

So, a quick note if you aren&#8217;t familiar with WSGI. WSGI is a specification that proposes rules that web frameworks and web servers should follow in order that you, the framework user, can swap out one WSGI server (like uWSGI) for another (Gunicorn) and expect your Python web application to continue to function.

## Django and WSGI

And now, back to our journey into deeper knowledge!

So, what happens after your Django view returns a `StreamingHttpResponse`? In most Python web applications, the response is passed off to a WSGI server like uWSGI or Gunicorn (AKA, Green Unicorn).

As with `HttpResponse`, Django ensures that `StreamingHttpResponse` conforms to the WSGI spec, which states this:

> When called by the server, the application object must return an iterable yielding zero or more bytestrings. This can be accomplished in a variety of ways, such as by returning a list of bytestrings, or by the application being a generator function that yields bytestrings, or by the application being a class whose instances are iterable.

Here&#8217;s how `StreamingHttpResponse` satisfies these requirements ([full source](https://docs.djangoproject.com/en/1.9/_modules/django/http/response/#StreamingHttpResponse)):

<div class="highlight highlight-source-python">
  <pre>    <span class="pl-en">@</span><span class="pl-c1">property</span>
    <span class="pl-k">def</span> <span class="pl-en">streaming_content</span>(<span class="pl-smi"><span class="pl-smi">self</span></span>):
        <span class="pl-k">return</span> <span class="pl-c1">map</span>(<span class="pl-v">self</span>.make_bytes, <span class="pl-v">self</span>._iterator)
<span class="pl-c"># ...</span>

    <span class="pl-k">def</span> <span class="pl-c1">__iter__</span>(<span class="pl-smi"><span class="pl-smi">self</span></span>):
        <span class="pl-k">return</span> <span class="pl-v">self</span>.streaming_content</pre>
</div>

You give the class a generator and it coerces the values that it produces into bytestrings.

Compare that with the approach in `HttpResponse` ([full source](https://docs.djangoproject.com/en/1.9/_modules/django/http/response/#HttpResponse)):

<div class="highlight highlight-source-python">
  <pre>    <span class="pl-en">@content.setter</span>
    <span class="pl-k">def</span> <span class="pl-en">content</span>(<span class="pl-smi"><span class="pl-smi">self</span></span>, <span class="pl-smi">value</span>):
        <span class="pl-c"># ...</span>
        <span class="pl-v">self</span>._container <span class="pl-k">=</span> [value]

    <span class="pl-k">def</span> <span class="pl-c1">__iter__</span>(<span class="pl-smi"><span class="pl-smi">self</span></span>):
        <span class="pl-k">return</span> <span class="pl-c1">iter</span>(<span class="pl-v">self</span>._container)</pre>
</div>

Ah ha! An iterator with a single item. Very interesting. Now, let&#8217;s take a look at what a WSGI server does with these two different responses.

## The WSGI server

Gunicorn&#8217;s synchronous worker offers a good example of what happens after Django returns a response object. The code is [relatively short](https://github.com/benoitc/gunicorn/blob/39f62ac66beaf83ceccefbfabd5e3af7735d2aff/gunicorn/workers/sync.py#L176-L183) &#8212; here&#8217;s the important part (for our purposes):

<div class="highlight highlight-source-python">
  <pre>respiter <span class="pl-k">=</span> <span class="pl-v">self</span>.wsgi(environ, resp.start_response)
<span class="pl-k">try</span>:
    <span class="pl-k">if</span> <span class="pl-c1">isinstance</span>(respiter, environ[<span class="pl-s"><span class="pl-pds">'</span>wsgi.file_wrapper<span class="pl-pds">'</span></span>]):
        resp.write_file(respiter)
    <span class="pl-k">else</span>:
        <span class="pl-k">for</span> item <span class="pl-k">in</span> respiter:
            resp.write(item)
    resp.close()</pre>
</div>

Whether your response is streaming or not, Gunicorn iterates over it and writes each string the response yields. If that&#8217;s the case, then what makes your streaming response actually &#8220;stream&#8221;?

First, some conditions must be true:

  * The client must be speaking HTTP/1.1 or newer
  * The request method wasn&#8217;t a HEAD
  * The response does not include a Content-Length header
  * The response status wasn&#8217;t 204 or 304

If these conditions are true, then Gunicorn will add a `Transfer-Encoding:
chunked` header to the response, signaling to the client that the response will stream in chunks.

In fact, Gunicorn will respond with `Transfer-Encoding: chunked` even if you used an `HttpResponse`, if those conditions are true!

To really stream a response, that is, to send it to the client in pieces, the conditions must be true, **and** your response needs to be an iterable with multiple items.

### What does the client get?

If the streaming response worked, the client should get an HTTP 1.1 response with the `Transfer-Encoding: chunked` header, and instead of a single piece of content with a `Content-Length`, the client should see each bytestring that your generator/iterator yielded, sent with the length of that chunk.

Here is an example that uses the code in this repository:

    (streaming_django) ❯ curl -vv --raw "http://192.168.99.100/download_csv_streaming"
    *   Trying 192.168.99.100...
    * Connected to 192.168.99.100 (192.168.99.100) port 80 (#0)
    > GET /download_csv_streaming HTTP/1.1
    > Host: 192.168.99.100
    > User-Agent: curl/7.43.0
    > Accept: */*
    >
    < HTTP/1.1 200 OK
    < Server: nginx/1.11.1
    < Date: Fri, 29 Jul 2016 14:27:58 GMT
    < Content-Type: text/csv
    < Transfer-Encoding: chunked
    < Connection: keep-alive
    < X-Frame-Options: SAMEORIGIN
    < Content-Disposition: attachment; filename=big.csv
    <
    f
    One,Two,Three
    
    f
    Hello,world,1
    
    ...
    
    10
    Hello,world,99
    
    0
    
    * Connection #0 to host 192.168.99.100 left intact
    
 <br/>So there you have it. We journeyed from considering when to use `StreamingHttpResponse` over `HttpResponse`, to an example of using the class in your Django project, then into the dungeons of WSGI and WSGI servers, and finally to the client&#8217;s experience. And we managed to stream a response &#8212; go us!
