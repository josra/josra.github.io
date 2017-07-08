---
layout: post
title:  An Automated Git Branching Flow
author: Lars Kruse
---

**The fact that most prehistoric version control systems weren't particularly good at branching and especially not at merging leads to the consequence, that many teams today find themselves in a situation where they have never before merged as intensely as they now do on Git.**

_...A branching strategy is definitely required - **but which one?**_

This flow describes a branching strategy in Git, which is specifically designed to be easy both to automate and to roll out event in large organizations. The flow uses a _branchy_ approach and is not dependent on any particular repository server. It's compliant with all that we've come across; GitHub, GitLab, Stash, Gerrit etc. It is automated purely by using  [Jenkins CI](http://www.jenkins-ci.org) "Our favorite automation platform" and two plugins: The standard [Git  plugin][git-plugin] and the [Pretested Integration Plugin][pretested-integration-plugin].

You can see this flow as an optimized and automated version of the wide-spread - but in our opinion - far too complex model described in ["A successful branching model"](http://nvie.com/posts/a-successful-git-branching-model/) by @nvie.

__The CoDe:U Git Flow looks like this__

![CoDe:U Git Flow](/images/blog/codeu-git-flow.png){: .stdcenter}

The flow is designed to be easy to communicate and teach, so we've made a handful af visuals to make our points. We have borrowed @nvie's stroke in our graphics and credit him according to the _Creative Common_ license.

## A Branchy Approach

The approach we use is _branchy_.

By _branchy_ we mean that the underlying meta data that drives the model and describes the state and transitions is based purely on branches. This is done because Git is distributed and therefore relies on _clones_ for synchronizing and a clone is - exactly as the word describes; a _clone_ - a copy of something else.

Some technologies use different clones within the same repository to define different states or promotions. We believe that this approach defies the purpose of a clone entirely. Consequently we also believe that the states, promotions and transitions must be defined by metadate that can freely be synchronized between clones as branches.

One might argue, why not use _tags_ or _notes_ to carry metadata in Git, that's certainly an approach that others have done before us.

Well, given that the most typical daily operations in Git are geared towards branches, using branches seems like the less intrusive approach; you don't have to configure anything special in your repositories or configurations to make this setup work.

But more importantly we come from a background with very strong branching models, we're really good at branching strategies, so juggling branches seems just natural to us.

## Look Ma'! No Hands!

The flow that we advocate is some times referred to as _late branching_, another term frequently used is _release train_, these concepts assumes that merging branches implicitly means some kind of promotion. In general, the target branch is supposed to have a higher quality stamp, than the source branch. Such a transition calls for a kind of formal verification procedure.

It's a flow that is well know from the _benevolent dictator governance model_ that often rules in Open Source communities:

> A contributor who's not a core committer can read code and suggest changes, but can not deliver them due to not having write access to the sacred core. Instead the benevolent dictator and his trusted lieutenants accept pull requests, and if they verify the contribution it's merged in.

We believe that this flow is good; that merges are _deliveries_ and they need to be verified. On the other hand we think that any verification process ought to be automated, so we have replaced the benevolent dictator with a willing serf: Jenkins CI.

Our flow is automated by the [Pretested Integration Plugin][pretested-integration-plugin]. You're just supposed to implement your definition of _done_ whether that might be an integration or a promotion, and Jenkins will execute it for you.

## The 10 Git Commitments

The original idea behind these commitments was that the flow should specifically be easy to distribute and roll out within an organization. So we have fitted the underlying concept into just ten simple principles - which we refer to as:

__The 10 Git commitments__

* The project integration branch is where developers continuously integrate (CI)

* The project integration branch is *master*

*  All integrations onto an integration branch must pass an automated toll-gate

* Only trivial merges are allowed onto the integration branch

* Every successful integration onto master kicks off the pipeline

* The integration branch is always aiming for the next release

* Any push to a centralized repository, that contains a commit on a development branch matching the naming convention triggers an automated integration

* Some development branches may be tied to maintenance branches

* All integrations onto promotion branches are automated

* Any given promotion branch can only have one contributor
{: .stdcenter style="background:lightgrey;"}

Let's go through these principles one at a time.

#### The project integration branch is where developers continuously integrate

![master branch](/images/blog/master-branch.png){: .stdright style="width:120px;"}

This commitment is really the core concept of Continuous Integration: It's a technique for software developers to share work and collaborate as a team.

The integration branch is where all work that might have been done in parallel becomes sequential. Working in parallel for too long time only makes it harder to come together again, that's why integration should happen, not just frequently or occasionally but _continuously_.

Some agile beliefs say that a task can not span more than a days work, simply because a developer should be expected to deliver some piece of increment of _running code_ to the code base at least once every day.

We're honoring the [7<sup>th</sup> principle](http://www.agilemanifesto.org/principles.html) of the agile manifesto:

>Working software is the primary measure of progress

Having a component oriented system architecture and organizing work efforts around roles related to these components makes continuous integration so much (_much!_) easier: Even in large and complex code bases you can avoid file merges all together using this approach and since components have interfaces they are so much easier to integrate - but that's a different story all together.


#### The project integration branch is master

The `master` branch has special meaning in Git. It's the default integration branch, and it's the only branch that exist after you're run a `git init`.

You can change what appears to be the default branch to something different than `master` using [`git-symbolic-ref`](https://www.kernel.org/pub/software/scm/git/docs/git-symbolic-ref.html) but it isn't consistent across clones so why go against the convention?

This commitment is also a raised finger against the practice described in @nvie's Git-flow, where he describes two ever-lasting [main branches](http://nvie.com/posts/a-successful-git-branching-model/#the-main-branches): `master` and `develop`.

A true release train only have _one_ never ending branch and in Git that is `master`.

#### Only trivial merges are allowed onto the integration branch

By trivial merge we mean one that doesn't require human intervention. It's a three-way-merge were no lines in either contributing file conflicts.

This commitment guarantees that any merge conflict that ever occurs, in the entire code base, will always have to be resolved when `master` is merged into a development branch, and never the other way around.

Developers will have to, either organize themselves around roles where they do not fight over the same pieces of code, or they will have to stay in sync with what's happening on `master`, either through merges or rebases.

This means that integrations can be automated, since they do not require human intervention. So this is one of the core features that we implemented in [Pretested Integration Plugin][pretested-integration-plugin]

#### All integrations onto an integration branch must pass an automated toll-gate


![automated integration](/images/blog/automated-integration.png){: .stdright style="width:145px;"}

This commitment states that the verification used to define the toll-gate criteria for what can - or can not - reside on the integration branch is not the be trusted by humans.

You will simply have to _implement_ your toll-gate criteria.

This is the right time to introduce the [Pretested Integration Plugin][pretested-integration-plugin] which I've mentioned a few times already and the way it collaborates with the standard [Git plugin][git-plugin].

But first a recap on the four phases of a Jenkins job:

* Poll phase
* Pre-build phase
* Build phase
* Post-build phase

The poll phase is rare and special. Rare because SCM plugins are the only ones that have access to a poll phase and special because in the poll phase the job is actually not instantiated yet - It's like a class method. The purpose of the poll phase is to determine if a new job should be put in the Jenkins job queue.

The standard [Git plugin][git-plugin] spans the poll phase - if you're using polling -  and the pre-build phase. It uses the pre-build phase to establish the workspace on the branch-specifier you've configured, or the one that it passes as parameter.

In our example of how the branch specifier is configured in the Git plugin we have used `origin/ready/**`to have it be triggered by any branch pushed to `origin` prefixed with `ready/`.

![Git plugin branch specifier](/images/blog/git-branch-specifier.png){: .stdcenter}

So in other words, naming your branch so that it matches our agreed keyword triggers an attempt to integrate it. If you want to push something to `origin`, not necessarily to raise a flag for integration, but maybe to share the branch with a colleague - simply name it something different and the integration won't be triggered.

The [Pretested Integration Plugin][pretested-integration-plugin] uses a _build wrapper_ and a _publisher_. It means that it has a footprint in both the pre-build phase and the post-build phase. It takes over immediately after the standard Git plugin has finished establishing the workspace, but before the actual build phase kicks off, in other words, while we're stil in the pre-build phase of the job.

We're using the standard [Git plugin][git-plugin] to trigger the build, but we're not really interested in the workspace we get, where the branch matching the branch specifier is checked out. See, that's our source, not our target.

So the [Pretested Integration Plugin][pretested-integration-plugin] will checkout the integration branch which is the branch specifier for this plugin and then simply merge in the branch which originally triggered the SCM plugin. The merge will be committed.

Now we have a workspace with the integration branch checked out and the development branch merged into it. Now we just need to verify it. This concludes the pre-build phase.

The build phase is really the test that shall verify it, this is where you enter the scene - it's your toll-gate criteria, you'll have to define what should happen here. We recommend that you keep the toll-gate criteria short. You'll get plenty of time to do more verifications later.

Ask yourself:

 \- _"What's the minimum criteria that my colleagues should meet in order to share code on the integration branch?"_

 And the answer is probably in the lines of:

 \- _"That they don't break the build!"_

In a modern world that translate to something like; the code can build and the unit tests can run without errors.

After the build phase is done, control is once again handed over to the [Pretested Integration Plugin][pretested-integration-plugin] to determine if we like the merged workspace or not.

If the build phase was successful, we push the changes to `origin` and delete the source branch. If the build failed we will do ...absolutely nothing.


#### All integrations onto promotion branches are automated

![Automated promotions](/images/blog/automated-promotions.png){: .stdright style="width:300px"}

The principle that verifications are automated and implemented as Jenkins jobs apply, not only for integrations, but even for promotions. A promotion in this terminologi means that you are harvesting the commits that can be verified to a certain level onto promotion branches.

As an example it could be that you define the promotion `stable` to mean that a commit can be deployed to a production-like environment and a regression test has run successfully. And maybe further that `release` means that it has left your incubator and is now being used somewhere outside your organization.

The exact definition of a promotion is given by the next commitment.

#### Any given promotion branch can only have one contributor

If you're sharp, you may have noticed that [earlier](#the-project-integration-branch-is-master) I raised a critique of @nive for having more than one ever-lasting branch in his flow.

Aren't promotion branches ever-lasting too?

Well this commitment is the one that saves me from being hit by my own argument.

On the contrary of an integration branch which can be _fed_ from many different development branches, a promotion branch will always have the same source.

In our example `master` is the source for `stable` and then `stable` is the source for `release`.

In Git terms this means that _any_ commit on a promotion branch will be _fast-forwarded_ there from somewhere else. When something is fast-forwarded in Git it means that no new commit is actually created. The branch head of the currently active branch will be set to point to an already existing commit which already exist on the source branch.


![Promotion branches collapsed](/images/blog/promotion-branches-collapsed.png){: .stdright style="width:175px;"}

The picture to the right actually shows the same branches and tags as the previous picture, only this time they are collapsed to depict the way Git actually deals with it internally as opposed to the previous which showed how we think about it conceptually.

In reality there is only _one_ ever-lasting branch and that's `master`. Any commit on any promotion branch is already on `master` too. Promotion branches are basically just floating labels.

Some of these stages you might want to capture as they flow, then you simply tag them as well, but that is your decision entirely, it's not part of our flow.

#### The integration branch is always aiming for the next release

In other words: _"anything that is not aiming for next release should be kept somewhere else until its due."_

This commitment is also partially a critiques of @nvie's flow in which [he says about release branches](http://nvie.com/posts/a-successful-git-branching-model/#release-branches) that they are branches you create when:

> ...develop (almost) reflects the desired state of the new release.

and they are used for:

> ...last-minute dotting of i’s and crossing t’s.

This way of thinking about branches that @nvie advocates here, reflects that the software development process is divided into phases, and that we have a _stabilization phase_ just prior to each release. The stabilization phase is supposedly only relevant to some, but not all, of the team members and therefore the process is moved elsewhere.

We believe this way of thinking defies the purpose of a Continuous Delivery pipeline which we advocate and which essentially implements our _definition of done_.

From a practical point of view it's likely, that most shops have setup the pipeline to run on the integration branch, and to move away from it would mean that we should move or copy the pipeline setup too.

Ideally we're all in for that. The concept of _configuration as code_ where you can version control and execute your configurations, to a point where entire pipelines, no matter how complex they are and how many resources they demand to execute, always comes by the click of a button.

But if you don't have that - _yet_. Its more reasonable and efficient that you allocate all you resource to get the release done - and if there really are a few people in the team who aren't contributing to the upcoming release, and who would jeopardize the release if they pushed; ask them to kindly hold their pushes back for a while.

#### Every successful integration kicks off the pipeline

I already touched briefly on the concept of pipelines in the previous section, This is the commitment that explicitly mentions them.

Consider the proverb _"Every commit is a release candidate"_.

A pipeline is the line of related job executions, which all together verifies that your code is done. It's the pipeline that lets you know whether you are indeed done or not. Whether that particular commit was indeed a release candidate or not.

Typically pipelines are implemented as jobs that succeed each other and it only is the first _toll-gate_ job actually triggered by something happening in your version control system. The following jobs are started by the previous job but only if it succeeds.

So it's a chain of events that stops if you're not done. And if it completes succesfully then you know you're done.

Drawn as a state-transition diagram it may look like this:

![Continuous Delivery Pipeline](/images/blog/cd-pipeline.png){: .stdcenter}

This picture is an abstract, in reality each action or station in the pipeline may well comprise several jobs of which only the accumulated successful result will trigger the next step. You decide, it's your pipeline.

This commitment simply states that given that every bit of code belongs to _something_ and _everything_ needs to be verified to some extent, then every commit should kick off a pipeline in order to be verified.

You may argue that the pipeline may become so fat and exhausting to execute that this can't be true.

This is where you'll go and find your _divide and conquer_ hat.

Imagine that you have a component oriented architecture where products are made up of components and we agree that each component and product in there is supposed to be individually releasable. Then consequently each component also have a definition of done and therefore each component has it's own pipeline.

Think Lego!

![Lego Components and Products](/images/blog/Lego-component-product.png){: .stdcenter}

In this picture we have a component: The grey 2x4 Lego block, and we have two products that uses this component: The Millennium Falcon and the Surveillance Helicopter.

How would you verify the Lego block?

Probably by testing that the interface fulfills the specs, that the surface is intact and that there aren't any edges from the molding process.

When you are done with that it becomes inventory - ready to use.

How would you verify the two products that uses the component then?

Well in terms of the grey 2x4 Lego blocks you would probably just simply count if you have the right number of blocks according to the spec.

The concept of having _software as inventory_ is the key here.

Even if you don't do mass productions of software components and even though a component may not even be used in that many different products, you still get the benefit of being able to exploit the fact that given different contexts you'll be using quite different verification methods.

When a component is considered done according to it's specs it becomes inventory - In software development we use artifact management systems for inventory.

Transferring this Lego analogy to software we see that the stations in our abstract pipeline from before split like this:

__Components__

* Semantic verification by building and unit testing.
* Static analysis to gain all kinds of metrics on the level of complexity and technical debt.
* Documentation   

__Products__

* Semantic verification by managing dependencies and linking together.
* Deployment.
* Functional testing - which can span from simple smoke tests based on the actual change set or full regression tests.
* Documentation

_Note: We've released another free, open source plugin for Jenkins CI that can rotate and test your configurations. Have a look at the [Config Rotator Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Config+Rotator+Plugin)._

#### Any push to a centralized repository, that contains a commit on a development branch matching the naming convention triggers an automated integration

![Development branches](/images/blog/development-branches.png){: .stdright style="width:160px;"}

This commitment refers to the previous discussion about benevolent dictators and their trusted lieutenants who rigidly guard the sacred core now simply being replaced by a willing serf that does everything automatically when you raise a flag.

This commitment defines the flag.

The fact that you push something to `origin` that resides on a branch that matches the branch specifier as discussed [earlier](#all-integrations-onto-an-integration-branch-must-pass-an-automated-toll-gate) is all it takes to get the ball rolling.

This concept of using a branch naming convention as the flag also gives you the freedom to do - literally - anything you want outside the naming convention.

There are no rules on how you will name your branches in your local clones. There are no rules saying that you're not allowed to push to `origin` for backing up your local branches or for sharing code with colleagues. You're free to do what ever you want.

Personally I like to have my personal branches having meaningful names indicating what work I'm doing there. Say as an example I have a branch named `multiple-scm` where I'm implementing support for having multiple source control management systems contributing the my workspace in a Jenkins job.

Now imagine that we have a policy in my organization that branches declared ready should be delivered on branch names referring to the case ID in our task management - in this case lets say the case ID is 12224 - meaning that the branch I push should be named `case_12224` prefixed with `ready/` since this is the flag that triggers the pipeline to start.

On my local machine I would simply do

    git push origin multiple-scm:ready/case_12224

If the integration is successful the [Pretested Integration Plugin][pretested-integration-plugin] will delete the `ready/case_12224` branch on `origin` but that doesn't affect me at all - since I still have my local `multipel-scm` branch pristine and intact.

If I synchronize my `multiple-scm` branch with the commit that was added to `master` I can even continue to use my `multiple-scm` branch for more deliveries.

I will show how to do this in the [CoDe:U Git Flow Cookbook]({% post_url /blog/2014-10-02-codeu-git-flow-cookbook %}).

#### Some development branches may be tied to maintenance branches rather than the integration branch

This commitment represents a small capitulation on the concept of pure release trains.

We realize that software isn't just a _going-forward_ discipline. Sometimes when you get a report on an issue and you've fixed it in the most current release of your product, it's not always possible to ask your users or customers to take the fix in by upgrading.

License issues, policies or legal issues may require that you maintain older versions. This is supported in our flow too. We have introduced a branch type called _maintenance branches_.

Seen from the perspective of the `master` branch and the core concept of a release train with only one never-ending branch nothing has changed. Seen from this perspective the maintenance branch is just like any other development branch.

But seen from the perspective of the maintenance branch itself everything is different. It's like a complete micro cosmos, where all the principles that apply to the macro cosmos are applied again in a smaller scale.

So a maintenance branch behaves like the `master` branch where integrations are automated, where you may potentially have promotion branches coming off from it too, and if you do then even the promotions are automated.

You may even tag certain commits to give them certain meanings and you may potentially release to end-users or customers directly from this branch, which obviously indicates that the pipelines are fully implemented on this maintenance branch too - for all relevant components and products.

Just remember that even maintenance branches will have to be integrated on `master` too - the release train is rolling. Catch up!

This completes the picture.

## The CoDe:U Git Flow Cookbook

We're compiling a lot of very practical _how do I..._ information in relation to this flow. It's our ambition that it should be the one compendium you need in order to work efficiently with this flow.

Go there: [CoDe:U Git Flow Cookbook]({% post_url blog/2014-10-02-codeu-git-flow-cookbook %})

__Please throw us some comments!!!__


[pretested-integration-plugin]: https://wiki.jenkins-ci.org/display/JENKINS/Pretested+Integration+Plugin "Pretested integration plugin"

[git-plugin]: https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin "Standard Git SCM plugin"
