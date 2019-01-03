---
id: 274
title: 'Vim for Thunderbird: Muttator extension External Editor extension'
date: 2009-11-13T09:54:00+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=274
permalink: /tech/vim-thunderbird-muttator-extension-external-editor-extension/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
In my quest for the Holy Grail of daily Internet use (IE, how to get vim-style keybindings and modular editing with _everything_), I finally &#8212; at 6 a.m. this morning &#8212; was delivered.

**Update (11/28/2011):** This post is out of date and no longer maintained.

<p class="rteleft">
  Here are the steps I suggest as a method for recovering control of your keyboard, assuming that you prefer not to use mutt to check multiple IMAP email accounts.
</p>

The following will get you vim-style key bindings in Thunderbird and allow you to use vim &#8212; or another real text editor &#8212; to write your email.  Easier than piecing together a 700 line .muttrc file, I promise!

### Step 1: Get Thunderbird Beta 2 and the muttator 0.5 extension

<li class="rteleft">
  Download and install Thunderbird Beta 2: <a href="http://www.mozillamessaging.com/en-US/thunderbird/early_releases/downloads/">www.mozillamessaging.com/en-US/thunderbird/early_releases/downloads/</a>
</li>
<li class="rteleft">
  Download and install the latest nightly build of Muttator 0.5, a beta add-on that lets you control Thunderbird with vim-like keybindings: http://<a href="http://download.vimperator.org/muttator/nightly/">download.vimperator.org/muttator/nightly/</a>
</li>
<li class="rteleft">
  Open the <strong>muttator*.xpi</strong> file with 7-zip (on Windows) or a compression app of your choice on Linux, then edit the file: <strong>install.rdf</strong>
</li>
<li class="rteleft">
  Change the number between the <code> &lt;maxversion&gt;&lt;/maxversion&gt; </code> tags to: <code>3.0.*</code>
</li>
<li class="rteleft">
  Saveinstall.rdfback intomuttator*.xpi
</li>
<li class="rteleft">
  Open Thunderbird, click Tools -> Add-ons
</li>
<li class="rteleft">
  Click Install and select muttator&#8217;s .xpi file, then restart Firefox
</li>
<li class="rteleft">
  You will probably want to view the toolbar (if you want to easily use T-bird&#8217;s message search function) and the menu for preferences, so issue the following commands after hitting escape or another escape-mapped key to enter comnand mode:
</li>
<li class="rteleft">
  <code>:set guioptions =Tm &lt;Return&gt;</code>
</li>
<li class="rteleft">
  <code>:mk! &lt;Return&gt;</code>
</li>

These two commands enabled the mail toolbar and top menu, then saved that setting in your muttatorc; the command help isn&#8217;t available yet, so refer to vimperator&#8217;s docs or an earlier version of muttator for help.

### Step 2: Get the External Editor extension and configure it to use vim

<li class="rteleft">
  Download External Editor 0.8, a Thunderbird extension that lets you edit your mail in the text editor of your choice: <a href="http://globs.org/download.php?lng=en">http://globs.org/download.php?lng=en</a>
</li>
<li class="rteleft">
  Open Thunderbird, go to Tools -> Add-ons, Install and choose the <strong>exteditor*.xpi file</strong>
</li>
<li class="rteleft">
  Restart Firefox when directed
</li>
<li class="rteleft">
  Go to Tools -> Add-ons -> Extensions, select External Editor, and click Options
</li>
<li class="rteleft">
  Enter &#8220;vim&#8221; or &#8220;gvim&#8221; if either of those commands are available in your environment, or click Browse to tell External Editor the location of the vim binary
</li>
<li class="rteleft">
  Click OK, then close the Options window
</li>
<li class="rteleft">
  Issue the <code>m</code> command to write a new message if using muttator, or click the Write button
</li>
<li class="rteleft">
  <strong>Oddly, a required step: </strong>Click View -> Toolbars -> Customize, then drag the External Editor button onto your toolbar (even if you just want to use ^E to open vim)
</li>

You will probably have to close the window and reopen a write/reply window to see the button correctly, but you should now have a Gvim / Vim button &#8212; to edit the mail with Vim, either push the button or hit ^E.

### Step 3: Enjoy the Internet Again

<p class="rteleft">
  That should do it!  You can now use vim-like keybindings to browse the web and check your mail, and full on vim to write messages. Aren&#8217;t you glad you lived to see this day?
</p>