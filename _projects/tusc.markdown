---
layout: page
title: tusc
description: 🐘 a Python library providing tools for combinatorial maths
img: https://raw.githubusercontent.com/lucasmccabe/tusc/main/assets/elephant_header.png
importance: 1
category: work
---



[<a href="https://pypi.org/project/tusc/">PyPI</a>]  [<a href="https://github.com/lucasmccabe/tusc">GitHub</a>]  [<a href="https://tusc.readthedocs.io/en/latest/?badge=latest">Read the Docs</a>]

### Summary

`tusc` is work-in-progress Python library providing tools for combinatorial maths (partially-ordered sets, graph polynomials, etc.). Documentation is available on <a href="https://tusc.readthedocs.io/en/latest/?badge=latest">Read the Docs</a>. You can install a preliminary version of `tusc` using <a href="https://pypi.org/project/tusc/">pip</a>.


### Example Usage

Create a <a href="https://en.wikipedia.org/wiki/Boolean_algebra_(structure)">Boolean lattice</a> B<sub>5</sub>, and check if it is an <a href="https://en.wikipedia.org/wiki/Eulerian_poset">Eulerian poset</a>:

``` python
>>> examples = tusc.posets.ExamplePosets()
>>> boolean_lattice = examples.boolean_lattice(5)
>>> p = tusc.posets.Poset(boolean_lattice)
>>> print(p.is_Eulerian())
True
```

Compute the <a href="https://en.wikipedia.org/wiki/Tutte_polynomial">Tutte polynomial</a> for the cycle graph C<sub>5</sub>, and use it to find the number of <a href="https://en.wikipedia.org/wiki/Acyclic_orientation">acyclic orientations</a> of C<sub>5</sub>:

``` python
>>> tutte_C5 = tusc.graph.polynomial.Tutte(nx.cycle_graph(5))
>>> print(tutte_C5.polynomial)
'x**4 + x**3 + x**2 + x + y'
>>> tutte_C5.evaluate(2, 0)
30
```
