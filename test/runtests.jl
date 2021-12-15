# MIT License

#Copyright (c) 2021 hondoRandale <jules.rasetaharison@tutanota.com> and contributors

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

include( "benchmarkOptimProblems.jl" )

using Test
using SimpleFWA



@testset "SimpleFWA.jl" begin
  XPrimary = Vector{ Matrix{Float32} }( undef, 1 );
  yPrimary = Vector{ Matrix{Float32} }( undef, 1 );

  # 2-D objective functions
  @test Himmelblau( [ 3.0f0, 2.0f0 ]; XPrimary, yPrimary )             ≈ 0.0f0
  @test Himmelblau( [ -2.805118f0,  3.131312f0 ]; XPrimary, yPrimary ) ≈ 0.0f0 atol=1f-3
  @test Himmelblau( [ -3.779310f0, -3.283186f0 ]; XPrimary, yPrimary ) ≈ 0.0f0 atol=1f-10
  @test Himmelblau( [ 3.584428f0, -1.848126f0 ]; XPrimary, yPrimary )  ≈ 0.0f0 atol=1f-5
  @test Levi_no13( [ 1.0f0, 1.0f0 ]; XPrimary, yPrimary )              ≈ 0.0f0 atol=1f-30
  @test Ackley( [ 0.0f0, 0.0f0 ]; XPrimary, yPrimary )                 ≈ 0.0f0
  @test Booth(  [ 1.0f0, 3.0f0 ]; XPrimary, yPrimary )                 ≈ 0.0f0
  @test Rosenbrock( [ 1.0f0, 1.0f0 ]; XPrimary, yPrimary )             ≈ 0.0f0
  @test Matyas( [ 0.0f0, 0.0f0 ]; XPrimary, yPrimary )                 ≈ 0.0f0
  @test Three_hump_camel( [ 0.0f0, 0.0f0 ]; XPrimary, yPrimary )       ≈ 0.0f0
  @test Easom( [ π, π ]; XPrimary, yPrimary )                          ≈ -1.0f0
  @test Sphere( [0.0f0, 0.0f0]; XPrimary, yPrimary )                   ≈ 0.0f0
  @test Schaffer_function_no2( [0.0f0, 0.0f0]; XPrimary, yPrimary )    ≈ 0.0f0
  @test Bukin_function_no6( [-10.0f0, 1.0f0 ]; XPrimary, yPrimary )    ≈ 0.0f0

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
