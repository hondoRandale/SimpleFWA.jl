
include( "benchmarkOptimProblems.jl" )

using Test
using SimpleFWA

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
@test isapprox( solutionFWA.x_b[1], π; atol=0.01 )
@test isapprox( solutionFWA.x_b[2], π; atol=0.01 )


@test sum( [ sFWA( fObj ).y_min for fObj ∈ obj_functions ] ) < -0.8
