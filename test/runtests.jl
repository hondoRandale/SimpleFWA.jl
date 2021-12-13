include( "benchmarkOptimProblems.jl" )

using Test
using SimpleFWA

@testset "SimpleFWA.jl" begin
  XPrimary = Vector{ Matrix{Float32} }( undef, 1 );
  yPrimary = Vector{ Matrix{Float32} }( undef, 1 );

  @test Ackley( [ 0.0f0, 0.0f0 ]; XPrimary, yPrimary )              ≈ 0.0f0
  @test Booth(  [ 1.0f0, 3.0f0 ]; XPrimary, yPrimary )              ≈ 0.0f0
  @test Rosenbrock( [ 1.0f0, 1.0f0 ]; XPrimary, yPrimary )          ≈ 0.0f0
  @test Matyas( [ 0.0f0, 0.0f0 ]; XPrimary, yPrimary )              ≈ 0.0f0
  @test Three_hump_camel( [ 0.0f0, 0.0f0 ]; XPrimary, yPrimary )    ≈ 0.0f0
  @test Easom( [ π, π ]; XPrimary, yPrimary )                       ≈ -1.0f0
  @test Sphere( [0.0f0, 0.0f0]; XPrimary, yPrimary )                ≈ 0.0f0
  @test Schaffer_function_no2( [0.0f0, 0.0f0]; XPrimary, yPrimary ) ≈ 0.0f0
  @test Bukin_function_no6( [-10.0f0, 1.0f0 ]; XPrimary, yPrimary ) ≈ 0.0f0

  lower    = [ -10.0f0, -10.0f0 ];
  upper    = [ 10.0f0, 10.0f0 ];

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
end;
