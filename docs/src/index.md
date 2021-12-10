# SimpleFWA
## Introduction
**SimpleFWA** is a practical Fire Works Algorithm implementation aiming at finding good meta parameters for learning problems.
The algorithm is capable of finding the global optimum quite often, but not always.
The Algorithm works on a bounded input, multi variant non-linear object function.
The only parameter which has to be set is lambda.

## Usage
```@repl
using SimpleFWA
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
                                 maxiter     = 40 );

solutionFWA = sFWA( Easom );
```

## Convention

Each objective function has to adhere to the following parameter convention  f(x;XPrimary,yPrimary).
 x denotes the meta param instance, XPrimary and yPrimary constitute the training set of the primary algorithm being tuned.


## Reference

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

minimize objFunction.
nFireworks:  number of concurrent fireworks
nSparks:     number of sparks per firework
λ_0:         maximum amplitude of explosion
ϵ_A:         aux. var needed to prevent division by zero
C_a:         explosion amplitude modification factor up
C_r:         explosion amplitude modification factor down
lower:       lower bound optimization
upper:       upper bound optimization
objFunction: objective to be minimized
XPrimary:    feature set primary algorithm
yPrimary:    target  set primary algorithm
maxiter:     number of iterations to run
```
## Result

the returned object contains the best parameter in field x_b, the best function value is stored in field y_min.
