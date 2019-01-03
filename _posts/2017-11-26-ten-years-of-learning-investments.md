---
title: 'Ten Years of Learning Investments'
date: 2017-12-19
author: Andrew
layout: post
permalink: /technology/ten-years-of-learning-investments/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology, Learning
custom_css:
  - /assets/css/learning.css
custom_js:
  - https://code.highcharts.com/highcharts.js
  - https://code.highcharts.com/highcharts-more.js
  - /assets/js/learning.js
image:
  feature: caleb.jpg
---

I'm coming up on ten years as a professional software developer. One tip I learned from reading _Pragmatic Thinking and Learning_ was to treat learning as an investment and manage these investments as a portfolio over time. This post reviews the most notable learning investments I made in the past decade and my subjective assessment of the returns.

I chose a bubble graph to represent this data. In the graph, the x axis is the age of the skill investment, the y axis is the ROI, and z axis (the size of each bubble) is the energy invested.

<div id="container" style="min-height: 600px; max-height: 1000px;"></div>

## Insights

Here are a few insights that this process helped clarify:

- In the first four years of my career, I seem to have invested a huge amount of energy, and this matches what I remember: I stayed up very late and woke up early to work on learning projects
- When my daughter was born around year five of my career, I began to make fewer investments overall and more non-technical investments; however, many of these investments had high returns
- Some investments in my career didn't pay off very much given the effort involved: Devops, Drupal, iOS dev, Node.js, MySQL, functional programming, Clojure
- Some of my highest-return investments were non-technical: running, meditation, D&D
- There are areas I'm 100% confident will yield more returns with modest continued investment: Ruby, Rails, concurrency, Python, Linux/UNIX, technical writing (blogging)
- A few investments are close enough to high-returning that I'll keep investing low effort in them and monitor the results: Golang, Java, WordPress
- I'm experimenting with some new investments that I'm not sure will pay off: UI/UX design, Kubernetes, and Graph Databases


## How I Made the Graph

To create the graph, I wrote down the major learning investments I made over the past ten years and then assigned two abstract numbers to each: one representing the energy I invested and the other the benefit I gained. With these, I could calculate my return on investment (ROI) for each investment and graph the result.

### The Return on Investment Formula

According to [Investopedia](https://www.investopedia.com/terms/r/returnoninvestment.asp), the return on an investment is the gain minus the cost, divided by the cost.

So, what is the gain and cost of learning investments? Cost was easy: I considered the energy I invested in learning something its cost. Gain was harder. After tossing around a few ideas for how to measure gain, I decided on my final approach: "Happiness Units."

### Measuring Learning Investments With Happiness Units

The problem I ran into with rating my gain from learning investments was that some of my investments had financial benefit, while others were more about satisfaction or joy. I wanted to create a number that could rate both types of investment.

After pondering this, I created a measurement called Happiness Units. The number of Happiness Units gained from a learning investment is the sum of four numbers representing types of gain from the investment: satisfaction, joy, stability (financial or otherwise), and benefit to others.

With that decided, I gave each learning investment a Happiness Unit rating, came up with a rough estimate of the energy I'd invested for its "cost," and recorded the age of the investment (roughly speaking, the date I began learning).

Happiness ROI, then, is the gain in Happiness Units minus the cost in energy invested, divided by the cost. Those were enough numbers to produce an obviously unscientific, but still interesting, graph.

## Learning Investments Sorted By Age

Following are my descriptions of each learning investment in the graph, sorted roughly by the age of the investment.

### Kubernetes

<p class="kubernetes">
  Containers are interesting by themselves, but things get really interesting when you try to "orchestrate" them. Kubernetes seems to have become the leader in the pack of current technologies to do this, so I'm throwing some attention on it to get the basics down.
</p>

### Graph Databases

<p class="graph-databases">
  This is a new area I'm beginning to invest in, after being exposed to JanusGraph while working at IBM. I'm working on a learning project that may use a graph database. I'll see what I think after more experimentation!
</p>

### Ruby

  <p class="ruby">
    I used Ruby briefly early in my career, but dropped it for Python. Recently, however, I decided to tour some non-Python languages professionally, beginning with Ruby. The slight investment I made in it paid off handsomely with an interesting job working for IBM.
  </p>

### Rails

  <p class="rails">
    Using Rails day-to-day feels about the same as Django and other web frameworks in dynamic programming languages, but having experience with it in a production environment unlocks many potential jobs.
  </p>

### MongoDB

  <p class="mongodb">
    I don't enjoy working with MongoDB as much as PostgreSQL, but as it's used extensively at my current job, the current return on anything I learn about it is high.
  </p>

### Management

  <p class="management">
    A couple of years ago, I had an unexpected offer to try management. I love working with people and genuinely enjoy contributing to another person's success, so I wondered if management might be a career path for me. What I learned was that management is a much less creative activity than software development -- or at least, it seemed so at the time -- and in the end I decided to back out. However, I may give it another chance later in my career.
  </p>

### UI/UX Design

  <p class="ui/ux-design">
    For most of my career, I thought I lacked the natural talent to do design work, so I never tried. However, I have a more growth-oriented mindset now, and I'm very excited by the world of design. Ultimately, I'd like to be someone who can design a software interaction well <i>and</i> code it up, so I'm beginning to invest in this area.
  </p>


### Meditation

  <p class="meditation">
    Meditation saved me during a period of depression I experienced after becoming a father. (To call parenting "difficult" would be a criminal misuse of English.) If my career imploded tomorrow, I would be happy with the increased time I had to meditate. If you can find an activity like that to invest in, do it post-haste.
  </p>

### Dungeons & Dragons

  <p class="d&d">
    My antidote to technical and parenting burn-out is one part meditation and another part Dungeons & Dragons. It's an analog activity that I do face-to-face with friends and an absolute minimum of technology. I can't recommend it highly enough, as a kind of uber-game that can become anything you want: turn-based strategy, social/acting improv, immersive story-telling platform -- truly anything.
  </p>

### Solr

  <p class="solr">
    Solr was my bread and butter for a year or two. Getting a taste for search as a problem domain was intriguing. Challenges often boiled down to how to "boost" certain facts about a piece of content correctly, or else how to create a good user experience around search. Certainly this is an area where a person could specialize in algorithms, UI and UX, and more. However, I don't see specializing in it <i>myself</i>.
  </p>

### Docker

  <p class="docker">
    Docker and container technology have become very popular recently. I learned how to create and manage Docker containers and images while deploying a microservice during the Great Microservice Craze of 2014. Docker, or at least container technology, has stuck around, and my experience with it is directly useful in my current position.
  </p>

### Microservices

  <p class="microservices">
    During the Great Microservices Craze of 2014, I built some microservices. Well, one that I can remember, anyway. Lucky for me, I didn't just build a fresh microservice, I got to peel out a search API from a monolithic app and make it a separate service, which was a much trickier experience. I learned a lot about service-oriented architecture in the process.
  </p>

### Running

  <p class="running">
    To get in shape after becoming a father, I started running. Now it's one of my primary tools to stay energetic and avoid depression and anxiety.
  </p>

### Responsive Design

  <p class="responsive-design">
    I love when a content-rich web site can scale down to small screen sizes. A few years ago I invested some energy into the primary technique that sites use to do this: CSS media queries. Understanding the approach let me work on interesting frontend projects and generally amped up my frontend skills.
  </p>

### Go

  <p class="golang">
    After having my eye on Go for a couple of years as a potential long-term replacement for Python as my daily language, I began investing more seriously by writing toy projects in it a few years back. Now the software industry is ramping up Go development and I'm positioned well to move into it if needed.
  </p>

### EPUB

  <p class="epub">
    I learned the EPUB format for my work at Safari Books Online. Useful at the time, but this one is rapidly decaying in value, as I don't see myself becoming an EPUB expert in the future.
  </p>

### Java

  <p class="java">
    Java was big news when I was a teenager, so I toyed with it and Object Oriented Programming, but only really learned it a few years ago while doing plugin development for Intellij Idea. Now I feel comfortable jumping into a Java project at IBM when the need arises.
  </p>

### Cloud Infrastructure

<p class="cloud-infra.">
  I've invested modest amounts of time learning and using Google Cloud Platform, Amazon Web Services, and now IBM Cloud/Bluemix. The best of these investments was probably AWS because of how popular it is with companies. The most directly relevant to be now is IBM Cloud.
</p>

### Remote Work

  <p class="remote-work">
    Remote work sounds like a perk; in fact, I consider it a set of skills like asynchronous communication and motivating yourself. After a challenging first couple of years, I'm now productive and happy working from home. To satisfy my need for social interaction with quasi-strangers, I occasionally work at a co-working space, and I like to meet my coworkers once or twice a year.
  </p>

### Intellij IDEs

  <p class="intellij-editors">
    Have the many hours I've invested in mastering Intellij IDEs and plugin development actually paid off in more productivity and happiness? I don't really know.
  </p>

### Web Security

  <p class="web-security">
    I study and stay aware of web application security issues, but doing so has only made me more paranoid and aware that every web application is riddled with undiscovered security flaws. Am I keeping users more safe than otherwise? Maybe?
  </p>

### iOS Development

  <p class="ios-dev">
    I worked on iOS development while at Dark Horse Comics. It was a lot of fun, but for some reason it never enticed me away from web development. Every year since then, I've asked myself: "Would I rather do mobile apps?" And every year, I'm still more interested in the web. Maybe 2018 will be the year I become an iOS developer.
  </p>


### MySQL

  <p class="mysql">
    Learned it and worked quite a bit with it during my PHP years. I even dug into MySQL operations and administration for a bit. However, almost no company I've worked with in recent years has used it, favoring PostgreSQL instead.
  </p>

### Python

  <p class="python">
    I learned Python early in my career, and soon after that, it became super popular. I've never had trouble finding Python work, and it's a joyous language that taught me a deep respect for the craft of programming.
  </p>

### Django

  <p class="django">
    Django fed my family for many years. Always a joy to work with, and with a delightful community, I have no complaints. It's a little hobbled by WSGI and, like Rails, doesn't have much of a WebSockets or concurrency story yet. We'll see how the framework develops, but I'm optimistic.
  </p>

### REST

  <p class="rest">
    I learned REST-oriented service design as the industry was coming off using SOAP for services. The notion of "resources" was confusing at first, but gelled pretty quickly, and almost every team I've worked with since has developed RESTful web services. Will we be using GraphQL and more RPC services in ten years? Maybe?
  </p>

### Clojure

  <p class="clojure">
    I had so much fun learning Clojure and functional programming, and then I never touched it again.
  </p>

### Node.js

  <p class="node.js">
    The idea of using JavaScript on the frontend and backend of a web application was so appealing that I immediately jumped into node.js when people started writing about it. However, at that time, the cost of using such a sub-standard language was too high, so I abandoned it. Will this change with ES6 and future version of EcmaScript, or WebAssembly? We'll see.
  </p>

### Functional Programming

  <p class="functional-programming">
    Learning about functional concepts like immutability seemed very important at the time, because every web service was going to be concurrent and use multiple cores and the future was functional languages. That doesn't seem to have happened yet, but if it ever does, I have the basics down at least.
  </p>

### Concurrency

  <p class="concurrency">
    One learning investment I continue to put energy into is concurrent program design. I'm not a systems engineer producing highly-concurrent applications, so I have to spend extra effort to practice. However, even in web applications, this occasionally pays off, as I've been able to use threading and multi-process concurrency approaches to break up difficult tasks, and have delved deep into asynchronous job processes with AMQP queues.
  </p>

### Wordpress

  <p class="wordpress">
    I don't like using or working with WordPress, and I no longer use it for my blog. However, lots of non-profits use WordPress, so knowing it has opened up some great volunteer opportunities.
  </p>

### JavaScript

  <p class="javascript">
    At first, I just used JavaScript for form validations and simple animations. However, after having to build a single-page application that allowed comics editors to create digital comics from source images, I realized that doing JavaScript well was the only way to create rich, interactive web applications I invested many, many hours of professional and personal time into JS, and all of it paid off well in interesting work and useful features I built for users.
  </p>

### Technical Writing

  <p class="tech-writing">
    I've been writing a tech blog for several years now, always in a very part-time capacity, with just a few posts a year typically. I always plan to write more frequently, but still haven't made doing so a high priority. Even so, many coworkers and friends end up stumbling onto my posts, and occasionally I get many thousands of readers for a piece of content, so I'm happy with my progress.
  </p>

### SQL

  <p class="sql">
    Despite wanting to love SQL for its functional and declarative flavor, I never have, and I tend to invest only as much as is needed to get whatever report or feature I'm working on done. Increasingly these days, I use the ORMs provided by Django and Rails, so the investment is less and less.
  </p>

### PostgreSQL

  <p class="postgresql">
    PostgreSQL seems to be the most popular database choice among companies I've worked with in the past ten years. While I'm not innately driven to learn about Postgres, all the time I've invested in learning about it has generally paid off on the job due to its popularity.
  </p>

### Algorithms

  <p class="algorithms">
    The academy didn't train me; my software career was born in the darkness of midnight, as I labored to build learning projects. This learning strategy has been less helpful with algorithms and data structures, about which I occasionally read books. I have more to learn, but I also don't encounter algorithmic problems very often in daily work, and I've at least learned enough to approach them productively when I do.
  </p>

### Devops

  <p class="devops">
    This is an odd term that I take to mean operations work approached with an eye toward automation. I spent a year or two learning some devops approaches common at the time: system automation with Chef, dev environment automation with Vagrant, creating distributed QA and test pipelines with Python, etc. I'm happier building things that have some kind of visual user experience, so much of these skills are currently fallow.
  </p>

### Linux/UNIX

  <p class="linux/unix">
    I've been using Linux, first on the desktop and then on servers, for many years. While the many hours I spent tweaking my Gnome configuration certainly feels like a waste of time, understanding Linux -- the command line, basics of the kernel and process management, etc. -- has been useful in 100% of my jobs. Even though I use a Mac now, many of the concepts and most of the tools I've learned are applicable there as well.
  </p>

### Vim

  <p class="vim">
    Ah, Vim! What pleasure and suffering you have wrought! If I had spent fewer hours on my Vim configuration or obsessing over plugins, Vim might be closer to the top of the list. However, it has sure sucked a lot of my time for the benefit I've seen... and I'm not sure I'm any more productive than I might have been without it.
  </p>

### PHP

  <p class="php">
    The first language I was paid to work with. I poured hundreds of hours into learning it and the forms-based web development patterns common at the time, only to abandon it for Python after a couple of years. Still, it got me started.
  </p>

### HTTP

  <p class="http">
    Learning the HTTP protocol has benefited me enormously as a web developer, because it's one of the foundational technologies that all aspects of web development deal with. I continued to invest in understanding the latest version of the protocol, HTTP/2, though so far I've been a little disappointed in the gains from new features like pipelining.
  </p>


### HTML/CSS/SASS

  <p class="html/css/sass">
    As a "full-stack" developer, I build server-side features with HTTP, JSON, and REST principles, but I also love to work on client-side code using JavaScript (or ES6), HTML, and CSS (or SASS/SCSS). I've seen a lot of happiness and job opportunities around my ability to work both angles, and especially to craft the parts of an application that humans interact with, most of which is still powered by HTML and CSS.
  </p>

### Drupal

  <p class="drupal">
    For a year or two, I was pretty much a Drupal developer: I worked on plugins and Drupal sites primarily. Hated it.
  </p>

### Filemaker Pro

  <p class="filemaker-pro">
    A non-profit I worked for used FileMaker Pro. It was very popular with non-profits at the time, and was essentially like Microsoft Access, but for Macs. Or at least, it was that way for a long time... or something? I wrote some crazy PHP scripts that integrated with it and then walked away. I now believe that letting people build databases without any knowledge or understanding of schema design is a recipe for disaster.
  </p>

