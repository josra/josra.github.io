---
layout: post
title:  Prepping Pretested Integration
author: Mads Nielsen & Lars Kruse
---

_To ease usability of the Pretesed Integration plugin, the credentials already setup for the Git plugin will be reused in the Pretested Integration plugin._{: .inverted}

**The Pretested Integration Plugin has grown to becoming a great success, more and more people have joined the bandwagon and are now implementing an automated _benevolent dictator governance model_ ...or at least a guaranteed pristine master branch.**

The Pretested Integration plugin is designed to mimic the *benevolent dictator governance model* which in a few words is based on the conceptual idea that you have *read* access to your master branch, but you do not have write access to it.

You will trust a benevolent dictator - or in our case a willing serf - to test if your commit meets the toll-gate criteria for entering into master, and if it does then it will all happen automatically.

Obviously this approach requires that the willing serf - here impersonated by the Pretested Integration plugin has write access to the origin clone.

Currently the credentials for the Pretested Integration plugin has been setup simply by uploading public SSH key for the account running the Jenkins job. This seems good-enough in the early days.

But since Pretested Integration plugin is used in conjunction with the Git plugin, and the Git Plugin already exploits the credentials plugin a lot of user gave us the feed-back, that they were confused (as in *not impressed*) by the kind of hand held configuration.

A more obvious approach is to re-use the credentials you’ve punched in to authenticate against a git repository in the Git plugin.

In order for Pretested Integration plugin to utilize the Credentials Plugin, it was required to cease using Git command line calls in the implementation, and refactor to use only the GitClient Plugin for all git operations. Just not not all git features we needed to use was implemented in the GitClient Plugin.

So as a prerequisite for the desired swap to the Credentials Plugin we have added the `--squash` option when merging, as well as the ability to merge without implicitly committing to the GitClient Plugin.

* [https://github.com/jenkinsci/git-client-plugin/pull/169](https://github.com/jenkinsci/git-client-plugin/pull/169)
* [https://github.com/jenkinsci/git-client-plugin/pull/185](https://github.com/jenkinsci/git-client-plugin/pull/185)

Both pull requests have been accepted! So the next release of the Git Plugin is expected to contain the features in the GitClient that we will be utilizing. Next up is to actually include the authentication based on the Credentials Plugin in the Pretested Integration Plugin. It’s in the making and we hope top be able to release as soon as next version of the Git Plugin is out!
