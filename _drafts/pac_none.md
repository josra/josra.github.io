---
layout: post
title:  PAC - supports "none"
author: Mads Nielsen & Lars Kruse
---

**The _Praqmatic Automated Change log _ (PAC) generates a change log based on the task references found in commits. The change log can be populated with data from your task management system such as status, titel and a special _release note_ attributes.**

PAC is designed to be an integrated part of your continuous delivery pipeline and the change log becomes a valuable artifact that documents changes between releases like a manifest.

It is simply executed with two commits as parameters; PAC then compiles the accumulated list of commits in the span and for each of them traces back to the task in the integrated task management system where it captures task atributes and descriptions and and the information to the final change report.

## New features in release XX

PAC was recently released with the feature that allows it to generate the report solely based in information natively available in Git - without any integration to a task management system at all.

PAC is written in Ruby and often used for within a Jenkins job. This required Ruby to be installed on the Jenkins slave which seemed a bit impractical. Therefore, in the same release, we increased the PAC availability, simply through providing a Docker image that wraps all the setup needed to run PAC.

Usability was also improved through simply listing all commits in the span between two commits used as start (not included) and end (included). In the frevious version the listing was filtered based on a regular expression, which essentially was due to a short-cut approach in the early proof-of-concept phase.

The total compliance list of PAC now includes

DVCS:

* Git

* Mercurial

Task Management Systems

* Trac

* Fogbugz

* *None* (uses the commit message)

## Additional fixes in this release

* Missing commits in reportChange the default git-commit listing (shortest-path commit/undefined) to explicit list all commit is all git tree paths - despite timing and order of the commits

* PAC-Report now shows 'since' commit ( usually last release )Discard the commit we actually ‘walk’ back to. This is usually the previous release itself and hereby it should not be listed. It showed after implementing the "Show all commits…".  

**Ressources:**

* Get PAC and read the documentation here: [https://github.com/Praqma/Praqmatic-Automated-Changelog](https://github.com/Praqma/Praqmatic-Automated-Changelog)

* Check out the roadmap for PAC in the [Trello board ](https://trello.com/b/0yJy3IlO/pac-praqmatic-automated-changelog)

* The [Docker image ](https://github.com/Praqma/Praqmatic-Automated-Changelog/blob/master/README.md#using-the-praqmadocker-pac-container)that wraps PAC.
