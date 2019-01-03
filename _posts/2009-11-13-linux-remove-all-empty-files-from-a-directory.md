---
id: 286
title: 'Linux: Remove all empty files from a directory'
date: 2009-11-13T10:14:01+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=286
permalink: /tech/linux-remove-all-empty-files-from-a-directory/
categories:
  - Technology
---

One-liner to remove all empty files from a directory:
 
`ls -s | grep -e '^ 0' | sed 's/^...//' | xargs -n1 rm -v`

Or these two, suggested by Jameson Williams on the Portland Linux/Unix Group ([http://www.pdxlinux.org/](http://www.pdxlinux.org/ "http://www.pdxlinux.org/")):

1. `find . -empty -maxdepth 1 -delete`

2. `find * -prune -empty -exec rm {}\;`
