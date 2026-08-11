# Introduction to Monte Carlo Simulations

Monte Carlo Simulations use repeated random sampling to obtain numerical results. They are heavily used to assess risk and predict performance in complex systems with highly variable inputs.

## Core Concept: Approximating Expected Value

In many performance models, we need to find the expected value of a function $f(x)$ where $x$ is a random variable. Instead of computing highly complex integrals, a Monte Carlo simulation approximates this by drawing $N$ independent random samples ($x_1, x_2, ..., x_N$) from the distribution and averaging the results:

$$E[f(x)] \approx \frac{1}{N} \sum_{i=1}^{N} f(x_i)$$

Where:
* $E[f(x)]$ is the expected value we are trying to find.
* $N$ is the total number of simulated trials.
* $x_i$ represents the random input drawn for the $i$-th simulation.

As $N$ increases to thousands or millions of iterations, this approximation reliably converges on the true expected value.
