
<a id='SimpleFWA.jl'></a>

<a id='SimpleFWA.jl-1'></a>

# SimpleFWA.jl


[![TagBot](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/TagBot.yml/badge.svg)](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/TagBot.yml)


[![documentation](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/documentation.yml/badge.svg)](https://github.com/hondoRandale/SimpleFWA.jl/actions/workflows/documentation.yml)


<a id='Introduction'></a>

<a id='Introduction-1'></a>

## Introduction


This solver is loosely based on the coopFWA algorithm.


___


<a id='calling-convention'></a>

<a id='calling-convention-1'></a>

## calling convention


each Objective function passed to SimpleFWA has to comply with the following    simple parameter convention f( x; kwargs ) where f is the objective    function to be minimized. This convention ensures SimpleFWA can be used with    time-series-problems, classification-problems, regression-problems.    Univariate as well as multivariate target sets are admissible.


___


<a id='example'></a>

<a id='example-1'></a>

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


<a id='function-reference'></a>

<a id='function-reference-1'></a>

## function reference

<a id='SimpleFWA.simpleFWA' href='#SimpleFWA.simpleFWA'>#</a>
**`SimpleFWA.simpleFWA`** &mdash; *Function*.



```julia
simpleFWA( nFireworks::Int,
           nSparks::Int;
           λ_0::Float32,
           ϵ_A::Float32,
           C_a::Float32,
           C_r::Float32,
           lower::Vector{Float32},
           upper::Vector{Float32},
           objFunction::Function,
           XPrimary::Vector{ Matrix{Float32} },
           yPrimary::Vector{ Matrix{Float32} },
           maxiter::Int,
           ϵ_conv::Float32=1f-6 )
minimize objective function objFunction, the solution space is limited by lower and upper bound.
The optimization algorithm utilized is an simplified version of dynFireWorksAlgorithm. The nFireworks
parameter governs the number of fireworks being evaluated in parallel in each iteration.  nSparks is
the number of sparks per firework, in remains constant foreach firework. ϵ_A is the smoothing parameter
controlling the variance of amplitudes computed foreach fw. C_a ist the upscaling parameter for explosion
amplitudes. C_r is the downscaling parameter for explosion amplitudes. XPrimary is the feature set of the
primary algorithm to be tuned. yPrimary is the target set of the primary algorithm. maxiter is the maximum
number iteraions.  ϵ_conv denotes the convergence parameter.
```


<a target='_blank' href='https://github.com/hondoRandale/SimpleFWA.jl/blob/1c27b4e2ab6be62645103d29eef329b5223bc97c/src/SimpleFWA.jl#L126-L148' class='documenter-source'>source</a><br>


FWA struct


| Parameter         | Description                           | Type                      |
|:----------------- |:------------------------------------- |:------------------------- |
| X                 | each column is the origin of a fw     | Matrix{Float32}           |
| fitness_fireworks | fitness of each fw                    | Vector{Float32}           |
| S                 | contains all sparks foreach fw        | Vector{ Matrix{Float32} } |
| fitness_sparks    | fitness of each spark                 | Vector{ Vector{Float32} } |
| x_b               | best found solution                   | Vector{Float32}           |
| y_min             | function value at best found solution | Float32                   |
| iter              | number of iterations executed         | Int                       |
| err_conv          | convergence error after finish        | Float32                   |

