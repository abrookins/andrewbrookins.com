---
id: 298
title: No NIC on a Windows 7 VMWare image
date: 2010-02-08T10:19:32+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=298
permalink: /tech/no-nic-on-a-windows-7-vmware-image/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
exclude_from_homepage: true
---
Today I ran into trouble configuring a Windows 7 guest on a Linux host: Windows 7 couldn&#8217;t find an appropriate driver for the virtual NIC.

The solution was in [this forum post](http://communities.vmware.com/thread/188094).

Basically, I had to manually edit the VMWare image&#8217;s .vmx file (while the virtual computer was turned off) and add the following line:

<pre>ethernet0.virtualDev = "e1000"
</pre>

After restarting, the Windows 7 host detected the NIC and all was fine in the world.
