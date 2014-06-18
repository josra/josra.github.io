---
layout: dojo
title: The peer-review dispute
---
### Exercise - Peer-reviews
__What would be your stance in a dispute where developers argue back and forth about the importance of peer code reviews and how to implement it?__

A company has a vivid discussion internally about how to conduct peer-reviews. To settle the dispute they have asked for advice on _best practices_.

This is what we know:

* They are using Git as their VCS and Jenkins as their CI platform
* They have not yet introduced a tool that supports peer reviews.
* They have established a build pipeline that consist of the following outline:
    1. Build and unittest
    1. Code coverage, static analysis and a few other metrics
    1. Automated generation of embedded documentation
    1. Automated deployment
    1. Automated execution of a small subset (_smoke test_) of their functional tests
    1. A full regression test

The dispute among developers is about where the peer-review should be placed in the pipeline, some argue that it should be the very first step, even before build and unit test, while others argue that it should be done much later, after the smoke test just before the regression test. A few hard-liners even claim that peer-reviews are simply just waste of time. There is a second level to the dispute as well, it's about tools. Some claim that a tool should be introduced to support peer reviews, others argue that it's the amount of eyes that look at the code that makes the difference, not what tool you use.

And then there is silence! 

Now everybody looks at _you_ with the expectations that you can help them put some weight behind exactly their stand point. What is your recommendation? Why? How would you settle the dispute?