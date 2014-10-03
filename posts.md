---
layout: front
title: Browse by categories
---

# Articles by Category

<categories>

{% for category in site.categories %}
    {% for catname in site.data.catnames %}
      {% if catname.dir == category.first %}
        <div style="padding-bottom:15px;">
          <span title="{{catname.description}}">{{ catname.name}}<span>
          {% for posts in category %}
            {% for post in posts %}
                <div class="list"><a title="{{ post.date | date: "%A %B %-d. %Y" }}" href="{{ post.url }}">{{ post.title }}</a></div>
            {% endfor %}
          {% endfor %}
        </div>
      {% endif %}
    {% endfor %}
{% endfor %}


</categories>