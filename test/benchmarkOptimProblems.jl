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

## Himmelblau's function
Himmelblau(x;XPrimary,yPrimary) = ( x[1]^2 + x[2] - 11.0f0 )^2 + ( x[1] + x[2]^2 - 7.0f0  )

## Lévi function N.13
Levi_no13(x;XPrimary,yPrimary) = sin( 3 * π * x[1] )^2 + ( x[1] - 1.0f0 )^2 * ( 1.0f0 + sin( 1.0f0+3*π*x[2] )^2 ) +
                                 ( x[2] - 1.0f0 )^2 * ( 1.0f0 + sin( 2*π*x[2] )^2 )

## Rosenbrock_function
Rosenbrock(x;XPrimary,yPrimary) = ( 1.0f0 - x[1] )^2 + 100.0f0 * (x[2] - x[1]^2)^2


## Booth_function
Booth(x;XPrimary,yPrimary) = ( x[1] + 2.0f0*x[2] - 7.0f0 )^2 +
                             ( 2.0f0*x[1] + x[2] - 5.0f0 )^2

## Ackley_function
Ackley(x;XPrimary,yPrimary) = - 20.0f0 * exp( -0.2f0 * sqrt( 0.5f0 * ( x[1]^2 + x[2]^2 ) )  ) -
                                exp( 0.5f0 * ( cos( 2.0f0 * π * x[1] ) + cos( 2.0f0 * π * x[2] ) ) ) +
                                exp( 1.0f0 ) +
                                20.0f0

## Matyas_function
Matyas(x;XPrimary,yPrimary) = 0.26f0 * ( x[1]^2 + x[2]^2  ) - 0.48f0 * x[1] * x[2]

## Three_hump_camel_function
Three_hump_camel(x;XPrimary,yPrimary) = 2.0f0 * x[1]^2 - 1.05f0 * x[1]^4 +
                                        x[1]^6 / 6 + x[1] * x[2] + x[2]^2

## Easom_function
Easom(x;XPrimary,yPrimary) = -cos( x[1] ) * cos( x[2] ) * exp( -( (x[1]-π)^2 + (x[2]-π)^2 ) )

## Sphere_function
Sphere(x;XPrimary,yPrimary) = x[1]^2 + x[2]^2

## Schaffer_function_no2
Schaffer_function_no2(x;XPrimary,yPrimary) = 0.5f0 + ( sin( x[1]^2 - x[2]^2 )^2 - 0.5f0 ) /
                                             ( 1.0f0 + 0.001f0*( x[1]^2 + x[2]^2 ) )^2

## Bukin_function_no6
Bukin_function_no6(x;XPrimary,yPrimary) = 100.0f0 * sqrt( abs( x[2] - 0.01f0 * x[1]^2 ) ) + 0.01f0*abs( x[1] + 10.0f0 )

obj_functions = [ Himmelblau, Levi_no13,
                  Ackley, Matyas, Booth,
                  Three_hump_camel, Easom,
                  Sphere, Rosenbrock,
                  Schaffer_function_no2,
                  Bukin_function_no6 ];
