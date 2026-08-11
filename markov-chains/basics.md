# Introduction to Markov Chains

A Markov Chain is a stochastic model describing a sequence of possible events where the probability of each event depends entirely on the state attained in the previous event.

## The Transition Matrix

The core of a Markov model is the transition matrix ($P$), which dictates the probabilities of moving from one state to another. For a simple two-state system (e.g., active vs. inactive), the matrix is formatted as follows:

$$P = \begin{bmatrix} p_{11} & p_{12} \\ p_{21} & p_{22} \end{bmatrix}$$

Where $p_{ij}$ represents the probability of transitioning from state $i$ to state $j$.
