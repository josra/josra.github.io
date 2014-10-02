---
layout: post
title: CoDe:U Git Flow Cookbook
---

## A Succesful Branching Strategy

<A reference to @nvie's flow>

## The 10 Git Commitments

<A list the commitments, a 10-bullet strategy - easy to communicate>

### The project integration branch is where developers continuously integrate (CI)


### The project integration branch is master


### All integrations onto an integration branch must pass an automated toll-gate


### Only trivial merges are allowed onto the integration branch


### Every successful integration onto master kicks off the pipeline

### 
The integration branch is always aiming for the next release, anything else is kept somewhere else until it’s due

### 
Any push to a centralized repository, that contains a commit on a development branch matching the naming convention triggers an automated integration

### 
Some development branches may be tied to maintenance branches rather than the integration branch

###
 All integrations onto promotion branches are automated 

### 
Any given promotion branch can only have one contributor


