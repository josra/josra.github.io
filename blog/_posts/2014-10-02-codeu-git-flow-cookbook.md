---
layout: default
title: CoDe:U Git Flow Cookbook
author: Lars Kruse

---
We’re compiling a lot of very practical _how do I…_ information in relation to our CoDe:U Git Flow. 

It’s our ambition that it should be the one compendium you need in order to work efficiently with this flow.

Each recipe is delivered in bite-size postings.

## List of CoDe:U Git Flow recipes in the Cookbook

<div>

{% for category in site.categories %}
  {% if category.first == "flow" %}
    {% for posts in category %}
      {% for post in posts %}
        <div class="list"><a title="{{ post.date | date: "%A %B %-d. %Y" }}" href="{{ post.url }}">{{ post.title }}</a></div>
      {% endfor %}
    {% endfor %}
  {% endif %}
{% endfor %}

</div>








