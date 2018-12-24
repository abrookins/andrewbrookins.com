---
title: What Are We Doing Here?
date: 2018-12-24
author: Andrew
layout: post
permalink: /technology/what-are-we-doing-here-software-engineering/
lazyload_thumbnail_quality:
  - default
wpautop:
  - -break
categories:
  - Technology, Ethics
image:
  feature: northwest-passagenew.jpg
---


> I fight for the user!
>
> -- TRON


The first program written for a computer ran June 21, 1948 on the Manchester Mark 1[^1]. By that measurement, software engineers have been writing code for seventy years. That means we've been cursing at compilers, pulling all-night debugging sessions, and arguing about curly braces for seven decades.

Why do we do it? Aside from the joy of creation, what is the point of the work?

There are as many answers to that question as there are people who ask. However, one answer can elevate our profession and fill our work with purpose:

_We, as software engineers, exist to serve the common good._


## What We're Up Against

That software engineering is about serving the common good is an uncommon idea in our profession, where ideas about the purpose of our work come frequently from either the people paying us or the companies selling us things.

Venture capitalists want us to make them money, so they compare founding a startup to living in the wild instead of captivity[^2]. Big companies, non-profits, and governments want us to take their purpose as our own -- we should absorb and personally represent their brands, missions, or constitutional functions because they are paying us. Meanwhile, from the perspective of the companies selling us things, our choices about what to _consume_ contain the meaning of our work, not our acts of production.

(Let's not even get into the media coverage of our profession, from which in 2018 a reasonable person might guess that our principle goal is to build artificial intelligence to replace every job on earth[^3].)

There's nothing wrong with working for someone or taking investments, and living usually entails buying things. The problem is that we often conflate the purpose of our work with these transactions. Is the final meaning of a nurse's work that he makes the hospital more money? A firefighter's that she protects insurance companies?


## To Protect and Serve

Buying, selling, and enhancing the value of investments are all dimensions of our work, but none are the highest purpose of the work. That is to serve the common good. Some of us might go even further. Like the Los Angeles Police Department, we might *protect* and serve.

Which would you rather do: grind at a startup or protect and serve the common good? What if you could do both?

Wait! You can do both? To find out how, we will explore what "serving the common good" might look like for software engineers.


## What Is the Common Good?

> [T]hough it is worthwhile to attain the end merely for one man, it is finer and more godlike to attain it for a nation or for city-states [^4].
>
> -- Aristotle

There are technical and non-technical definitions of "public" and "common" _goods_, especially when used in economics. The common _good_ in this essay refers to something else.

Here, we do not mean public goods that a society collectively maintains, such as roads and other infrastructure. Some programs are so crucial to modern society that we may soon think of them this way, and maybe we ought to; parts of the internet come to mind. However, by claiming that software engineers ought to serve the common good, this essay does not mean that we should all direct our energy toward building public goods.

Instead, a philosophical definition of the common good is more useful to us as software engineers. Seen this way, it is a tool we can use while deliberating over how to act.

To that end, let us say that the common good is the set of interests and facilities that members of a society agree should be important and available to all members of the society. Note that the concept includes both "interests" and "facilities."


## Conflicts of Interest

One example of the common good in action is a public library. The Stanford Encyclopedia of Philosophy details this example well [^5]. A shared interest of the common good might be that everyone in a society has access to all human knowledge. The facility serving that interest might be the library itself.

However, despite a society agreeing to provide access to the public library, the ability of anyone in the society to learn anything from the library may conflict with the private interest of other citizens. In the Stanford example, a baker might wish to monopolize his knowledge of certain kinds of baking; that is not possible if anyone can learn anything at the library.

This example was designed to illustrate the difference between public and common goods in economic theory. For our purposes it demonstrates that the common good often modulates private interests. That is precisely how we should think of it as software engineers, as we so often are employed to satisfy private interests.


## The Intersection of Software Engineering and the Common Good

### Legal and Practical Intersections with the Common Good

The state legislates exactly where some domains intersect with the common good. However, in the U.S., that is only partially the case for software engineering.

The Health Insurance Portability and Accountability Act of 1996 (HIPAA) mandates controls to protect the privacy and security of certain health information[^6]. However, HIPAA only covers medical information -- and a subset of that.

Credit card companies mandate following the Payment Card Industry Data Security Standard (PCI DSS) if a business processes credit card transactions. That means any system we build that does so must be PCI compliant, or credit card companies will fine the owners of these systems.

State laws muddy the picture as well. Across the U.S., a number of laws and business codes exist to protect consumer privacy [^7]. But there is no unifying federal framework that specifies the general contract between software engineers and the common good, in law or otherwise.


### General Intersections with the Common Good

There are four areas of our domain that appear to intersect most with the common good, at least in the U.S. There may be more, but these are sufficient to deliberate over a wide variety of situations.

In all these domains, there is a principle at work that we can derive by imagining negative consequences happening to ourselves rather than others, similar to the "veil of ignorance" thought experiment proposed by John Rawls [^9].

#### Privacy

Our software should safeguard the privacy of the people who use it by retaining as little information about them as possible, explaining what we keep and what we do with it, and giving users the ability to delete this information.

Principle: Information about us can be dangerous, so we should keep as little of that information about others as possible.

#### Security

We should design our systems with security adequate to protect the people who use it from theft and attack.

Principle: When we entrust our data to a private system, its operators have a relational obligation to us to protect that data.

#### The environment

We should do as much as possible with as few of the earth's resources as we can. We should avoid polluting the environment.

Principle: Because we all depend on the earth, we share a responsibility to protect it.

#### Public health

We should not build software that harms the mental or physical health of people by design -- unless we do so in order to defend the constitutional order. We should undertake or fund research to determine the unintentional impacts that our systems have on the mental and physical health of people. Examples of negative impacts include blue light affecting sleep patterns, phone use causing vehicular death, and "dark design patterns" that produce addictive behavior in users.

Principle: Our lives depend on the health of our minds and bodies, so we should make the health of others our highest priority.


## How Can We Serve the Common Good?

If you make the common good your first priority as a software engineer, you might question:

- Is this interaction pattern designed to create addictive behavior in children?
- Is there another infrastructure provider that offers the same service while producing less pollution or using less non-renewable energy?
- Must we link the reading behavior of a user to personally identifiable information about them in order to build this feature?
- Is storing data about people on a hard disk without disk encryption secure enough to keep people safe?
- Have we built a login system that protects the safety of our users if we do not require two-factor authentication?

Empowered by a large enough group of your peers following the same principle, or alone by strong moral conviction, you might be able to say at a crucial moment, even if doing so risks setting back your career, "No, I cannot do that."


## Professional Conduct and Ethics

There is a reason that Americans consider nurses the most ethical profession in the United States[^8]. Gallup didn't ask, so we can't know what it is for sure. Still, if we examine the way that nurses work, we might glean some insights.

You might ask yourself if you think a nurse would prioritize the health and safety of a patient over a hospital's finances. Given the high degree of public trust in nurses, who beat out doctors and police officers, my suspicion is that most Americans think nurses would prioritize patient health above everything else.

That might be because Provisions 1-3 of the _Code of Ethics for Nurses_ are about recognizing the inherent dignity in all people, the primacy of the nurse's commitment to the patient, and the responsibility for nurses to advocate for patients [^10].

Software engineers ought to have such a Code. There are two that some of us already follow. These are the _ACM Code of Ethics and Professional Conduct_[^11], which is designed for all computing professionals and is also the most up to date, and the _ACM Software Engineering Code of Ethics and Professional Practice_[^12].

These Codes outline standards of behavior across many dimensions of our work as software engineers. They both start with our commitment to something greater than money or our employer: the common good.


## References

[^1]: Mike Hally (2005). Electronic brains: stories from the dawn of the computer age. National Academies Press. p. 96. ISBN 978-0-309-09630-0.

[^2]: http://www.paulgraham.com/boss.html

[^3]: https://www.economist.com/special-report/2016/06/25/automation-and-anxiety

[^4]: Aristotle. Nicomachean Ethics [Internet]. The Internet Classics Archive; available at http://classics.mit.edu/Aristotle/nicomachaen.html. I.2.1094b7–10 (last accessed 30 Jan 2011).

[^5]: https://plato.stanford.edu/entries/common-good/

[^6]: https://www.hhs.gov/hipaa/for-professionals/security/laws-regulations/index.html

[^7]: http://www.ncsl.org/research/telecommunications-and-information-technology/state-laws-related-to-internet-privacy.aspx

[^8]: https://news.gallup.com/poll/224639/nurses-keep-healthy-lead-honest-ethical-profession.aspx?g_source=CATEGORY_SOCIAL_POLICY_ISSUES&g_medium=topic&g_campaign=tiles

[^9]: https://en.wikipedia.org/wiki/Veil_of_ignorance

[^10]: https://www.nursingworld.org/coe-view-only

[^11]: https://www.acm.org/code-of-ethics

[^12]: https://ethics.acm.org/code-of-ethics/software-engineering-code/
