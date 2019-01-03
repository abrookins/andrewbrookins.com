---
title: 'Using Windows 10 and the Surface Book 2 for Web Development'
date: 2018-07-04
author: Andrew
layout: post
permalink: /technology/using-windows-10-and-the-surface-book-2-for-web-development/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology, Windows
image:
  feature: northwest-passagenew.jpg
---


I’ve been a web developer who uses a Mac for almost ten years, but lately I'm on a quest to find the [perfect software development platform](/tech/my-ideal-software-development-environment/). Ideally, one that lacks hardware lock-in and painful keyboards.

To summarize the quest to date, I fell in love with and then abandoned the [iPad with a remote Linux server](/tech/can-you-write-code-on-an-ipad/) and the [Chromebook Plus](/technology/can-you-code-on-a-chromebook-plus/) with a similar setup. Then I retreated to macOS for a while. Aside from desktop Linux, which I've used in the past and want to avoid, only Windows 10 was left to try.

So, I picked up a Surface Book 2 and put Windows 10 through a meat grinder of web development tasks for the past month. My mission was to discover if a PC could replace my Mac. And you know what? Windows 10 and the Surface Book 2 were pretty good. Good enough, perhaps.

This post is an experience report describing some of the problems I had with Windows 10 and the different Go, Python, and Ruby development environment setups I tried.

**Update 1/1/19**: After using Windows on and off for the past few months, I still prefer a Mac for real work. macOS can handle the complexity of my dev setup (Rails frontend apps, Kubernetes operators written in Go, Python glue code, multiple VPNs, etc.) without any distractions. Windows can't. I'll keep trying, though, because I'd love to choose my own hardware.
 


## What is this Meat Grinder of Which You Speak?

I tested all the code I work with regularly on the Windows Subsystem for Linux (WSL) and then again on virtual machines. This code included Rails apps and Go services running directly on WSL, and some containerized Python projects running in Docker for Windows and accessed through WSL. When WSL failed for some of my projects, I set up VMs using Hyper-V, VMWare Workstation, and VirtualBox. I set up all my VPNs (yeah, that’s plural) and tested access to them from WSL and the VMs. I tested both the i5 and i7 versions of the Surface Book 2, because I had to return the i5 after realizing I would need VMs for development and the i5 wasn’t cutting it.

The experiment went okay. The many things I love about the device and the aspects of Windows 10 that improve on areas of macOS balance out my crushed dream of using WSL, without a VM, and the i5 model. I don’t plan on going back to macOS, though my MacBook Pro, with its terrible keyboard, remains on a shelf in the closet. My wife forbade me to sell it because she’s betting I’ll be back within six months.

Despite the fact that I plan on sticking with Windows, I can’t really say “If you are a web developer currently using a Mac to work with open-source tools, go out and buy a Windows machine.” I ran into trouble along the way, which I will describe. So beware: if you choose this path, it probably won't be easy.

Still, I’m well into my second month using Windows and a Linux VM for 100% of my software development tasks, both for my day job and for hobby coding, and I’m ~happy~ adjusting to the setup. The Surface Book 2 is also better than an iPad Pro up for the things I want to do with a tablet, and I’ve never run out of battery in public.

## Hardware

There are plenty of blog posts that describe the Surface Book 2 hardware in great detail. My summary is that this is a truly innovative device that is pleasant to use.

Considering the object as a whole, with the tablet attached, it’s a little chunky because the top doesn’t close flat. The tank tread-looking “fulcrum hinge” gives it a slight military air. The device appears rugged, though I’ll only find out how rugged it is in a few years, I suspect.

Unlike a Mac, the edges are angular without being sharp. The surface is warm and tactile. I’ve never enjoyed touching MacBook Pros or iPads much, but I enjoy touching this device. It’s friendlier. That’s true both of the laptop configuration and the tablet by itself.

It also has a good keyboard. If you are using one of the last few generations of MacBook Pro keyboard, you will enjoy typing the correct letter that you attempted to type, the softness with which you can press the keys, and the gentle sound they make.

The i5 version only goes up to 2 cores and 8 GB of RAM, which just isn’t going to cut it for web development, since you will probably need the i7’s extra cores to power a VM. However, the i5 version has a lot of attractive qualities. It is fanless, a tidge lighter than the i7, and so many dollars cheaper. The i7 has more cores and is sold with more RAM, has fans that I’ve never heard turn on, and an NVIDIA GPU. Probably because of the GPU, the i7 also has more glitches around tablet mode, like “Oh, I can’t detach the screen because Photos, which is not open, is using the GPU somehow” (I ended up manually removing Photos from Windows) and “Why is this application scaled incorrectly now?”

But just to be clear: you’re probably going to need a VM, so forget about the i5\. You need the 4 cores (8 hyperthreaded, or whatever that’s called) in the i7.

The trackpad is a trackpad. It’s acceptable.

The Surface Pen works great. It never needs to charge because it uses a battery. It works even when it’s not connected via Bluetooth. It has an eraser! It’s soft and quiet to write with, unlike the Apple Pencil. It’s solidly attached via a magnet to the screen at all times, and just won’t fall off. The only bad thing I can say about it is that it has one flat portion, where it fits on the side of the screen, which sometimes bothers me as I’m holding it. I’d rather have that than keep it loose, I guess.

The screen is nice, but not as nice as the new MacBook Pro screen, or the iPad Pro screen. The reason is that it’s too reflective. Using it anywhere near a window, you are going to see some very vibrant blues, whites, and greens – reflected from the view outside.

![A Surface Book 2 displays reflections from my window](/images/surface-reflectionnew.jpg)

However, I use this laptop outdoors a lot, working in various parks around town, without problems. The _one_ time I did have to move to a different spot was when I tried to work directly under the noon-time sun, without any shade, and the sun reflecting on the metallic body of the laptop nearly blinded me. “It’s almost like computers were made to be used inside,” my wife said later.

So, that’s the hardware. Let’s talk about why you can’t use that cheaper i5: Windows Subsystem for Linux isn’t ready yet.

## The Windows Subsystem for Linux

WSL has come very far over the past couple of years. I ran it through its paces, throwing Go code and Python code at it, pointing `docker-compose` installed within WSL at Docker for Windows on Hyper-V, building containers, and the like. Everything was going fine.

Then I tried to set up my Rails apps. Rails is supported out of the box with the Puma server, but at work we use unicorn, which breaks on WSL due to [an unimplemented socket option](https://github.com/Microsoft/WSL/issues/1982), `TCP_INFO`. If that’s all Klingon to you, don’t worry about it. Just realize that you will probably get 90% of your code working in WSL and then discover that a critical 10% won’t work because the NTFS team or the Networking team hasn’t worked closely with the WSL team to fix that thing yet. And maybe they never will.

If that doesn’t scare you off, then here are a few other problems I ran into. First, I/O speed is slower than native or VM filesystem access. _It is known_. You’ll be able to tell the difference if you compare doing anything I/O intensive, which in my case seems to be installing packages and the like, with a VM. Still, you can soldier on. Then there’s VPNs. WSL will switch out the `resolve.conf` configuration in Linux to use the VPN’s DNS resolver, but if your VPN only resolves traffic for domains within the VPN, then you’ll have to toggle between being able to access the VPN and being able to access the internet from within WSL. There are workarounds to this issue if you use a VM running on VirtualBox, but none that I could find for WSL.

Still, WSL has its uses. I run a `tmux` session in it now that copies and pastes to the Windows clipboard. Within that session, I `mosh` into a VM, which lets me use `tmux` to copy and paste text output from the VM.

Meanwhile, developing in a VM has some great perks. Want to make crazy changes to Linux? Take a snapshot first. Want a second VM just like your first one to isolate new work? Clone it. And of course, a VM is easy to move around between computers, should the need arise.

## Virtual Machines: Hyper-V, VMWare Workstation, or VirtualBox?

It’s been a while since I’ve had to develop in a VM because all the tools I use run natively on macOS. That means it’s also been a while since I’ve had to deal with annoying details like accessing VPN connections on a host from within a guest, or figuring out how to use such simple features as copy and paste.

I also didn’t realize just how different the three major virtualization platforms available on Windows were. Let’s talk about them!

Docker for Windows uses Hyper-V, which comes with Windows 10 Pro (but not Home). The admin UI for Hyper-V is feels a bit behind the other products, but it supports dynamic memory, which allows a VM to use less RAM if it’s currently consuming less – or something like that. (On VirtualBox, by contrast, my understanding is that if you assign 2GB of RAM to the guest, the guest takes 2GB of RAM from the host, regardless of the current workload. Please write me letters about this if I’m wrong.)

When I tried running Ubuntu 18.04 on Hyper-V, even in the simplest, text-only mode with Ubuntu Server, my connection with the VM, or perhaps the VM itself, would hang every few seconds. After researching the issue a while and even setting up new Windows tools that allow Ubuntu to act as an “Enhanced VM” on Hyper-V, the VM still stalled, so I gave up and switched to VMWare Workstation.

VMWare Workstation is the best choice if you want to run Desktop Linux and don’t have any requirements to use a VPN running on the host. Using Ubuntu 18.04 and the Gnome desktop, VMWare Workstation produced a smoother experience than any of the other virtualization systems. I could see using Desktop Linux within VMWare Workstation full-time. However, after many experiments with various work-arounds and multiple virtual networking cards, I could not get VMWare to proxy DNS requests from the guest to Windows such that the connected VPN’s DNS resolver would resolve them.

(Why can’t I just setup VPN access on the guest _and_ the host? Well, let’s just not go there. Maybe you can do that easily and it’ll work for you.)

I already knew from past experiments that VirtualBox could provide a guest access to the host’s VPN connection, so I packed up my VM as an OVF, loaded it in VirtualBox, and did the perfunctory blood sacrifice:

*   Added a NAT network adapter and a host-only network adapter
*   Wrote up some static routing magic with the new `netplan` system in Ubuntu that I’ve already forgotten – write me letters if you need this
*   Ran `VBoxManage.exe modifyvm "VM name" --natdnshostresolver1` from the Windows command line or PowerShell
*   Restarted VirtualBox

Getting access to a host’s VPN connection within a guest is really its own mini-quest, so I’ll leave it at that. But as far as me bushwhacking a path to productive web development on Windows goes, I recommend VirtualBox if you need to use the host’s VPN, and VMWare if you want to use Desktop Linux.

## A Quick Note on X Servers for Windows (X410, VcXsrv, etc.)

Tons of people on the internet claim to use a Windows-10-native X server to run Linux applications from the Windows 10 desktop. This seems like a good setup because it eliminates a lot of the friction of running two desktop GUIs (Windows 10 and Linux) to use a VM. However, none of these X servers worked properly in my testing.

The test they had to pass was running Intellij Ultimate and Firefox. None of them could do either of those well. Performance was unusable. Web pages in Firefox rendered so slowly, you could watch new page slowly draw onto the screen. Or else the X server couldn't deal with Intellij's dialogs and popups.

Of course, even if this worked, you would still be left with the problem that most Linux applications can't handle switching between HiDPI screens like the Surface Book 2's built-in display and lower DPI screens like an external monitor. Gnome Terminal and Tilix need to be restarted with manual scaling flags when switching, Firefox needs you to "void your warranty" to get it to scale properly on HiDPI, and even Intellij requires changing settings to stay readable when switching screens.

Bah, I say!

## Essential macOS Software that is Missing from Windows

Let’s talk about the essential macOS software that is now dead to me.

Key remapping is the best example. There’s a great tool everyone uses on macOS called Karabiner; on Windows, there are tons of options and none are amazing (I used SharpKeys), mostly because you have to log out and log back in, or even restart, to switch layouts with all of them.

There is no Alfred, but Cortana search via the Windows key does most of what I need.

GestureSign can make custom touchscreen gestures, similar to BetterTouchTool (I guess?).

As for OS automation, your best choice is going to be AutoHotkey, but you will be traveling in a new realm and you won’t speak the language, so expect that.

As with all software platform changes, there are pieces from my former OS that are missing in the new one, like the built-in Preview app from macOS. On Windows, there isn’t an easy way to open an image and change its JPEG compression level, which is something I used Preview for. I downloaded an open-source tool called Caesium, which worked well enough.

This is an area where you have to want to get away from macOS enough to sacrifice some of your comforts, I’m afraid.

## Using Software Designed for a Mouse with Your Fingers

There’s tons of software available for Windows. Not all of that software is great, and only some of it is really designed to be used on a tablet with human fingers, as opposed to with a mouse or trackpad.

This software problem bubbles up in curious ways. To give an example, I needed a PDF program to replace PDF Expert on iOS. My PDF needs are focused around marking up content, navigating large documents with big tables of contents and indexes, and the like – all via touch. There were a few PDF apps in the Windows Store, and others scattered around the internet, but only Xodo came close to PDF Expert, and even then, its search feature wasn’t as good. Worse, I couldn’t find a single PDF program that handled search as well as PDF Expert, in the way I needed; that is, with a scrollable list of results, rather than lazily jumping between search hits. I’m still hopeful I’ll find one, but there’s only so much time in the day.

There are also predictable issues in using unwitting applications in “tablet mode,” which I am using to describe both the formal Windows 10 mode and my use of the Surface Book 2’s display without its keyboard. For example, using Firefox in tablet mode can be irritating. Exiting full-screen is a pain (right now I can’t figure out how to do it actually), and the touch targets are too small. Firefox is clearly not designed to be used in tablet mode. Edge is, but it lacks some of my plugins.

But at least Firefox knows what sliding my finger up and down the glass should do: it should scroll the page, right? Some programs, like mintty (along with other terminal emulators) and ghostwriter (a Markdown text editor), to pick on two at random, just highlight visible text when you touch the screen. On the other hand, Visual Studio Code interprets touch, the Office suite is designed for touch, and many apps installable from the Windows Store are as well, like Xodo.

So, it’s a mixed bag, though trending positive. For me, keeping the same set of files, the same browser state, and the same VPN connections across my tablet and laptop uses of a computer is worth the occasional hiccup.

## Font Rendering

![An image of the high-resolution display rendering text in the Consolas font](/images/windows-font-rendering.png)

Font rendering on Windows is different than on macOS. Fonts are sharper and their lines are slimmer, but there seems to be more to it than that, especially on lower-resolution displays. I believe this magic is called “ClearType,” and you can configure it to some extent. After letting my eyes adjust to the difference for a few days, it doesn’t bother me anymore, though I still prefer macOS’s font rendering. On Windows, Consolas is the only terminal font I’ve found that consistently renders well in the “mintty” application on both a lower-resolution monitor and the high-resolution Surface Book 2 display.

As for browsers, Firefox and Edge both render fonts a little heavier than Chrome, which makes text on web pages more readable to my eye. Chrome’s font rendering is visibly thinner, which when combined with the already thinner base rendering of text on Windows makes Chrome unappealing to use. People who are psychologically normal and were raised well probably won’t notice the difference.

## Battery Life

Every MacBook Pro I’ve ever used has lasted just a few hours on battery for the work I do, which is writing code, running tests, writing code reviews, writing proposals, and doing tons of research in a web browser. You can stretch that out by using Safari, which uses less energy than Firefox, Chrome, and other browsers, as well as a lightweight text editor like Vim.

The Surface Book 2, running a VM, a text editor, OneNote, and Firefox lasts all day. The only time I find myself plugging into power is when I dock the computer for the night, or at random times when I have 50% battery left but am still used to that being a problem. I work from coffee shops almost every day, and I’ve never needed to bring the power cord with me (and I don’t want to – the cord for the i7 model is a beast).

The screen by itself is trickier. I always use it for short periods of time – twenty minutes for a code review with the pen here, half an hour to study some technical topic there. My longest regular stretch of tablet-only use is the three hours during which I use it to run my Dungeons and Dragons game (I see no shame in mentioning this). The battery has between 30 and 50% of a charge left at the end of the game. Of course, I am interacting with people for most of that time, and the tablet only exists for checking rules and keeping notes. As a final point on this topic, on weekends I sometimes leave the computer around in tablet mode to jot down ideas, or read the news, in which case eventually I have to plug it in.

## Reliability

_Update 7/20/18_: Uhm, about this. I’ve concluded that Windows 10 is flakier than macOS. I finally did hit a Blue Screen of Death, and they’re still blue. Multiple times I turned the computer on in the morning to find that it had restarted overnight, or else all my Bluetooth devices and the laptop keyboard refused to respond until I performed some “whispering.” Coming from macOS, it seems like you give up a degree of reliability, which is a bummer. Still, I’m continuing the experiment.

Anyone who ever used Windows in the past 20 years has probably seen a “blue screen of death” (BSOD). These were something like unrecoverable exceptions that forced you to restart the computer. I haven’t had any of these yet, and I probably would not have persisted with Windows if they were an issue with this machine.

Using the Surface Dock, I’ve had no problems with my battery draining when the Dock’s power cable is connected, though I use a single external monitor and don’t play any games.

After numerous sleeps and restores from sleep, I don’t think the machine has failed to turn on correctly, or turned on with a lower battery charge than I expected, ever.

Now for the bad news. Windows Explorer, which seems to be the UI shell for Windows, including the start menu and task bar, has occasional glitches. In the store, the first time I checked out the Surface, Explorer crashed and required a store employee to restart the computer so that I could even use it. That kind of event hasn’t happened to me, though sometimes the task bar or start menu stops responding, and I have to use Task Manager to restart the Windows Explorer task (God help you if you “end” it by accident). You begin to distinguish the types of reliability problems in Windows by what type of restart fixes it (task or computer). Classic Windows.

All of that and I’m using the latest, public, stable release of Windows 10\. So, clearly, if a team at Microsoft needs to be given some raises, back rubs, and extra vacation, it’s the Windows Explorer team.

These problems are slightly annoying and taint what might have been unbridled joy at escaping macOS to Windows, but they aren’t frequent enough to turn me away… yet. And unlike with macOS, you can always check out the [Windows Insider Blog](https://blogs.windows.com/windowsexperience/tag/windows-insider-program/) to see the massive amount of bug fixes and feature work all the teams are doing constantly. That page alone is probably my favorite part of using Windows.

## Welcome to Total Corporate Control

One aspect of Windows that has left a sour taste in my mouth (as opposed to the coppery taste of Windows Explorer) is the amount of control the operating system gives to IT administrators.

I fully intended to use a beast like the Surface Book 2 to do my work every day, not just sit on my coffee table, and because I like to dot all my “i”s and cross my “t”s, of course I followed my employer’s rules about using a personal device at work. On a Mac, this process involves installing a few extra programs. No big deal. With Windows, the level of control that the OS gives to administrators, which they naturally take, is surprising. For example, OneDrive integration with the OS seems to be disabled, I can’t subscribe to Insider Builds, and turning off Windows Defender will give my manager an electric shock in his metatarsals. I also can’t have a local user account, so everything I do on the computer has to exist within my employer-managed account.

I expected some of these shenanigans, but not all of them. Perhaps the anomaly is that this debasement _isn’t_ required on macOS. While working as a defense contractor for the government a few years ago, there was a similar disparity between the control that a macOS user had over a work-enabled machine and the same for a Windows user. Such is life with a corporate-controlled Windows machine, I guess.

## In Summary

Sour tastes aside, what appeals to me most about PCs over Macs today is the plurality of hardware makers. There are things about Surface devices that will make them unappealing to some; in particular, the fact that many of the pieces inside are glued together, with no way to upgrade or repair them. Take the hinge on the Surface Book 2, for example. A Microsoft Store employee explained to me that it could not be repaired – the unit would have to be replaced if the hinge or any of the docking pieces broke. That’s such a waste of environmental resources that it should probably be illegal. Somehow, this did not deter me from buying the device, but I hope to have better moral integrity next time.

I’m prioritizing experiments with touch and pen input directly to my laptop over other interests, and even my moral feelings. However, given the variety of PCs made every year, you could prioritize other things and still find a great development computer. You can easily and inexpensively build your own highly-upgradable desktop machine. On the laptop side, there are Dell and HP units with upgradable parts: memory, storage, and even batteries. Some brands, like ThinkPads, the Dell Developer Edition line, and Purism are highly compatible with Linux. Building your own desktop Mac? Buying a Mac laptop with upgradable memory, storage, and battery? Neither is possible in 2018, and I’m guessing it won’t ever be.

When Apple was creating amazing Macs, like the 2010 MacBook Pro, it was easier to make the argument that sacrificing the freedom PCs provided was worth it to get the quality a Mac delivered. That was the whole point of buying a Mac: Apple’s locked-down hardware created the best computing experience at a higher cost, and it also happened to run a UNIX variant operating system that let developers use open-source tools directly on the hardware. No more VMs, remote servers (at least for writing code), or flaky Linux-on-laptops-designed-for-Windows.

Of course, nothing lasts forever. With Microsoft actively building features for open-source developers in Windows, and manufacturers like Dell, Purism, and System76 building Linux-first systems, PCs seem like the better platform for developers like me in 2018\. Windows isn’t perfect, but I’m keeping my Surface Book 2, with its Linux VM and working keyboard. Farewell, macOS!
