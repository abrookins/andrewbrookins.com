---
id: 1246
title: 'PyCharm: Open the current file in Vim, Emacs or Sublime Text'
date: 2014-09-30T22:13:40+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=1246
permalink: /python/open-the-current-file-in-vim-emacs-or-sublime-text-from-pycharm/
categories:
  - Programming
  - Python
---
Even though I use PyCharm, I still drop into Vim occasionally to edit configuration files. This was an annoying process until today, when I discovered that PyCharm and other Intellij editors can open the current file in an external tool. This works with both GUI and console-based applications, and its most trivial use case seems to be opening the current file in an external editor.

So, how does it work? Easy — this should only take a minute or so! Instructions are geared toward OS X users, but should be clear to users on other operating systems.

<!--more-->

## Step 1: Set up an external tools entry for your editor

  * Open PyCharm -> Preferences
  * Click on or search for “External Tools” 
  * Click the “+” button
  * Give your editor a name, like MacVim
  * Check “Synchronize files after execution” to sync edits made between the editors while the file is open in both
  * Uncheck “Open console” if the editor is a GUI application
  * Set the program path — for GUI OS X applications, this is the application bundle, e.g. /Applications/MacVim.app
  * For “Parameters” enter “$FilePath$”, an Intellij macro that will automatically send the absolute path of the current file to the external editor
  * For “Working directory” enter “$ProjectFileDir$”, an Intellij macro that will automatically set the working directory to the directory containing your Intellij project file; this is my preference because in PyCharm the project file directory is usually the directory you opened the first time you opened your code in PyCharm, and for me, that is my git checkout (see “Insert macro” for other directories you can use)
  * Click OK

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Adding-an-external-tool-in-PyCharm.png" alt="Adding an external tool in PyCharm" width="1269" height="958" class="alignleft size-full wp-image-1272" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Adding-an-external-tool-in-PyCharm.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Setting-the-program-path-for-an-external-tool-in-PyCharm.png" alt="Setting the program path for an external tool in PyCharm" width="1334" height="968" class="alignleft size-full wp-image-1278" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Setting-the-program-path-for-an-external-tool-in-PyCharm.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Choosing-MacVim-as-an-external-tool-in-PyCharm.png" alt="Choosing MacVim as an external tool in PyCharm" width="854" height="962" class="alignleft size-full wp-image-1273" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Choosing-MacVim-as-an-external-tool-in-PyCharm.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Clicking-on-insert-macro-for-the-working-directory-of-an-external-tool-in-PyCharm1.png" alt="Clicking on insert macro for the parameters setting of an external tool in PyCharm" width="1330" height="957" class="alignleft size-full wp-image-1282" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Clicking-on-insert-macro-for-the-working-directory-of-an-external-tool-in-PyCharm1.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Selecting-the-FilePath-macro-for-an-external-tool-in-PyCharm.png" alt="Selecting the FilePath macro for an external tool in PyCharm" width="836" height="1154" class="alignleft size-full wp-image-1276" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Selecting-the-FilePath-macro-for-an-external-tool-in-PyCharm.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Clicking-to-insert-a-macro-for-the-working-directory-setting-of-an-external-tool-in-PyCharm1.png" alt="Clicking to insert a macro for the working directory setting of an external tool in PyCharm" width="1342" height="964" class="alignleft size-full wp-image-1283" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Clicking-to-insert-a-macro-for-the-working-directory-setting-of-an-external-tool-in-PyCharm1.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Selecting-the-ProjectFileDir-macro-for-an-external-tool-in-PyCharm.png" alt="Selecting the ProjectFileDir macro for an external tool in PyCharm" width="840" height="1156" class="alignleft size-full wp-image-1277" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Selecting-the-ProjectFileDir-macro-for-an-external-tool-in-PyCharm.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Viewing-a-completed-MacVim-external-tool-in-PyCharm.png" alt="Viewing a completed MacVim external tool in PyCharm" width="1276" height="954" class="alignleft size-full wp-image-1279" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Viewing-a-completed-MacVim-external-tool-in-PyCharm.png)

## Step 2: Assign a keymap to the editor

One of my favorite things about this feature is that PyCharm lets you assign a key binding to each tool, so now that you have a “MacVim” tool in the menu tree, you can assign it a key binding.

  * Open PyCharm -> Preferences
  * Click on or search for “Keymap”
  * Select your keymap 
  * Search for “MacVim” or whatever editor name you gave the external tool
  * Double click on it and then click “Add keyboard shortcut”
  * Set whatever shortcut you like; Control+Shift+E worked for me
  * Click OK

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Adding-a-key-binding-for-a-MacVim-external-tool-in-PyCharm.png" alt="Adding a key binding for a MacVim external tool in PyCharm" width="1606" height="1346" class="alignleft size-full wp-image-1270" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Adding-a-key-binding-for-a-MacVim-external-tool-in-PyCharm.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Adding-a-key-binding-for-a-MacVim-external-tool-in-PyCharm-2.png" alt="Adding a key binding for a MacVim external tool in PyCharm (2)" width="1608" height="1346" class="alignleft size-full wp-image-1271" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Adding-a-key-binding-for-a-MacVim-external-tool-in-PyCharm-2.png)

## Step 3: Try it out

All right! Now the moment of truth. Open a file in PyCharm and use your keybinding, or navigate to the Tools -> Editors -> MacVim (for example) menu item. This should open MacVim with the file you chose, and better yet, the working directory will be set to the project root (at least in my setup, where all my PyCharm project files live in my project root directories).

Hope this was helpful! It certainly made my day. (Now if only I could change the detected file type of an open file within PyCharm, like I can with every other text editor on the planet.)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Clicking-on-a-new-MacVim-external-tool-menu-item.png" alt="Clicking on a new MacVim external tool menu item" width="906" height="904" class="alignleft size-full wp-image-1274" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Clicking-on-a-new-MacVim-external-tool-menu-item.png)

[<img src="https://andrewbrookins.com/wp-content/uploads/2014/09/Viewing-a-file-opened-from-PyCharm-in-MacVim.png" alt="Viewing a file opened from PyCharm in MacVim" width="1658" height="1264" class="alignleft size-full wp-image-1280" />](https://andrewbrookins.com/wp-content/uploads/2014/09/Viewing-a-file-opened-from-PyCharm-in-MacVim.png)