# Introduction to Bayesian Networks

A Bayesian Network is a probabilistic graphical model that represents a set of variables and their conditional dependencies via a Directed Acyclic Graph (DAG). They are highly effective for modeling complex systems where uncertainty is present, such as diagnosing hardware faults or signal failures based on triggered alarms.

## Bayes' Theorem

The foundation of a Bayesian Network is Bayes' Theorem, which allows us to update the probability of a hypothesis as new evidence or data becomes available.

$$P(A|B) = \frac{P(B|A)P(A)}{P(B)}$$

Where:
* $P(A|B)$ is the **posterior probability**: the probability of state $A$ (e.g., a hardware fault) given evidence $B$ (e.g., a system alarm).
* $P(B|A)$ is the **likelihood**: the probability of observing the evidence $B$ if state $A$ is true.
* $P(A)$ is the **prior probability**: the initial probability of state $A$ before new evidence is observed.
* $P(B)$ is the **marginal probability**: the total probability of observing the evidence $B$ under all possible states.
