---
layout: post
title: CoDe - three epics to get you started
tags: [Continuous Delivery, Epics]
author: Lars Kruse
---

__So, you want to evolve your software development and release process to become one that is based on the principles of continuous delivery, one where quality is actually built in and where every commit to the versions control system is a potential release candidate. This journey typically starts with an analysis and assessment to capture a vision about where you are headed - but where do you go from there? How do you get the change process started?__

We have had the privilege to be involved in this process a lot of times at clients of almost any thinkable size, ranging from tiny companies with just three employees to large world wide corporations with thousands of software developers.

Based on our experience, a clear pattern to the succesful strategy emerges. The one we have used the most over time and the one that has evolved into becoming our favorite approach takes off-set in thes assessment and analysis you have done and starts with the following three _epics_:

* Infrastructure
* Proof-of-concept
* Proof-of-technology


[![Agile requirements big picture](/images/agile-req-big-pic.png){: .stdright}](http://scaledagileframework.com/)

The way we use the term _epics_ here is with reference to Dean Leffingwell's [framework for agile requirements management](http://scaledagileframework.com/) where the line-organization takes responsibility for an _investment theme_ at the _portfolio_ level and defines _epics_ for the _program_ which drives the product scope through _features_ and _releases_.

If the investment theme says: _"We wan't to be able to develop and release our software based on the principles of continuous delivery"_ then we suggest a roll-out strategy that starts with the three epics mentioned above.

The proof-of-technology epic comes from the _architectural runway_ while the infrastructure and proof-of-concept epics comes from _portfolio vision_. 

The two epics from the vision have the purpose of producing visible results, explore the principles, familiarize the role holders with their responsibilities and to get as much feed-back as possible from the software development team as well as the surrounding organization as possible. 

The epic from the architectural runway is about harvesting the experiences and making  strategic decisions that can mature the tool-stack, the hardware and the development adn release processes into a setup that can be the foundation for going forward.

## Infrastructure
In this context the term infrastructure does not refer to the hardware you need, but to the prerequisites for doing continuous delivery. _Features_ that derive from this epic could be:

* Team has established a thorough understanding of what Continuous Delivery implies and what we're trying to achieve.
* The tool-stack that shall support the strategy is available.
* The necessary team roles are assigned to people, who understands the responsibilities of the roles.

## Proof-of-concept
The concept that we're referring to is the concept of _continous delivery_. The software development team must give evidence, that they are indeed capable of interpreting this concept into a platform that can implement their _definition of done_ through an automated continuous delivery pipeline. _Features_ that derives from this epic could be:

* Pipeline is stablished on the chosen automation platform.
* A representative number of software verifications, deployments and functional tests are succesfully automated and combined into a pipeline.
* All existing automations are migrated to the new platform.
* Team processes are developed and adapted to feed the pipeline.

## Proof-of-technology

The term technology is used in a broad sense, covering not just the tool-stack but even  principles such as _software as inventory_ which probably affects both your system architecture and you approach to build- and dependency management and it touches on the principle of _configuration as code_. _Features_ that derives from this epic could be:

* Hardware is correctly sized and sufficient availability secured either through involving operations department or by actually bringing in ops skills to the development team.
* Technical depth that you may justifiably have build up into the configuration in the need for speed in the previous two epic is paid back to a level that is controllable going forward.
* All tools and technologies you've utilized to implement the previous two epics are carefully reviewed and evaluated, if any of them are disposed as not good enough, you will replace them with others you believe in better. 

## Changing habits

You probably might wish, that your could map each epic to a 14 day sprint and you would be all done in just one and a half month. But the truth is that continuous delivery is not a revolution, it's about commitment to an entirely different mindset, and you probably want to implement it using the resources that you already have. So make it an evolution.

Instead of hoping for a revolution you should make the analogy to that of a person who is trying to change his habits. If a person is overweight and endangered for having heart attacks it's not likely that you would suggest a one and half month cure to fix it permanently. You would probably instruct this person to change his ways, in a sustainable change process and keep that new track - for the rest of his life.

No one has yet recorded any software development team, who successfully changed their habits and implemented continuous delivery in their development and release process - and then regretted it and therefore returned to the process of the days before they had it. 

That should serve as proof that investing the necessary resources in implementing a software development and release process based on continuous delivery principles is not something that you will ever regret.

## What comes next?

There are a handfuld of obvious epics that might follow the three we suggested for starters. But a lot of things may influence on the process that makes it almost impossible to point out generic next-steps, they should be carefully adapted to you ambitions and your setup but when you get there, you could consider some of these which are all some that we're run in different contexts:

* __Software as inventory__ Focus on the system architecture and the build- and release process. Break you system up into components and products that can be individually released and managed as inventory.
* __Configuration as code__ Separate _what_ from _how_ embrace the concept of DevOps and start caring for you configurations and automated processes with the same level of professionalism as you care for the code you produce for your product.
* __Scale for growth__ Optimize you automation platform to support unlimited (in theory at least) growth. If your automation resources are sparse and limited it will impose a liability on you. Build a platform that can automatically shrink and grow upon demand. Become friends with your IT-operations department.
* __Optimize the pipeline__ Focus on the steps in your pipeline that still takes a long time to execute - it's probably in the area of your functional regression test.  
* __Roll out__ Make sure the results that your tiger teams and local heroes has achieved are formalized and rolled out into the whole organization - educated, train, recruit.


