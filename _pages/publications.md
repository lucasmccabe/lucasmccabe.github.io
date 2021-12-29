---
layout: page
permalink: /publications/
title: publications
description: See <a href="https://scholar.google.com/citations?user=fXWneGkAAAAJ">Google Scholar</a> for the most up-to-date itemization.
years: [2021, 2017, 2016]
nav: true
---



<div class="publications">

{% for y in page.years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}

</div>
