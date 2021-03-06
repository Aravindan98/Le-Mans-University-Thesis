# Deep Galerkin Method
In this document, you will the explanation on how the deep galerkin algorithm works and specifically it's application in solving the Fokker-Planck equation of a few stochastic processes.

This [paper](https://arxiv.org/abs/1811.08782) was referred to for this method.

Sections:
  - Algorithm 
  - Solving the Fokker-Planck equations:
    * Ornstein-Uhlenbeck Process
    * Geometric Brownian Motion
    * Cox-Ingersoll-Ross Process

## Algorithm
The steps of the algorithm works as follows:
  
  1. Firstly, we need to sample points in our domain. This would be equivalent to the discretization step in traditional Finite-Difference Schemes:

    1. Sample for time: $$t$$.
    2. Sample for interior space points: $x_interior$.
    3. Sample for space points corresponding to the initial condition which in most cases are the same as $x_interior$. Let's call it $x_initial$
    4. Sample for space points for the boundary condition $x_boundary$.
    5. Now we obtain the space in which
