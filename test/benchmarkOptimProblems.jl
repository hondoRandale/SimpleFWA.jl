
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

obj_functions = [ Ackley, Matyas, Booth,
                  Three_hump_camel, Easom,
                  Sphere, Rosenbrock,
                  Schaffer_function_no2,
                  Bukin_function_no6 ];
