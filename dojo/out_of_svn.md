---
layout: dojo
title: Out of Subversion
---
### Exercise - Out of Subversion
__Present a plan in which you lay-out the tasks that you will recommend for a successful migration from subversion to Git and from CruiseControl to Jenkins CI. Also touch briefly on potential pit falls and road blocks.__

A company has been working on their software product for more than 5 years. It is stored in Subversion and their nightly builds are orchestrated by CruiseControl. The company is considering to migrate to Git and Jenkins CI and would like to see a rough lay-out of a plan for a migration. 

This is what we know about the setup:

* The system architecture is still quite monolithic and uses mostly static dependencies. But an important focus has been initiated to move towards a more component based architecture with individually releasable components and dynamic dependencies.
* Branches in Subversion are mostly used to reflect product releases. Merges back to trunk are painful and therefore rare.
* The development team is spread across three sites.
* Binaries are sometimes also checked into the repository, not for every single build, but for all release candidates that are shipped off to the manual testers.
* Checking out the entire repository will create a workspace of nearly 9Gb. Therefore developers usually only checks out smaller parts of the repo in their workspaces.
* There are some examples of utilization of externals (sub-repositories).
* The team uses CruiseControl to orchestrate their nightly build. And that is literally what they are; _nightly_. They have _one_ build that runs for about 4 hours every night.
* The rate between success and failures on the nightly build is roughly 50/50.
* CruiseControl is not used for nothing else. 
* Only the Build Manager and a few trusted developers have modify rights to CruiseControl.
* The build scripts that run at CruiseControl utilizes Subversion CLI quite heavily.

Now imagine that it's your job to present a plan for migration from  Subversion to Git and from CruiseControl to Jenkins CI.
