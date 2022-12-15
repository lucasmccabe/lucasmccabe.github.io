---
layout: page
permalink: /talks/
title: talks
description: research talks, poster presentations, etc.
years: [2022, 2021, 2020]
nav: true
---



<div class="publications">

{% for y in page.years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f talks -q @*[year={{y}}]* %}
{% endfor %}

</div>
