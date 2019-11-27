# CasADi.jl

| Status | Coverage |
| :----: | :----: |
| [![Build Status](https://travis-ci.com/ichatzinikolaidis/CasADi.jl.svg?token=FzSdC6SrVJguwZEzpBbQ&branch=master)](https://travis-ci.com/ichatzinikolaidis/CasADi.jl) | [![codecov](https://codecov.io/gh/ichatzinikolaidis/CasADi.jl/branch/master/graph/badge.svg?token=vdYN5Ok2BB)](https://codecov.io/gh/ichatzinikolaidis/CasADi.jl) |

## Introduction

This package is an interface to CasADi, a powerful symbolic framework for automatic differentiation and optimal control.
More information are available on the [official website](https://web.casadi.org).
Although Julia has excellent libraries for optimization, they have not reached the maturity of CasADi for nonlinear optimization and optimal control yet.
This library aims to give easy access to its powerful capabilities.

Please note:
1. This repo is unofficial, not maintained by the original CasADi authors, and not affiliated with the CasADi project.
2. There is no plan to include interfaces to all of CasADi capabilities. It has grown out of my own research needs and I am sharing it in case other people find it useful. Since [PyCall.jl](https://github.com/JuliaPy/PyCall.jl) is used, any aspect of CasADi not implemented in this interface can be easily accessed directly via PyCall.
3. I am more than happy to accept contributions and discuss potential changes that could improve this package.

## How to install

This is **not** a registered package and there is no plan to register it soon.
You can easily install it by activating the package manager `]` and running

```julia
add git@github.com:ichatzinikolaidis/CasADi.jl.git
```

## Example: Create NLP solver

We will use CasADi to find the minimum of the [Rosenbrock function](https://en.wikipedia.org/wiki/Rosenbrock_function).
This can be done as follows

```julia
using CasADi

x = SX("x")
y = SX("y")
α = 1
b = 100
f = (α - x)^2 + b*(y - x^2)^2

nlp = Dict("x" => vcat([x ; y]), "f" => f);
S = casadi.nlpsol("S", "ipopt", nlp);

sol = S(x0 = [0, 0]);

println("Optimal solution: x = ", sol["x"].toarray()[1], ", y = ", sol["x"].toarray()[2])
```

## Example: Using Opti stack

We will use Opti stack to solve the example problem in CasADi's documentation

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\large&space;\begin{aligned}&space;\min_{x,y}&space;\&space;&&space;\&space;(y&space;-&space;x^2)^2&space;\\&space;s.t.&space;\&space;&&space;\&space;x^2&space;&plus;&space;y^2&space;=&space;1&space;\\&space;\&space;&&space;\&space;x&space;&plus;&space;y&space;\geq&space;1.&space;\end{aligned}" title="\large \begin{aligned} \min_{x,y} \ & \ (y - x^2)^2 \\ s.t. \ & \ x^2 + y^2 = 1 \\ \ & \ x + y \geq 1. \end{aligned}"/>
</p>

```julia
using CasADi

opti = casadi.Opti();

x = opti._variable()
y = opti._variable()

opti.minimize( (y - x^2)^2 )
opti._subject_to(x^2 + y^2 == 1)
opti._subject_to(x + y >= 1)

opti.solver("ipopt");
sol = opti.solve();

println( "Optimal solution: x = ", sol.value(x), ", y = ", sol.value(y) )
```