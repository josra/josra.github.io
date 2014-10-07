---
layout: post
title: Long-lived development branches
author: Lars Kruse
---

This recipe explains how you can reuse a development branch after you have delivered and integrated it using the squashed strategy. The issue here is that the squashed commit on the integration branch is detached from your development branch, so Git doesn't know that 
it's safe to continue working on your development branch and deliver again. It will complain and say that you need to merge the integration branch in first.
 
 
### Getting ready

This setup mimics what the Pretested Integration Plugin does when squashing integrations.

You can take the code below and run it directly into your shell.

    # Setup a small git repo to represent origin
    mkdir lab                                                 
    cd lab
    mkdir longlivedbranch
    cd longlivedbranch/
    echo foo > foo.txt
    git init
    git add .
    git commit -m "initial"
    cd ..                                       

    # Clone it to represent a a development clone              
    git clone longlivedbranch longlivedbranch-dev
    cd longlivedbranch-dev/

    # branch to a development branch and make a few commits
    git checkout -b my-dev
    echo changed > foo.txt 
    git commit -am "changed foo.txt"
    echo changed again > foo.txt 
    git commit -am "changed foo.txt again"

    # Push your changes to a "ready" branch on origin 
    git push origin my-dev:ready/my-dev

    # In origin squash content of dev branch onto master and clean up
    cd ../longlivedbranch
    git checkout master
    git merge --squash ready/my-dev
    git commit -m "Integrated ready/my-dev"
    git branch -D ready/my-dev
    
    cd ../longlivedbranch-dev/


At this point you have two commits on your `my-dev` branch in your local clone which are delivered as just one squashed commit to the master.

### The problem in a nut shell

If you continue working on `my-dev` and then deliver again - Git will get mad at you. The merge in line #5 below will fail:

    
    echo new undelivered change > foo.txt 
    git commit -am "3rd change in foo.txt"
    git push origin my-dev:ready/my-dev
    cd ../longlivedbranch
    git merge --squash ready/my-dev
    git commit -m "Integrated ready/my-dev"
    git branch -D ready/my-dev


The reason is that git will squash `my-dev` up to last common ancestor and that means that you are trying to deliver your two already-delivered commits again.

### How to do it

Before you continue to reuse your `my-dev` branch you have to sync it with the new commit on `origin/master`

You should simply do this by merging (while having `my-dev` as the checked out branch)

    git pull origin master

if you do this first, you'll see that the running the commands [listed above](#the-problem-in-a-nut-shell) will work just fine.

If you are a perfectionist that's bothered by the fact that using `pull` doesn't 

* Clear out your dangling `ready/*` branches
* Doesn't sync your local `master` with `origin/master`

Then the following commands will also allow you to reuse the `my-dev` branch and in the process updating the picture to perfect:

    git fetch origin --prune
    git checkout master
    git merge origin/master
    git checkout my-dev
    git merge master 

### Watch out

Please note, that even if you might be fond of using `rebase` rather than a plain `merge` or `pull` it would be very wrong to do in this situation.

First of all because `rebase` rewrites your history and you already made a delivery. But also simply because running the rebase would fail.

The following commands will fail:

    git fetch origin
    git rebase origin/master

The reason is the same as before: You are using a squashed merge. It's detached from it's original context (the `my-dev`branch), so essentially the rebase will start a 3-way merge and since you implicitly are trying to re-apply the changes already in the 2 original commits, you'll get a merge conflict error.




