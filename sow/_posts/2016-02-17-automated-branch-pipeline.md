---
layout: sow
title:  Automated branch Pipelines
author: Bue Petersen, Lars Kruse
---

{% highlight shell %}
Minimum scope:   40 hrs
Atmel:           40 hrs
Josra Pot:        0 hrs
Status:          In progress
{% endhighlight %}


## [Contribute to {{page.title}}](/sow/)

### Goal statement

Make feature branching and continuous delivery play well together by automatically applying parts of your build and continuous delivery pipeline to your branches.

#### Features:

* Automatically create temporary pipeline for a new branch in your SCM
* Automatically clean up the temporary pipeline when branch is merged
* Configure which parts of the ordinary pipeline will be applied for branches

If you are using git and have a branchin gstrategy that utilizes separate development branches, such as the the Automated git­flow, and you have a mature automated process in place with established build pipelines for your integration branch, you will most likely also wish to reuse part of the process temporarily on your development branches until they are delivered.

### Suggested solution

Our sugggested design idea focuses on reusability across different build systems and SCMs so they are abstracted by a service. This will help getting a larger userbase and share development effort in the future. It also make the solution more tool agnostic.

* __Repository trigger:__ ​Triggers for the repositories support that we can invoke the branch pipeline service with the needed information.

* __Branch pipeline service:__ ​A generic service running that the triggers will invoke. The service will create, delete and maintain the temporary build pipeline (a dockerized service accepting JSON could be a choice).

* __Branch pipeline configuration file:__ A​ general purpose configuration file, human readable and easy to merge (YML could be a one such choice). This is not the build pipeline and workflow description used, e.g Jenkins Job DSL.

### Estimated workload

The estimated workload for this task is 40 hours.

### Deliverables

A proof-of-concept. A limited implementation using specific technologies to explore the workflow and use ­case. It will be using Git and Stash as SCM, Jenkins as build system, Jenkins Job DSL to describe the continuous delivery and build pipeline. Scripting will be groovy as this is already heavily used in those technologies.

* Research conclusions prior work ­ see below.
* A trigger setup for Stash. This could either be a description on how to configure an existing Stash plugin to invoke the service or a new Stash plugin if none of the existing fits.
* The branch pipeline service supporting creating and deletion of branch pipelines.
* A configuration file example.
* A demo setup that shows how useres of the specific tool-stack can run this in their organizations.
