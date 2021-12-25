# SimpleFWA.jl
   [![TagBot](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/TagBot.yml/badge.svg)](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/TagBot.yml)

   [![documentation](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/documentation.yml/badge.svg)](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/documentation.yml)

## Introduction
   This solver is loosely based on the coopFWA algorithm.

___

## calling convention
   each Objective function passed to SimpleFWA has to comply with the following
   simple parameter convention f( x; kwargs ) where f is the objective
   function to be minimized. This convention ensures SimpleFWA can be used with
   time-series-problems, classification-problems, regression-problems.
   Univariate as well as multivariate target sets are admissible.

___
## example
```julia
   using SimpleFWA
   using Test
   Easom(x;kwargs) = -cos( x[1] ) * cos( x[2] ) *
                     exp( -( (x[1]-π)^2 + (x[2]-π)^2 ) )
   lower    = [ -10.0f0, -10.0f0 ];
   upper    = [ 10.0f0, 10.0f0 ];
   sFWA( objFunction ) = simpleFWA( 16, 16, ();
                                    λ_0         = 7.95f0,
                                    ϵ_A         = 0.5f-2,
                                    C_a         = 1.2f0,
                                    C_r         = 0.8f0,
                                    lower       = lower,
                                    upper       = upper,
                                    objFunction = objFunction,
                                    XPrimary    = XPrimary,
                                    yPrimary    = yPrimary,
                                    maxiter     = 40 )                             
   solutionFWA = sFWA( Easom );
   @test isapprox( solutionFWA.x_b[1], π; atol=0.01 )
   @test isapprox( solutionFWA.x_b[2], π; atol=0.01 )                             
```
___
## function reference

```@docs
SimpleFWA.simpleFWA
```

FWA struct

| Parameter         | Description                           | Type                      |
| :---              | :---                                  | :---                      |
| X                 | each column is the origin of a fw     | Matrix{Float32}           |
| fitness_fireworks | fitness of each fw                    | Vector{Float32}           |
| S                 | contains all sparks foreach fw        | Vector{ Matrix{Float32} } |
| fitness_sparks    | fitness of each spark                 | Vector{ Vector{Float32} } |
| x_b               | best found solution                   | Vector{Float32}           |
| y_min             | function value at best found solution | Float32                   |
| iter              | number of iterations executed         | Int                       |
| err_conv          | convergence error after finish        | Float32                   |
