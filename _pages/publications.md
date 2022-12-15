---
layout: page
permalink: /publications/
title: publications
description: articles, proceedings, etc.
years: [2022, 2017, 2016]
nav: true
---



<div class="publications">

{% for y in page.years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}

</div>
