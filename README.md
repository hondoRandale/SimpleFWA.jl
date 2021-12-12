
<a id='SimpleFWA.jl'></a>

<a id='SimpleFWA.jl-1'></a>

# SimpleFWA.jl


<a id='Introduction'></a>

<a id='Introduction-1'></a>

## Introduction


This solver is loosely based on the coopFWA algorithm.


___


<a id='calling-convention'></a>

<a id='calling-convention-1'></a>

## calling convention


each Objective function passed to SimpleFWA has to comply with the following    simple parameter convention f( x, XPrimary, yPrimary ) where f is the objective    function to be minimized. This convention ensures SimpleFWA can be used with    time-series-problems, classification-problems, regression-problems.    Univariate as well as multivariate target sets are admissible.


___


<a id='example'></a>

<a id='example-1'></a>

## example


```julia
   using SimpleFWA
   using Test
   Easom(x;XPrimary,yPrimary) = -cos( x[1] ) * cos( x[2] ) *
                                exp( -( (x[1]-π)^2 + (x[2]-π)^2 ) )
   lower    = [ -10.0f0, -10.0f0 ];
   upper    = [ 10.0f0, 10.0f0 ];
   XPrimary = Vector{ Matrix{Float32} }( undef, 1 );
   yPrimary = Vector{ Matrix{Float32} }( undef, 1 );                             
   sFWA( objFunction ) = simpleFWA( 16, 16;
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


<a target='_blank' href='https://github.com/hondoRandale/SimpleFWA.jl/blob/f47a42142f276d626c199ecba6dc19df58d1ed25/src/SimpleFWA.jl#L34-L59' class='documenter-source'>source</a><br>

<a id='SimpleFWA.FWA' href='#SimpleFWA.FWA'>#</a>
**`SimpleFWA.FWA`** &mdash; *Type*.



X                 - each column is the origin of a fw   fitness*fireworks - fitness of each fw   S                 - contains all sparks foreach fw   fitness*sparks    - fitness of each spark   x*b               - best found solution   y*min             - function value at best found solution


<a target='_blank' href='https://github.com/hondoRandale/SimpleFWA.jl/blob/f47a42142f276d626c199ecba6dc19df58d1ed25/src/SimpleFWA.jl#L14-L21' class='documenter-source'>source</a><br>

