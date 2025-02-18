---
layout: page
title: cosasi
description: COntagion Simulation And Source Identification
img: https://raw.githubusercontent.com/lmiconsulting/cosasi/main/docs/_assets/grasshopper.png
importance: 998
category: work
---

[![PyPI version](https://badge.fury.io/py/cosasi.svg)](https://badge.fury.io/py/cosasi) [![Documentation Status](https://readthedocs.org/projects/cosasi/badge/?version=latest)](https://cosasi.readthedocs.io/en/latest/?badge=latest) [![Downloads](https://pepy.tech/badge/cosasi)](https://pepy.tech/project/cosasi) [![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/) [![GitHub version](https://badge.fury.io/gh/lmiconsulting%2Fcosasi.svg)](https://badge.fury.io/gh/lmiconsulting%2Fcosasi) [![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black) [![DOI](https://zenodo.org/badge/541174642.svg)](https://zenodo.org/badge/latestdoi/541174642) [![JOSS](https://joss.theoj.org/papers/10.21105/joss.04894/status.svg)](https://doi.org/10.21105/joss.04894)

### Summary

``cosasi`` is a Python package for graph diffusion source localization, allowing users to:

- **perform and evaluate** source inference using standard techniques from literature,
- **contribute** innovative localization methods to a growing core library, and
- **benchmark** new techniques against a battery of comparable schemes.


## Installation

#### Installation via PyPI
```bash
pip install cosasi
```

#### Installation via GitHub
Clone the repo from [here](https://github.com/lmiconsulting/cosasi).

Install requirements:
```bash
pip install -r requirements.txt
```

## Getting Started
Once `cosasi` is installed, feel free to review our [tutorial](https://cosasi.readthedocs.io/en/latest/tutorial.html) introducing major functionality. Official documentation, including a detailed [API reference](https://cosasi.readthedocs.io/en/latest/apiref.html), is available on [Read the Docs](https://cosasi.readthedocs.io/).

## Testing

Extensive unit testing is employed throughout, with ~97% code coverage.

If you've cloned our repo from [GitHub](https://github.com/lmiconsulting/cosasi), you can cd into the root directory and run [pytest](https://docs.pytest.org/en/7.1.x/contents.html) via [coverage](https://coverage.readthedocs.io/en/6.3.2/):

```bash
    coverage run -m pytest
```

To read the .coverage file:

```bash
    coverage report
```

## Citing

If you found `cosasi` helpful in your work, please consider citing it with:

```bibtex
@article{McCabe2022joss,
  doi = {10.21105/joss.04894},
  url = {https://doi.org/10.21105/joss.04894},
  year = {2022},
  publisher = {The Open Journal},
  volume = {7},
  number = {80},
  pages = {4894},
  author = {Lucas H. McCabe},
  title = {cosasi: Graph Diffusion Source Inference in Python},
  journal = {Journal of Open Source Software}
}
```

McCabe, L. H., (2022). cosasi: Graph Diffusion Source Inference in Python. Journal of Open Source Software, 7(80), 4894, https://doi.org/10.21105/joss.04894


## Support

`cosasi` was developed in [Forge](https://www.lmi.org/forge), the technology accelerator of the [Logistics Management Institute](https://www.lmi.org/about-lmi).

## License
[MIT](https://choosealicense.com/licenses/mit/)
