---
layout: post
title:  Network of Traces prototype
author: Andrey Devyatkin
---

During the 3rd Josra gathering, we demonstrated the first prototype for the "Network of Traces" (NOT) project.
Our main focus in this project is to address a few important pain points:

* Full traceability for the developer, i.e. as a developer I want to see how my change travels through the delivery pipeline and when it is included into the product so I can take responsibility for my change if it breaks something on its way
* Full traceability for the product owner, i.e. as a product owner I want to know what is included into my product, how long does it take to make a change in a certain area and where are the bottlenecks so I can take appropriate actions


When we started to brainstorm those stories, we asked ourselves: What is a continuous delivery pipeline? How can we represent it?
We see a continuous delivery pipeline as a set of subsequent events that could be represented as a directed acyclic graph, i.e. as a directed graph with no directed cycles.
Simplest example would be

```
work item -> commit -> build -> test -> release/promotion
```

Then our task boils down to extracting info from a pipeline and storing it in an appropriate graph database.
How to do that? There are a few possible ways.

One would be to poll for data from continuous integration server and other data sources.
This way would require API from every component involved as well as create an unnecessary load on those systems.

Another way would be to push data from components to a database.
In this case, we would need to have a possibility to create plugins or execute some snippets of code within a component that would push data to the database.
Such an approach creates quite a tight coupling between components and a database, which would require high enough availability for a database in order to avoid data loss.

Eventually, we ended up with the third solution inspired by Internet of Things protocols based on a publish-subscribe model.
Why Internet of Things? We see a lot of similarities - a continuous delivery pipeline consists of things speaking to other things by generating events.
VCS hosting solutions generates events about source code changes, work item management system generates events about work items, artifact management systems about new build artifacts and so on.
We just need to add middleware where all those systems can publish those events and then we simply subscribe to them with a tiny client that would write those events for us to a database enabling further visualization solutions.
A publish-subscribe model has its advantages and provides a few interesting bonus possibilities such as: 

* Possibility to have end to end traceability even if continuous delivery pipeline stretches through multiple sites and involves different CI engines/VCS hosting solutions/Artifact management systems and so on
* Possibility to have loosely coupled infrastructure components. That would allow us to swap some of them with new tools/technologies and plugin more steps without extensive reconfiguration, i.e. middleware will provide abstraction from an actual implementation of every service allowing us to change them without global effect on the whole system.
* Provide possibility to build real-time visualization and fully event driven pipelines
* Apply machine learning algorithms in order to identify trends and proactively prevent bottlenecks
* Allows database restart while events are still kept by middleware and could be written to a database when restart is complete

The obvious disadvantage is a middleware itself - you will have one more infrastructure component to take care of.

For this demonstration, we picked Jenkins CI as a CI engine, RabbitMQ as a middleware (just because there were RabbitMQ plugins for Jenkins available) and Neo4j as a storage solution.

You can find [the screencast of the demonstration on our youtube channel](https://www.youtube.com/watch?v=4xqFa1AV21c)
