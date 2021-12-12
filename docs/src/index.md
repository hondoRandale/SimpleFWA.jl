# SimpleFWA.jl

## Introduction
   This solver is loosely based on the coopFWA algorithm.

___

## calling convention
   each Objective function passed to SimpleFWA has to comply with the following
   simple parameter convention f( x, XPrimary, yPrimary ) where f is the objective
   function to be minimized. This convention ensures SimpleFWA can be used with
   time-series-problems, classification-problems, regression-problems.
   Univariate as well as multivariate target sets are admissible.

___
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
## function reference

```@docs
SimpleFWA.simpleFWA
```

```@docs
SimpleFWA.FWA
```
