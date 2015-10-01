---
layout: post
title:  Prepping Pretested Integration Plugin
author: Mads Nielsen & Lars Kruse
---

**To ease usability the credentials already setup for the Git plugin is now planned reused in the Pretested Integration plugin.**{: .inverted}

__The Pretested Integration Plugin has grown to becoming a great success, more and more people have  joined the bandwagon and are now implementing an automated *benevolent dictator governance model* ...or at least a guaranteed pristine master branch.__

The Pretested Integration plugin is designed to mimic the *benevolent dictator governance model* which in a few words is based on the conceptual idea that you have *read* access to your master branch, but you do not have write access to it.

You will trust a benevolent dictator - or in our case a willing serf - to test if your commit meets the toll-gate criteria for entering into master, and if it does then it will all happen automatically.

Obviously this approach requires that the willing serf - here impersonated by the Pretested Integration plugin has write access to the origin clone.

Currently the credentials for the Pretested Integration plugin has been setup simply by uploading public SSH key for the account running the Jenkins job. This seems good-enough in the early days.

But since Pretested Integration plugin is most often used in conjunction with the Git plugin, and the Git plugin already exploits the credentials plugin a lot of uses gave us the feed-back, that they we confused (as in *not impressed*) by the kind of hand held configuration.

A more obvious approach is to re-use the credentials you’ve punched in to  authenticate against a git repository in the Git plugin.

In order for Pretested Integration plugin to utilize the credential plugin are required to cease the use of the Git CLI implementation to an implementation that uses the GitClient plugin for all git operations, but it turned out that not all git features we used was implemented in the GitClient plugin.

So as a prerequisite for the desired swap to the credential plugin we have added the *--squash *option when merging as well as the ability to merge without implicitly committing to the GitClient Plugin.

* [https://github.com/jenkinsci/git-client-plugin/pull/169](https://github.com/jenkinsci/git-client-plugin/pull/169)

* [https://github.com/jenkinsci/git-client-plugin/pull/185](https://github.com/jenkinsci/git-client-plugin/pull/185)

The pull requests have been accepted!

Next up it to actually implement the authentication based on the Credentials plugin. It’s on the sprint log!
