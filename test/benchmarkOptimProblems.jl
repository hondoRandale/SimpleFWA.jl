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

#######################
## 2D-test functions ##
#######################

## Beale function
Beale_2D(x;kwargs) = ( 1.5f0 - x[1] + x[1]*x[2] )^2 + ( 2.25f0 - x[1] + x[1]*x[2]^2 )^2 + ( 2.625f0 - x[1] + x[1]*x[2]^3 )^2

## Himmelblau's function
Himmelblau_2D(x;kwargs) = ( x[1]^2 + x[2] - 11.0f0 )^2 + ( x[1] + x[2]^2 - 7.0f0  )^2

## Lévi function N.13
Levi_no13_2D(x;kwargs) = sin( 3 * π * x[1] )^2 + ( x[1] - 1.0f0 )^2 * ( 1.0f0 + sin( 1.0f0+3*π*x[2] )^2 ) +
                                 ( x[2] - 1.0f0 )^2 * ( 1.0f0 + sin( 2*π*x[2] )^2 )

## Rosenbrock_function
Rosenbrock_2D(x;kwargs) = ( 1.0f0 - x[1] )^2 + 100.0f0 * (x[2] - x[1]^2)^2


## Booth_function
Booth_2D(x;kwargs) = ( x[1] + 2.0f0*x[2] - 7.0f0 )^2 +
                     ( 2.0f0*x[1] + x[2] - 5.0f0 )^2

## Ackley_function
Ackley_2D(x;kwargs) = -20.0f0 * exp( -0.2f0 * sqrt( 0.5f0 * ( x[1]^2 + x[2]^2 ) )  ) -
                      exp( 0.5f0 * ( cos( 2.0f0 * π * x[1] ) + cos( 2.0f0 * π * x[2] ) ) ) +
                      exp( 1.0f0 ) +
                      20.0f0

## Matyas_function
Matyas_2D(x;kwargs) = 0.26f0 * ( x[1]^2 + x[2]^2  ) - 0.48f0 * x[1] * x[2]

## Three_hump_camel_function
Three_hump_camel_2D(x;kwargs) = 2.0f0 * x[1]^2 - 1.05f0 * x[1]^4 +
                                x[1]^6 / 6 + x[1] * x[2] + x[2]^2

## Easom_function
Easom_2D(x;kwargs) = -cos( x[1] ) * cos( x[2] ) * exp( -( (x[1]-π)^2 + (x[2]-π)^2 ) )

## Sphere_function
Sphere_2D(x;kwargs) = x[1]^2 + x[2]^2

## Schaffer_function_no2
Schaffer_function_no2_2D(x;kwargs) = 0.5f0 + ( sin( x[1]^2 - x[2]^2 )^2 - 0.5f0 ) /
                                             ( 1.0f0 + 0.001f0*( x[1]^2 + x[2]^2 ) )^2

## Bukin_function_no6
Bukin_function_no6_2D(x;kwargs) = 100.0f0 * sqrt( abs( x[2] - 0.01f0 * x[1]^2 ) ) + 0.01f0*abs( x[1] + 10.0f0 )

obj_functions_2D = [ Beale_2D,
                     Himmelblau_2D, Levi_no13_2D,
                     Ackley_2D, Matyas_2D, Booth_2D,
                     Three_hump_camel_2D, Easom_2D,
                     Sphere_2D, Rosenbrock_2D,
                     Schaffer_function_no2_2D,
                     Bukin_function_no6_2D ];

#######################
## ND-test functions ##
#######################

## Rastrigin function
Rastrigin_ND(x;kwargs) = 10.0f0 * Float32( length( x ) ) + sum( ( x.^2 ) .- 10.0f0 * cos.( 2*π*x )  )

## Sphere function
Sphere_ND(x;kwargs) = sum( x.^2 )

## Styblinski–Tang function
Styblinski_Tang_ND(x;kwargs) = 0.5f0 * sum( (x).^4 .- 16.0f0*(x).^2 .+ 5.0f0.*x )

## Axis Parallel Hyper-Ellipsoid function
AxisParallelHyperEll_ND(x;kwargs) = sum( Float32.( 1:1:length( x ) ) .* ( x.^2 ) )

## Zakharov Function
Zakharov_ND(x;kwargs) = sum( x.^2 ) + sum( 0.5f0 * Float32.( 1:1:length( x ) ) .* x )^2 + sum( 0.5f0 * Float32.( 1:1:length( x ) ) .* x )^4

## Michalewicz function
Michalewicz_ND(x;kwargs) = -sum( sin.( x ) .* sin.( ( Float32.( 1:1:length( x ) ) .* ( x.^2 ) ) / π ) )

## Exponential function
Exponential_ND(x;kwargs) = -exp( -0.5f0 * sum( x.^2 ) )

## Griewank function
Griewank_ND(x;kwargs) = 1.0f0 + sum( (x).^2 / 4000.0f0 ) - prod( cos.( x ./ sqrt.( Float32.( 1:1:length( x ) ) ) ) )

## Qing function
Qing_ND(x;kwargs) = sum( ( (x).^2 .- Float32.( 1:1:length( x ) ) ).^2 )

## Salomon function
Salomon_ND(x;kwargs) = 1.0f0 - cos( 2*π*sqrt( sum( (x).^2 ) ) ) + 0.1f0 * sqrt( sum( (x).^2 ) )

## Schwefel function
Schwefel_ND(x;kwargs) = 418.9829f0 * length( x ) - sum( x .* sin.( sqrt.( abs.( x ) ) ) )

## Schwefel 2.20 function
Schwefel_2_2_0_ND(x;kwargs) = sum( abs.( x ) )

## Schwefel 2.21 function
Schwefel_2_2_1_ND(x;kwargs) = maximum( abs.( x ) )

## Schwefel 2.22 function
Schwefel_2_2_2_ND(x;kwargs) = sum( abs.( x ) ) + prod( abs.( x ) )

## Schwefel 2.23 function
Schwefel_2_2_3_ND(x;kwargs) = sum( (x).^10 )


obj_functions_Nd = [ Rastrigin_ND, Sphere_ND,
                     Styblinski_Tang_ND, AxisParallelHyperEll_ND,
                     Zakharov_ND, Michalewicz_ND,
                     Exponential_ND, Griewank_ND,
                     Qing_ND, Salomon_ND,
                     Schwefel_ND, Schwefel_2_2_0_ND,
                     Schwefel_2_2_1_ND, Schwefel_2_2_2_ND,
                     Schwefel_2_2_3_ND ]
