---
layout: post
title:  Job DSL'ification!
author: Thierry Lacour
---

__Enabling *Jenkins jobs as code* through adding support for Jenkins Job DSL__{: .inverted}

__With the rising popularity of the [Jenkins Job DSL](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin), used to easily configure Jenkins jobs without having to wade through the UI swamp, we have decided to add support for the DSL in our plugins.__

Now you don’t have to rely on the bombastic `configure` block to add our plugins to your Jenkins Job DSL scripts.

Here’s a short and sweet example of the result, showing off how to fully configure for instance the [Pretested Integration](https://wiki.jenkins-ci.org/display/JENKINS/Pretested+Integration+Plugin) for a job:

    job("myJob"){
      wrappers{
        pretestedIntegration(
          'SQUASHED',
          'master',
          'origin
    )}}

Pretty neat, huh?

For documentation on how to configure our plugins using the Jenkins Job DSL, please refer to the wikis of the individual plugins. Efforts will be made to move the documentation to the

[Jenkins Job DSL GitHub Wiki](https://github.com/jenkinsci/job-dsl-plugin/wiki), where the bulk of the information regarding the Jenkins Job DSL can be found.

Jenkins Job DSL support has been added for the following plugins:

* [ClearCase UCM](https://wiki.jenkins-ci.org/display/JENKINS/ClearCase+UCM+Plugin)
* [CodeSonar](https://wiki.jenkins-ci.org/display/JENKINS/CodeSonar+Plugin)
* [Config Rotator](https://wiki.jenkins-ci.org/display/JENKINS/Config+Rotator+Plugin)
* [Dr. Memory](https://wiki.jenkins-ci.org/display/JENKINS/drmemory+plugin)
* [Logging](https://wiki.jenkins-ci.org/display/JENKINS/Logging+Plugin)
* [Memory Map](https://wiki.jenkins-ci.org/display/JENKINS/Memory+Map+Plugin)
* [Pretested Integration](https://wiki.jenkins-ci.org/display/JENKINS/Pretested+Integration+Plugin)



_Let's not be careful out there - go play!_
