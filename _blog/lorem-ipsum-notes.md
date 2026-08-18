---
title: "Notes on Lorem Ipsum Estimation"
date: 2026-08-10
summary: >
  Dolor sit amet consectetur notes on identifying the lorem ipsum estimator
  under standard regularity conditions.
---

## Setup

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suppose we observe
an i.i.d. sample $$(X_i, Y_i)_{i=1}^n$$ and want to estimate the conditional
mean function.

## The estimator

The estimator solves the moment condition

$$
\hat{\beta} = \arg\min_{\beta} \sum_{i=1}^n \left( Y_i - X_i^\top \beta \right)^2.
$$

Under standard regularity conditions, $$\hat{\beta}$$ is consistent and
asymptotically normal:

$$
\sqrt{n} \left( \hat{\beta} - \beta_0 \right) \xrightarrow{d} \mathcal{N}(0, \Sigma).
$$

## Discussion

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
voluptate velit esse cillum dolore eu fugiat nulla pariatur.
