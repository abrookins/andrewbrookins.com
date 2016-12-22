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
	  
`<br />
	% ls -s | grep -e '^ 0' | sed 's/^...//' | xargs -n1 rm -v<br />
` 

Or these two, suggested by Jameson Williams on the Portland Linux/Unix Group ([http://www.pdxlinux.org/](http://www.pdxlinux.org/ "http://www.pdxlinux.org/")):

1.
	  
`<br />
	find . -empty -maxdepth 1 -delete<br />
` 
	  
2.
	  
`<br />
	find * -prune -empty -exec rm {}\;</p>
<p>`