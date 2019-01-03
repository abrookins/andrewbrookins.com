---
id: 440
title: Instant Django Dev Environments with Tmux, Tmuxinator, and Virtualenvwrapper
date: 2011-10-09T07:19:35+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=440
permalink: /tech/instant-django-dev-environments-with-tmux-tmuxinator-and-virtualenvwrapper/
aktt_notify_twitter:
  - 'no'
categories:
  - Django
  - Technology
---
This post describes how to use a few common tools to instantly set up and tear down Django development environments.

I&#8217;ve found that such automation is most useful when switching between branches in source control. Without automation, you have to manually kill and reconstruct any Django shell and development server instances for each branch (and sometimes the database shell, too).

While my examples are geared toward Django development, the approach I describe works equally well with Rails and other frameworks.

Tools used:

  * Tmux, a terminal multiplexer like GNU Screen
  * Tmuxinator, a nice Ruby gem for automating Tmux
  * Virtualenv, a tool for creating isolated Python environments
  * Virtualenvwrapper, a set of extensions to virtualenv
  * My <a href="https://github.com/abrookins/dotfiles/blob/master/.tmux.conf" target="_blank">tmux.conf</a>

By the end of this post, you will have a new command available in your terminal that will create a Tmux session with multiple views into your Django project.

## <span id="Why_Tmux">Why Tmux?</span>

First, a quick note about Tmux.

Until earlier this year, I had used GNU Screen for managing persistent terminal sessions. It worked well. However, I grew dissatisfied with the pace of development in the project, the lack of new features, and the inconsistent availability of vertical splits across different platforms. So, I tried Tmux, and I haven&#8217;t gone back.

If you are a Screen user, then I suggest you try Tmux, but you can probably achieve a similar method to the one described in this post using Screen and one of the automation scripts designed to work with it.

## <span id="Virtualenv_and_Virtualenvwrapper">Virtualenv and Virtualenvwrapper</span>

My example uses virtualenv and virtualenvwrapper. Note that you do not need to use either of those tools to set up or tear down a Django development environment with Tmux. They just make working with multiple Python projects easier.

If you don&#8217;t use these tools, remove the `venvwrapper && workon my_project` portion of the examples.

I will skip explaining how to install those tools or use them, since many tutorials on those subjects exist already, in addition to the <a href="http://www.virtualenv.org/en/latest/" target="_blank">virtualenv docs</a> and <a href="http://www.doughellmann.com/docs/virtualenvwrapper/" target="_blank">virtualenvwrapper docs</a>.

After this point I will assume you have created a virtualenv for your Python code in a directory named `my_project` and have configured virtualenvwrapper so that you can execute `workon my_project` to activate the virtualenv.

## <span id="Install_Tmux_and_Tmuxinator">Install Tmux and Tmuxinator</span>

Install Tmux with your package management software of choice. It&#8217;s available in apt-get, MacPorts, etc.

Next, install Tmuxinator (instructions <a href="https://github.com/aziz/tmuxinator" target="_blank">here</a>).

As a side note, I recommend using [RVM](https://rvm.beginrescueend.com/) to manage your Ruby versions.

## <span id="Create_a_Project_File">Create a Project File</span>

Before taking this step, make sure you&#8217;ve followed the Tmuxinator installation instructions and have exported your EDITOR shell variable, e.g.:

<pre>$ export EDITOR=vim</pre>

Now, use Tmuxinator to create a &#8220;project file&#8221; (a YAML file containing shorthand configuration settings for Tmux).

<pre>$ tmuxinator new my_project</pre>

A file should now open in your text editor. The Tmuxinator docs use a Rails-inspired example. The following is a Django example in which I create a Tmux session with multiple windows (an explanation follows the example).

## <span id="A_Django_Example">A Django Example</span>

{% highlight yaml %}
# ~/.tmuxinator/my_project.yml
# you can make as many tabs as you wish...

project_name: my_project
project_root: ~/
tabs:
  - zsh: ls -l
  - shell: venvwrapper && workon my_project && cd my_project &&  ./manage.py shell
  - database: venvwrapper && workon my_project && cd my_project && ./manage.py dbshell
  - server: venvwrapper && workon my_project && cd my_project && ./manage.py runserver
  - logs:
      layout: even-horizonal
      panes:
        - tail -f /opt/local/var/log/nginx/access.log
        - tail -f /opt/local/var/log/nginx/error.log
        - sudo python -m smtpd -n -c DebuggingServer localhost:25
{% endhighlight %}

## <span id="Explanation_of_the_Example">Explanation of the Example</span>

The example creates a Tmuxinator project file named `my_project.yml`, which generates a `my_project.tmux` file and creates the command `start_my_project` that you can use to start the Tmux session.

The example assumes that a virtualenv exists in a directory named `my_project` and the env directory contains a directory named `my_project` (e.g., in my case, `~/envs/my_project/my_project`). Obviously, this should match whatever directory structure you actually use for your virtualenvs.

The Tmuxinator docs describe everything that you may configure with a project file. There are more options available than the ones in my example, but I use this relatively simple configuration for my day-to-day Django work, and it saves a bunch of time.

Here is an explanation of the options the example uses:

  * **project_name**: the name of the project; this becomes part of the command you use to launch a Tmux session, e.g., `start_my_project`
  * **project_root**: the starting directory for each command that you tell Tmuxinator to execute
  * **tabs**: each item in this list represents a named &#8220;tab&#8221; or Tmux window in which one or more shell sessions will run
  * **zsh**: I like to have a shell opened and pointed at my home directory for random commands
  * **shell**: activate the virtualenv and load the Django shell for my project
  * **database**: activate the virtualenv and load the database shell for my project
  * **server**: activate the virtualenv and start the Django development server for my project
  * **logs**: create a three-pane split using Tmux&#8217;s `even-horizontal` layout (each pane is an even height) to display logging output from nginx, which is running my dev machine and proxying requests to the Django dev server, and a Python SMTP debugging server (because I like to see HTML/text dumps of emails generated during development)

Now, assuming you followed the Tmuxinator docs and have the following line in your zshrc/bashrc (&#8230;):

<pre># Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator</pre>

&#8230; You can run `start_my_project` from your shell of choice to open a Tmux session with all the tabs you configured.

## <span id="Making_this_Really_Useful">Making this Really Useful</span>

Instantly summoning a development environment is great, but where this approach really shines is when you need to switch branches in your project.

In a single day, I might work on two or three different branches in one project. Before using Tmux and Tmuxinator, I would have to constantly kill and restart various commands each time I switched to a different branch. Now I just do the following:

  * Issue the `kill-session` command within a loaded Tmux session (`Ctrl-b : kill-session <CR>`)
  * Back at the shell, run my `start_project` command again

Two commands to restart an entire session from the new branch. Handy! And, if you have other sessions loaded, `kill-session` preserves them by killing only the session you are currently in (`kill-server` kills all sessions).

## <span id="Summary_Other_Resources">Summary, Other Resources</span>

Tmux is great, and automating session creation has saved me a lot of time. I hope it saves you a few precious minutes (hours?!), too.

If you&#8217;re a Screen user who has read this far, I encourage you to try out a similar approach with <a href="https://github.com/jondruse/screeninator" target="_blank">Screeninator</a>. Of, if you just want to get some tabs up in your terminal app, try <a href="https://github.com/achiu/terminitor" target="_blank">Terminitor</a>.

## <span id="Addendum_Multiple_Sessions">Addendum: Multiple Sessions</span>

One thing I love about Tmux is that you can have multiple sessions open. So, for example, while I&#8217;m working I usually have two sessions open: my Django project session and a session for system administration that has my Chef repository (using <a href="https://github.com/tobami/littlechef" target="_blank">LittleChef</a>) and a few SSH tabs open:

{% highlight yaml %}
# ~/.tmuxinator/work.yml
# you can make as many tabs as you wish...

project_name: work
project_root: ~/
tabs:
  - zsh: ls -l
  - chef: venvwrapper && workon kitchen
  - qa: ssh username@my_qa_server
  - prod: ssh username@my_prod_web_server
  - (several more ssh sessions here)
{% endhighlight %}

This is nice because I can quickly switch sessions within Tmux with `Ctrl-b s`.

I also have other sessions for Clojure projects and so forth that I&#8217;ve configured for hacking around on the weekend. Go Tmux!