---
title: 'Can You Write Code on an iPad?'
date: 2017-06-03T11:19:45+00:00
author: Andrew
layout: post
permalink: /tech/can-you-write-code-on-an-ipad/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology
---
This is a story about how I experimented with using an iPad Air 2 to write code, what worked and what didn't, and where I ended up.

## Why?

Why did I head down this ludicrous path?

That's a long story. You can read it at [My Ideal Software Development Environment](/tech/my-ideal-software-development-environment/).

## The Experiment: an iPad Air 2

<figure>
	<img src="/images/betteripad.jpg">
	<figcaption>My iPad Air 2 and Logitech keyboard</figcaption>
</figure>

What I wanted was an ultralight, thin-client computing environment. The two-year-old iPad Air 2 that I used occasionally was about the right size and weight, though the idea that I could use iOS for work seemed laughable. However, I figured that the iPad could stand in for the device I would one day buy. And of course, most of the things I did were already cloud-hosted, with native and web applications that ran on phones, tablets, and laptops.

Despite iOS's limitations, it is very much oriented toward thin-client uses:

- iOS has no user access to the filesystem; if you want to work with files, they have to be remotely hosted or contained in an app, and most apps automatically sync any local files to a remote server
- iOS is the ultimate low-power OS: the app ecosystem runs pretty well on an iPad with 1 GB of RAM, compared with the 16 GBs on my laptop
- iOS automatically backs your device up to the internet via iCloud
- iOS can scale from a handheld device (a phone) up to a small-form workstation (the iPad Pro, around 12 - 13 inches)
- I could break the iPad over my knee, buy another one, and get back to work -- assuming I could work on it to begin with -- in 15 minutes

So I began the experiment.

## The Development Environment

The most important part of my ideal development envornment was that code and dependent programs would exist off of my device. Local caching would keep me going if I went offline temporarily. The environment should provide roughly the same level of intelligence that I expect from PC and Mac IDEs.

That was already a tall order, and I had other requirements that I hoped to achieve eventually. Accepting that it wouldn't be perfect, I decided that I could make compromises if they got me close to my ideal.

There are several types of programs I write, some more frequently than others, that my development environment needed to satisfy:

- Backend programs, typically web applications and APIs
- JavaScript components and single-page applications
- Native applications (previously, macOS apps)
- Mobile applications (iOS, Android apps)
- Text editor plugins

None of these types of programs can be written directly on the iPad, using iOS programs, for a few reasons:

- The OS doesn't allow you to run web servers, compile code, run code on a connected mobile device, or anything else that a programmer needs; so the code itself needs to be somewhere else (I'm sort of okay with this)
- There are no good native editors that work well with remote code (I'm not okay with this)
- Apple refuses to allow the user to modify running programs in any meaningful way, through the injection of plugin code (I'm not okay with this)

Accepting these constraints for the purpose of the experiment, I dug into the concept of hosting my code and programs on a cloud server, with a fast, native text editor running on iOS. For the rare times I developed iOS, macOS, and Android apps, I would have to figure out some way to connect the iPad to a remote graphical desktop.

However, I quickly found that no professional-grade editor existed for iOS. Apps like Coda, Buffer, Codeanywhere, and the iOS Vim port all failed to work nearly as well as well as desktop editors like Vim, Emacs, and JetBrains IDEs.

As I tried and failed to get a good editor setup in iOS, I decided there was only one way to achieve a real development environment on the iPad: return to Vim.

### Returning to Vim

If I couldn't run a good editor natively on the iPad, with my code on a remote server, then I'd have to run the editor itself on a remote server. That left either a remote desktop/VNC connection to a server running a graphical editor, or using a shell session over SSH.

Even on a fast LAN connection, in my experiments VNC was choppy and weird. I couldn't imagine it working on coffee shop internet. A terminal session, on the other hand, only had to send minimal data: text.

Two powerful text editors exist, designed for exactly the constraints imposed by a terminal session: Emacs and Vim. I was already familiar with Vim and comfortable with its modal editing paradigm, so I decided to shift all my development back to it after a several year hiatus.

Still using my laptop at this point, I made a few updates to my old Vim configuration. I updated to the latest version of Neovim and configured `vim-test` to run tests in a terminal split. This is pretty great, as it gives you access to debuggers like `pry` running alongside your code in a Vim buffer. Then I freshened up my tmux configuration and began writing code in Neovim within a tmux window, instead of my IDE.

In a week or two, I had fully reacclimatized to Vim and was pretty happy, so I took the next step: finding a place to run Vim that wasn't on my computer.

### Google Cloud Platform

I could use a Virtual Private Server for my development environment, but doing so involved a fixed price for a fixed amount of disk, RAM, CPU, and network traffic. On the other hand, a cloud provider would make some very cool things possible.

First off, I could install my tools on a Linux disk image and pay for the *compute nodes* (to use Google Cloud Platform terminology) that run my tools separately from the disk. For a couple of days I might run with one CPU and 4 GB of RAM, and then if I needed to temporarily, I could scale the compute node up -- perhaps to run a graphical desktop and work on an Android app. Meanwhile, my network traffic would always be low compared to something like a busy website, so no need to pay for traffic I won't use!

Second, I could snapshot my entire development environment automatically and keep it backed up. I could keep a base image and clone that into new project-specific environments if needed.

Best of all, when I'm not using the machine, I could power down the compute node portion and stop paying for it!

All of this looked possible with Google Cloud Platform, and when I signed up, the free trial included enough credits to run a medium-powered machine 24/7 for an entire year.

It took some time to set up my disk, a compute node, get some projects set up, and script the process. In the meantime, I opened up the SSH port on my router and macOS firewall on my Macbook Pro, so I could try out an SSH-based working environment immediately, by SSHing from my iPad to the Macbook Pro.

### Setting up the iPad

Once I had a development environment I could SSH into, I was ready to get my iPad set up.

This was not quite as magical an experience as using Google Cloud Platform. However, keyboard control of iOS and many apps had improved since the last time I tried using a Bluetooth keyboard with an iPad.

I dug out my old Microsoft Universal Keyboard, which was decent but flawed due to the position of some keys and its small size. Still, it worked and was pretty light. After trial and effort I wound up with the following apps:

- Blink, a Mosh and SSH terminal that can remap the Capslock key to Escape and Option to Control -- changes that, unlike macOS, iOS can't do but that I need for using Vim

- Mosh on the server and Mosh connections with Blink; Mosh is an SSH utility that makes sessions work very well over unstable network connections, like those found in the coffee shops I enjoy

- The built-in Mail and Calendar apps because they had the best keyboard support (surprisingly, all of Google's apps had poor keyboard support)

- A crazy browser called iCab, which lets you control almost every feature with configurable keyboard shortcuts -- all it was missing was a Vimium-style feature to open links with a keyboard!

- Dropbox as my filesystem because it was so well-integrated in other iOS apps, and because it supported headless Linux installs, giving me full access to my iOS files via a Linux terminal


## Things I Loved

<figure>
	<img src="/images/betterspringwater.jpg">
	<figcaption>Taking long walks with the iPad was a breeze</figcaption>
</figure>

- I loved that my graphical environment stayed in sync across both my phone and the iPad, which felt really cool. iOS, though weird in so many ways, came to feel futuristic and made my Mac desktop feel stale whenever I had to use it.

- I loved that it was *fun*! I can't really explain why it was fun. It could have been purely the extra difficulty that made it more fun.

- I loved setting up the Workflow app to remote-control my development environment from my phone or iPad via SSH commands tied to buttons in the app. A new release of Workflow broke SSH commands the day after I got mine working, but the feature was cool while it lasted.

- I enjoyed code reviews a lot more! When I did code reviews, I would detach the keyboard and use the iPad as a tablet. I read pull requests from a comfortable chair, holding the iPad with one hand and taking notes with the other, and then I would snap the iPad back into the keyboard to write up my comments.

- I loved taking a three-mile hike around Oak's Bottom Wildlife Preserve with the iPad on my shoulder and barely feeling it, then working for a couple of hours in a beautiful park, tethered to my phone connection.

- Battery life was good. Not *great*, but way better than my Mac.

## Limitation of iOS

Ultimately, using iOS to write code became an endurance test: just how many limitations could I endure?

There were so many they sometimes took my breath away, but here are the deal-breakers:

- There is no way to access Developer Mode on any iOS web browser. iCab has Firebug Lite built in, which is close enough to scrape by, but I mean, this makes web development pretty difficult.

- iOS 10 exhibited frequent Bluetooth keyboard glitches with three different keyboards. The Command-tab shortcut would often deliver me to the wrong app, as if someone had stored an index number into an array that was being mutated and never updated the index. Meanwhile, all three keyboards would occasionally stop working and have to be reset. I found many of these issues already reported by customers months and years ago, and yet they were still around. I can't imagine how Apple can sell "Pro" iPads when the OS has so many flaws in external keyboard support!

- You can connect a USB keyboard to an iPad via a Lightning-to-USB adapter, but there is no good way to connect an iPad to an external monitor. So this is not a device that can scale up to a desktop workstation. There are ways to output your iPad display to a monitor screen, at a bad resolution and with black bars along the sides, but A) this is different from real external monitor support and B) every variation of this experience that I tried was unacceptable.

- Touching a screen is enjoyable when I'm doing tablet tasks like reading, but if the iPad is connected to a keyboard, I do *not* want to have to touch the screen for every task. Being required to reach up and touch a screen repeatedly for several hours sucks the fun out of iOS. Touch is a pleasing interface while the iPad is in tablet mode, but when connected to a keyboard, touch can't replace a mouse or trackpad.

- There are no truly reliable, full-featured SSH clients, though there are many expensive ones. Blink, the best I could find, constantly broke in various ways and required me to close out my session and establish a new one to fix display problems and frozen keyboard input. For something that itself is a compromise to replace the full-featured native text editors that don't exist on iOS, unreliable SSH apps are a deal-breaker.

- If you want to use custom fonts in your terminal (and thus Vim, in my case), your SSH app has to have this feature built in -- and many don't.

- iOS doesn't allow you to remap keyboard keys like Caps Lock and Control globally, so individual apps have to build that feature in, and almost none do.

- You can't override default applications like the Safari browser.

- It is pretty well established that apps can't let the user modify how they operate, i.e. by exposing a x plugin API.

- Apple maintains total control on what apps you can install on the device; they could revoke an app you rely on at any time, for any reason.

- So many more...

## The Most Surprising Part

To me, the most surprising part of the experiment was that using Vim on a remote server was acceptable -- even great. I could start a test run that was configured to push a notification to my phone when it was finished, walk to the coffee shop, and by the time I ordered my drink, get pinged that the tests passed or failed. Cool!

If I were to go back to using a Mac primarily, which I haven't yet, I would still use Vim on a remote server. I set up a decent `ctags` workflow that jumped to symbols with less accuracy than an Intellij editor, but was still better than nothing. Linters gave me pretty good real-time feedback about my code in the languages I used.

Vim is great at editing text, and using it instead of a Vim emulator in an IDE feels like coming home. I can appreciate the Unix philosophy of composing an environment from individual, specialized tools, even if the downside is that nothing feels truly cohesive.

## Can You Write Code on a ____?

Ultimately, after a few weeks, I stopped using an iPad as my primary device. The limitations were starting to get to me, but what forced me to stop was that my hands ached. Those tiny Blutooth keyboards hurt to type on after a while!

However, I consider the experiment a success: I found out that I was really happy with a light, thin client device that could act like both a latpop and a tablet.

So I looked around for other devices that I could write code on that were similar. There were only two or three on the market:

* Microsoft Surface Pro / Surface Book
* Samsung Chromebook Plus and Chromebook Pro

Every other hybrid laptop on the market weighs more than I want or is somehow compromised. Meanwhile, Apple maintains its lust for OS and device purity, desiring that I pay thousands of dollars for a phone, tablet, computer, watch, and whatever else they can design, with three differet OSes, rather than building practical, multi-purpose systems.

Ultimately, I grabbed a Chromebook Plus for $417 on an open-box special at Best Buy. So, let me give you a preview of the writeup of my next experiment: *Can You Code on a Chromebook?*

Here are some salient facts about the Samsung Chromebook Plus that I've been using the past couple of weeks:

- In a store full of hybrid computers, this was both the lightest *and* the cheapest
- It runs a full version of desktop Chrome with developer tools, which syncs across my devices
- It runs Android apps in a crazy inter-operating mode that is a little delirious and very promising -- and on the Plus, works well because of the ARM processor
- The stylus works better than any stylus I tried with iPads over the past few years, especially with Android apps like Google Keep and Squid
- There is a great SSH and Mosh client available
- It can run web applications in a windowed mode that allows full keyboard shortcut support -- Chrome doesn't intercept them!
- Battery lasts *forever* -- 10-15 hours in my use
- VPN support is basically atrocious, but SOCKS5 proxies work well enough
- It's too heavy for one-handed reading, but is still enjoyable as a tablet

That's all until next time, when I return with *Can You Code on a Chromebook?*
