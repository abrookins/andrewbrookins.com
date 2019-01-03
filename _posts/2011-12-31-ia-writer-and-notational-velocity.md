---
id: 675
title: iA Writer and Notational Velocity
date: 2011-12-31T14:03:48+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=675
permalink: /tech/ia-writer-and-notational-velocity/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
The OS X apps [iA Writer](http://iawriter.com) and [Notational Velocity](http://notational.net) are great for writing and taking notes, respectively.

I wanted to try using them together, by setting iA Writer as the external editor for Notational Velocity, but after doing so I noticed that iA Writer would not open with the keyboard shortcut (Command-Shift-E), and it was grayed out in the &#8216;Note->Edit With&#8217; menu.

After tinkering, I found that Notational Velocity&#8217;s note storage must be set to plaintext files and the file extension must be &#8216;.txt&#8217; (or &#8216;.md&#8217;, which is iA Writer&#8217;s default file extension). The rest of this guide will assume you want to use &#8216;.txt&#8217; as the file extension for notes.

## <span id="Full_Requirements">Full Requirements</span>

So, the full requirements to use iA Writer with Notational Velocity are:

  * Set iA Writer as the External Editor in Notational Velocity
  * Use plaintext file storage for notes in Notational Velocity
  * Use the &#8216;.txt&#8217; extension for note files

## <span id="Set_iA_Writer_as_the_External_Editor">Set iA Writer as the External Editor</span>

  * Open Notational Velocity&#8217;s preferences
  * Click &#8216;General&#8217;
  * Choose &#8216;iA Writer&#8217; in the External Editor drop-down

## <span id="Use_Plain_Text_Storage_for_Notes">Use Plain Text Storage for Notes</span>

  * Open Notational Velocity&#8217;s preferences
  * Click &#8216;Notes&#8217;
  * Click &#8216;Storage&#8217;
  * Choose a folder to save and read notes from in the &#8216;Read notes from folder&#8217; drop-down (I suggest a [Dropbox](http://dropbox.com) folder)
  * Choose &#8216;Plain Text Files&#8217; in the &#8216;Store and read notes as:&#8217; drop-down
  * Highlight &#8216;txt&#8217; in the Extension list and click the check-box to make it the default extension

## <span id="Changing_Existing_File_Extensions">Changing Existing File Extensions</span>

If iA Writer is still grayed out in the &#8216;Note -> Edit With&#8217; menu or fails to respond to the external editor keyboard shortcut, make sure that the notes you are editing have the &#8216;.txt&#8217; extension.

All of your notes should now be stored as individual files in the folder you chose in Notational Velocity&#8217;s preferences. To change the extension on these files, open that folder in Terminal or Finder and rename the files so that they end with &#8216;.txt&#8217;.

## <span id="Batch_Renaming_Files_in_Terminal">Batch Renaming Files in Terminal</span>

If you have tons of notes and need to change all of them to a new extension, open Terminal and `cd` to the folder you chose for note storage in Notational Velocity. Then run the following command (assuming the original extension of the files was &#8216;.wiki&#8217;, which it was in my case):

        for old in *.wiki; do mv "$old" "`basename $old .wiki`.txt"; done
    

## <span id="Done_Bonus_Round">Done… Bonus Round?</span>

You should be set now.

However, iA Writer uses the Markdown format, so as an extra bonus you could add a Markdown plugin to Vim, allowing you to easily edit the same text files in Notational Velocity, iA Writer and Vim, which is of course the greatest text editor of all time.