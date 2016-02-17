---
layout: post
title: Rewriting history - and other aliases
author: Lars Kruse
---

__Since the pretested integration commit now supports that well-prepared development branches with just one single commit are being merged (as opposed to squased) and the commit message is reused, it should really encourage developers to actually rewrite the history on their development branch to be exactly right. This approach improves the readability of the git history and at the end of the day contributes to better documentation of work process.__

This recipe will go through the process of rewriting history and reveal a few  git aliases that you can set up to greatly improve efficiency in general.

## The typical use case

Imaging that the typical work flow for a developer is similar to this one described here - indented bullets are optional:

* Create new local branch for the assignment
* hack + commit
  * hack hack + commit
  * ...
  * Rewrite your local not-delivered history to just one single commit
* Push to a `ready/*` branch
* End of life for your local branch - don't use it any more
  * Unless your push is rejected and you need to fix something

## Optimizing the workflow using git aliases

Now that the typical work flow is established you'll find yourself doing the same series of git commands over and over again and since we're CoDers we obviously want to automate these.

Git has build in support for aliases.

To set an alias in git you can either use the `git config --global` command or simply edit the `.gitconfig` in your home directory.

An obvious one to start with is to shorten `checkout` to just `co` it can be done like this:

    >git co master
    git: 'co' is not a git command. See 'git --help'.
    ...
    >git config --global alias.co checkout
    >git co master
    Switched to branch 'master'

The command `git config --global alias.co checkout` writes the key/pair value in the `[alias]` section of  your `.gitconfig` file which now contains:

    [alias]
	    co = checkout

If you want to add aliases directly in the `.gitconfig` file you can run the command `git config --global --edit`  and if you would rater want to use another editor than the default (vi). You can change it - in the `.gitconfig` file of course.

I use the Atom editor so I did:

    git config --global core.editor atom


### Branch tree from command line

I like using git from my command line and I often like to glance at the branch tree to see the context I'm working in.

I have create and alias for `tree` that shows the following tree

![Tree sample](/images/blog/tree-sample.png){: .stdcenter }

The tree is made from a pretty-formated output from the `git log` command. The alias is this:

    [alias]
      tree = log --graph --full-history --all --color --date=short
             --pretty=format:\"%Cred%x09%h %Creset%ad%Cblue%d %Creset
             %s %C(bold)(%an)%Creset\"

(I've added a few newlines and indents above to make it readable, if you copy it to you `.gitconfig` file is _must_ be a one-liner.)

### Squash you local branch before pushing it

Imagine that you have done several commits to your local dev branch and now you're ready to deliver and you want to squash them in to just one single commit - containing all your accumulated changes on the past 3 commits.

Let's say that I'm on a `lak` branch and I have done three commits locally since I branched out from `master`. My branch tree looks like this:

    *       5c74eb3 2015-10-24 (HEAD, lak)  Done, closing #24 (Lars Kruse)
    *       3c6fd7c 2015-10-24  fixed #24 (Lars Kruse)
    *       bf31f68 2015-10-24  working on #24 (Lars Kruse)
    *       35fadec 2015-10-18 (origin/master, master)  hww on live broadcasting (Lars Kruse)

My index and workspace are clean:

    >git status
    On branch lak
    nothing to commit, working directory clean

In other words I'm ready to deliver - I just need to squash the last three commits into just one.

Instead of actually _squashing_ anything I'm just doing a soft reset of my branch, so the accumulated changes of the past three commits are rolled back added back to the index.

Like this:

    git reset --soft HEAD~3

This is so simple that I actually haven't created and alias for this. And I always analyze my branch tree before I do it.

But I have created and alias which I have called `commit-again` which allows me to reuse the commit messages from the commits I just reset. I just have to run `git commit-again` and I get this:

    >git tree -2
    *       3994946 2015-10-24 (HEAD, lak)  Done, closing #24 (Lars Kruse)
    *       35fadec 2015-10-18 (origin/master, master)  hww on live broadcasting (Lars Kruse)

And by listing the full commit message of the last commit it's obvious that it's a multi-line commit message, created from a concatenation of the previous commits, with the most resent one on top:

    >git log -1
    commit 39949465c40844d83bd5ee2013a7b68e508fa9d7
    Author: Lars Kruse <lak@praqma.net>
    Date:   Sat Oct 24 18:33:24 2015 +0200

        Done, closing #24

        fixed #24

        working on #24

My alias for the `commit-again` looks like this:

    [alias]
	    commit-again = !git commit -m\"$(git log --format=%B  HEAD..HEAD@{1})\"

## Now for the deliver

At this point I just want to deliver, meaning the I want to push it to a `ready/*`  branch - since that how I've setup the process using the [Pretested Integration Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pretested+Integration+Plugin){: target="pretest"} in Jenkins. And hopefully I don't have to use this branch ever again, but I still think it's a little premature to just delete it, because if something goes wrong during my automated integration, or if I'm rejected, then I still want easy access to this branch to fix it.  So for now I'll just rename it to `delivered/lak`.

I have an alias called `deliver`for this purpose.

    >git deliver
    ...
    * [new branch]      lak -> ready/lak

And my branch tree is updated to:

    >git tree -2
    *       3994946 2015-10-24 (HEAD, origin/ready/lak, delivered/lak)  Done, closing #24 (Lars Kruse)
    *       35fadec 2015-10-18 (origin/master, master)  hww on live broadcasting (Lars Kruse)

The `lak` branch is gone:

    >git branch
    * delivered/lak
      master

It has been renamed to `delivered/lak` and if I wanted I could even reuse the name `lak` for a new branch.

The alias for the `deliver` looks like this:

    [alias]
       deliver = "!BRANCH=`git symbolic-ref --short HEAD`; REMOTEBRANCH=ready/$BRANCH; git push origin $BRANCH:$REMOTEBRANCH
       && git branch -m delivered/$BRANCH"

Occasionally you want to clean out all your delivered branches - the `git branch` command doesn't support wildcards but you can do like this:

    git branch | grep 'delivered/' | xargs git branch -D

And as you guessed, it's also brought to you as an alias:

    [alias]
      purge-all-delivered = !git co master && git branch | grep 'delivered/' | xargs git branch -D

### Start new task all over again

When I want to start on a new task I usually want to:

* Fetch and prune from origin
* Update my local `master` to the `origin/master`
* create a new branch coming off `master`

I have create an alias for that which I called `new-task` it takes just one parameter which is the name of the new branch I want to work on. Like this:

    >git new-task fix-font

The alias for that looks like this:

    [alias]
      new-task = !git fetch origin --prune && git co master &&
      git merge origin/master && git checkout -b

...and now I can start hacking again on the new task

### All aliases
If you want to use `co`, `tree`, `commit-again`, `new-task` and `deliver` then I've listed then all together below as one-line commands as required in the `.gitconfig` file.

Simply copy the content and paste into the `[alias]` section.

__[alias]__

    co = checkout
    tree = log --graph --full-history --all --color --date=short --pretty=format:\"%Cred%x09%h %Creset%ad%Cblue%d %Creset %s %C(bold)(%an)%Creset\"
    commit-again = !git commit -m\"$(git log --format=%B  HEAD..HEAD@{1})\"
    deliver = "!BRANCH=`git symbolic-ref --short HEAD`;REMOTEBRANCH=ready/$BRANCH; git push origin $BRANCH:$REMOTEBRANCH && git branch -m delivered/$BRANCH"
    new-task = !git fetch origin --prune && git co master && git merge origin/master && git checkout -b
    purge-all-delivered = !git co master && git branch | grep 'delivered/' | xargs git branch -D


Happy hackin'!
