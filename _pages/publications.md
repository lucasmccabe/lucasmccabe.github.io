---
layout: page
permalink: /papers/
title: papers
description: See <a href="https://scholar.google.com/citations?user=fXWneGkAAAAJ&hl=en">Google Scholar</a> for the most up-to-date listing.
years: [2024, 2023, 2022, 2017, 2016]
nav: true
---



<div class="publications">

{% for y in page.years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}

</div>
