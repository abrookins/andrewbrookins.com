---
id: 1165
title: Porting a Geographic Nearest-Neighbor Python Web Service to Go
date: 2014-01-31T07:42:37+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=1165
permalink: /tech/porting-a-geographic-nearest-neighbor-python-web-service-to-go/
categories:
  - Go
  - Python
  - Technology
---
I wrote a blog post recently at work that described my experience porting a geographic nearest-neighbor web service from Python to Go. You can read it on the [Safari Flow blog](http://blog.safariflow.com/2013/11/17/porting-a-python-web-service-to-go/).

The post covers setting up a dev environment for Go, finding replacement third-party libraries, writing tests, performance profiling and deployment.

If you'd rather read the source, the Go project is [on GitHub](https://github.com/abrookins/radar) and the original Python source is [also on GitHub](https://github.com/abrookins/siren).