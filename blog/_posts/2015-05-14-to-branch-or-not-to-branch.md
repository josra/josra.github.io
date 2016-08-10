---
layout: post
title:  To branch or not to branch...
author: Lars Kruse
tags:   [Flow, Git, Branching strategy, Jenkins CI]
---


## Dear Steve!

**Thanks for you long reply!**

...before I continue this post I just want to set the scene so newcomers can follow along:

* At the Continuous Delivery and DevOps conference in Oslo 2015 a debate ignited. The dispute was whether branching and automated integration is good or if _trunk based_ development is better. The dispute caught fire on twitter as summarized in this [blog post by Seb Rose](http://claysnow.co.uk/continuous-delivery-conversations/).
* The debate manifested itself around a the blog about the [automated Git flow by Josra](http://www.josra.org/blog/An-automated-git-branching-strategy.html) which Steve Smith gave it a bit of rough.
* This post is a response back to [Steve's comment](https://plus.google.com/109269863739305725689/posts/Nh4GeyYoDdQ). Just to get the talk going.
* Seb Rose arranged a [Google Hangout on Air](https://plus.google.com/u/0/hangouts/onair/watch?hid=hoaevent/c1mbqj6b93o6stcbl2qkdt8udmc&ytl=30yN4hefrt0&wpsrc=yta){: target="\_blank"} Monday May 18th where he together with Mike Long, Olve Maudal, Dave Farley and myself, Lars Kruse debated the issue. Unfortunately Steve Smith couldn't make it to the hangout.
* But Steve managed never the less to come up with yet [another lengthy comment](https://plus.google.com/109269863739305725689/posts/EedSSMMiTMy){: target="\_blank"} on the same topic.

So let me start all over again:

## Dear Steve

**Thanks for you long reply!**

I understand that you have a sharp pen and would like to throw a few provocative statements to stir the pot. Fair enough. I'll take the fight.

But to be honest I don't see that your post is as much a criticism of [the automated Git flow](http://www.josra.org/blog/An-automated-git-branching-strategy.html) that I've presented, as it is a statement that you personally are in favor of what you call _trunk based development_ and don't really dig the concepts of branches.

But that too is an interesting discussion, so let's climb onto out high horses and get started.

I've picked on a few of your more bombastic statements - we can go into details later - if we can keep the steam up.

## The easiest branching strategy

@Steve:

>the easiest branching strategy to roll out in an organisation is one that does not require automating, requires minimal branching, and requires minimal merging. That would be Trunk Based Development.

Wrong - the easiest branching strategy to roll out in an organization is one that can be automated. The alternative is that manual processes are required and for what purpose? Why on earth would a software team rely on manual work, if the process is of such a nature that it _can_ be automated? That seems like a waste of time?

In terms of branching; in Git we talk about branches we simply refer to it as a named head; It's a mechanism that allows you to have more than one head within the same repository. If you are in Git, developing on `master` you will create a clone of the origin, work there and push your changes back. But you'll have the same situation: In your local clone your changes will be on `master` and your integration branch will be on `origin/master`. That's two branches for ya! - no matter what you choose to call it.

Naming it after a Subversion oriented approach and call it _Trunk based_ doesn't change the fact that you are indeed working in a private workspace and work will eventually have to be merged to a different scope in the end.

The process that you `pull origin master` and `push origin master` as opposed to using a different branch name doesn't change the fact that in both operations Git will do an implicit merge under the hood.

Even in _trunk based_ development merges may be required, and the merges may fail.

You should avoid merging by the way you organize your development team - not by how you organize your private workspaces or by how you name your branches.


## Build Feature Branching

@Steve:

> I would personally refer to this style of branching as Build Feature Branching

I think I know where you're coming from. It's the doctrine that feature branches are inherently evil because they prevent Continuous Integration. But feature branches are being taking hostage here - it's not the feature branches that are evil - it's the fact that you are not integrating continuously that constitutes the real problem.

We call the branches where developers make their changes "development branches" - and they are exemplified by feature branches, maintenance branches, team branches, bug-fix branches ...or what ever you want to call them. We don't differ - it's not important. To us they are all just branches and they are all integrated automatically.

I'm all in favor for what you call _trunk based_ if the interpretation is that _there can only be one long-lived branch_. This is exactly the foundation of our initial criticism of the _[successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)_; It has two long-lived branches. and for that reason alone the integration process can not be automated.

In the SCM literature this approach with only one long-lived mainline branch is often referred to as "[late branching](http://www.bradapp.com/acme/branching/branch-policy.html)" or in context of product lines it's a "[release train](http://www.scaledagileframework.com/agile-release-train/)". I believe it's the same phenomena you call _trunk based_ only decorated with the postulate that _any other_ branch is evil. The word trunk is derived from Subversion which by default names the integration branch _trunk_, and I agree that in Subversion branches are at least semi-evil. But I wouldn't name anything after Subversion - unless it was something bad of course.

The fact that Subversion doesn't handle branches well, simply doesn't support the conclusion that branches are generically evil.

## Substantial rework is required

@Steve

>I assume using Subversion on Go or Mercurial on TeamCity would require substantial rework, and I would argue a version control strategy should be entirely decoupled from the version control system and build toolchain.

The process is the same regardless if you are using SVN/Go, Hg/TC, ClearCase/Jenkins, Git/Jenkins or whatever tool flavor you fancy.

The fact that it's automated clearly indicates that there is work that needs to be executed and that it should be programmed. True that!

But we have already implemented the automated process for Git/Jenkins in the [Pretested integration plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pretested+Integration+Plugin) and for ClearCase/Jenkins in the [ClearCase UCM plugin](https://wiki.jenkins-ci.org/display/JENKINS/ClearCase+UCM+Plugin). I know of a software development team who implemented the same automated flow in Git/TeamCity and another who's doing it in Git/Bamboo.

I admit that I have never heard of anybody trying to implement this flow in Subversion. But I have heard of many companies who migrated out of Subversion and into Git or Mercurial in order to implement this flow.

What you refer to as _substantial work_ is well rewarded by the time gained from no longer having tedious cumbersome manual processes in your flow. The return of the investment is so fast that I'd rather turn the question around: _"What's not to like?"_


## A re-test is waste of time

@Steve:

>a re-test on master of feature(s) that were already tested on the branch. This is all waste that no customer will ever pay for, and is incompatible with the Continuous Integration/Delivery demand that the codebase always be releasable at any given point in time

When we test on `master` the process is automated. As in _does not require manual work_.  That's cheap!

But you refer to the test on `master` as a _re-test_. It indicates that it's already tested. Manually? That sounds expensive!

You can simply not get in on our `master` unless you code is actually working. Our `master` is guaranteed to be pristine.

It's impossible to break the build.

## Incompatibel with Continuous Integration and Continuous Delivery

@Steve:

>this version control strategy is probably incompatible with Continuous Integration - and therefore probably incompatible with Continuous Delivery. [...]Continuous Integration means every developer on the team is committing to master at least once a day - it is a shared mindset of collaboration - and 'An Automated Git Branching Strategy' is unlikely to lead to that.

Why should this flow in any way prevent a developer to integrate as often as desired? The way we use this flow, there's nothing preventing the developer from running:

    git push origin anybranch:ready/anybranch

...as often as he likes.

Every time he does it, his changes are automatically integrated into the `master` branch on the origin clone - provided of course that his code meets the development team's criteria for being integrated.

The integration is automated and every successful integration kicks off the continuous delivery pipeline.

That's not being incompatible with CI and CoDe - it's actually closer to defining CI and CoDe.

## Policy enforcement through Quality enforcement

@Steve:

>even if every developer on the team intends to only have short-lived feature branches they all too easily last longer than a day. Those independent branches discourage collaboration, diverge from the shared design, prevent predictable delivery, and periodically cause Integration Hell.

It's really not about the developers _intent_. There's no way the developer can go astray from the chosen path. There is only one way the developer can put code into production and that is to integrate it into the integration branch and see it take a successful ride through the CoDe pipeline.

The developer has no incitement what so ever to keep his code isolated in his private workspace, being the local `master` branch or any other branch makes no difference.

The efficiency of this flow shall not be managed through branches but through project management: Don't put tasks in the sprint that aren't contributing to the upcoming release.

There is no track faster than that.

It's related to the 7th principle of the agile manifest: _"Working software is the primary measure of progress"_. We interpret that quite literally; Either you deliver running code into the integration branch - or you are not contributing, and then you'er probably soon unemployed.

## The benevolent dictator governance model

@Steve:

>The suggestion of pre-commit hooks on master to verify commit integrity is a good one, but the need to run such checks is often a symptom of a) developers not testing their own work b) a slow build and/or c) a build that is hard to revert. In my experience it is better to have a post-build hook that immediately reverts a failed build, along with the delivery of a pink cowboy hat to the offender. This can be automated.

I can't argue against your personal experience. If you believe a pretested integration is only necessary either because the build is slow or because developers don't work responsibly I can only say that my experience is different than yours.

We're using it simply to create transparency and to implement the project's [definition of done](https://www.scrum.org/Resources/Scrum-Glossary/Definition-of-Done). It's the [benevolent dictator governance](http://www.josra.org/blog/An-automated-git-branching-strategy.html#look-ma-no-hands) model, only we implemented it through a willing serf rather than a benevolent dictator. The serf being Jenkins in our case.

Whether you prevent a bad merge from happening by testing it first - or whether you allow it to happen unconditionally and then revert it if the test fails ought to be indifferent. Both scenarios will lead to the same end result. Why be religious about it?

![Pink Cowboy hat](/images/blog/pink-cowboy.png){: .stdright #small} By "a pink cowboy hat" I take it that you are advocating for a blame culture. Our approach is that the pipeline is going to serve as the equivalent of an [andon cord in the Toyota Production System](https://www.youtube.com/watch?v=B_nSvN_L4hc). If a commits break the pipeline, it's the equivalent of somebody pulling the andon. When that happens you're supposed to walk up to him and ask him _"what can I do to help you?"_.

Blame culture is counter productive, you should burn your pink cowboy hat.

## What's is a fast forward merge in git anyway?

@Steve:

>Why on earth does there need to be a 'stable' branch? Why is master not permanently stable? Why does there always need to be a 'release' branch? Why is master not good enough for production releases, with release branches created at a later date if a production defect occurs?

Ohh, but that's because we're using Git magic - all the commits _are_ indeed on `master`!

The term _promotion_ is used to indicate that a commit or baseline has travelled a certain length through the pipeline. For instance `stable` could mean that it has successfully passed a full functional test. `release` could mean that the commit or baseline has been shipped. Feel free to introduce as many promotion branches as you like.

The audit trail that becomes visible from using promotions is often desired and sometimes, if you're working under regulatory rules, it's even required.

In some VCS the notion of promotions is built-in. That is true for ClearCase UCM for instance. But if you're in a VCS that doesn't support promotions natively you will have to add a bit of meta data to control it.

You could tag the promotions? Right!

But you can also use a _[branchy approach](https://www.youtube.com/watch?v=mIgT17R7Cd8)_. And if you are in Git you can even use _fast forward merges_ which provides an even smarter solution. Pay attention to the following commitment in the flow:

* **_Any given promotion branch can only have one contributor_**

`master` always delivers to `stable`. `stable` always delivers to `release`. You can name your promotion branches what ever you like, as long as you honor the commitment that any promotion branch can only have one contributor.

This commitment has the consequence that all merges onto promotion branches are effectively fast forward merges (it's true because the target only has one contributor - nothing will ever have to be merged). A [fast forward merge](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) basically means that the underlying data container is unchanged - the SHA1 of the Git commit stays the same the.

![Three headed dragon](/images/blog/3-headed-dragon-3.jpg){: .stdright #small}In a fast forward merge the only thing that changes is that the branch head now points to another - already existing -  commit. In our flow the commits on promotion branches are guaranteed to be on `master` as well. A promotion branch in our flow is merely a _floating label_. It's not a fire-spurting three-headed evil monster branch as you know them from Subversion.

So don't let them scare you.

## There can be only one

In the automated git flow there is only one long-lived branch and that is `master`. Nothing else matters and everything else is automated.
