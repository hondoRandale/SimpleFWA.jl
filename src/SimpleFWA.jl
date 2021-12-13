module SimpleFWA

  using InvertedIndices
  using Random
  using Statistics

  export FWA, simpleFWA

  """
    X                 - each column is the origin of a fw
    fitness_fireworks - fitness of each fw
    S                 - contains all sparks foreach fw
    fitness_sparks    - fitness of each spark
    x_b               - best found solution
    y_min             - function value at best found solution
  """
  mutable struct FWA
    X;
    fitness_fireworks;
    S;
    fitness_sparks;
    x_b;
    y_min;
  end




    """

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

    """
  @views function simpleFWA( nFireworks::Int,
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

    @assert nFireworks > 0
    @assert nSparks    > 0
    @assert λ_0        > 0.0f0
    @assert ϵ_A        > 0.0f0
    @assert C_a        > 0.0f0
    @assert C_r        > 0.0f0
    @assert length( upper ) == length( lower )
    @assert all( lower .<  upper )
    @assert size( XPrimary, 2 ) == length( yPrimary )
    @assert maxiter   > 0

    d        = length( lower );
    rng      = RandomDevice();
    ## explosion amplitudes of firework roots
    fitness_fireworks = Vector{Float32}( undef, nFireworks );
    fitness_sparks    = Vector{ Vector{Float32} }( undef,  nFireworks );
    A                 = Vector{Float32}( undef, nFireworks );
    A_old             = zeros( Float32, nFireworks );
    ## spark positions for all fireworks
    S                 = Vector{ Matrix{Float32} }( undef, nFireworks );

    for ii in 1:1:nFireworks
      fitness_sparks[ii] = zeros( Float32, nSparks );
      S[ii]              = zeros( Float32, d, nSparks );
    end

    ## firework root explosion positions
    X                 = Matrix{Float32}( undef, d, nFireworks );
    ## random mat needed for inititialization of fw positions
    rand_mat          = Matrix{Float32}( undef, d, nFireworks );
    # generate nFireworks randomly within boundaries
    drawFireworksPositionsBoundary!( ;rng=rng, X=X, rand_mat=rand_mat, upper=upper, lower=lower );
    ## evaluate fireworks
    evaluateCandidates(;XPrimary = XPrimary,
                        yPrimary = yPrimary,
                        f        = objFunction,
                        X        = X,
                        fitness  = fitness_fireworks );
    cf    = argmin( fitness_fireworks )::Int;
    y_min = fitness_fireworks[cf]::Float32;

    # compute explosion amplitudes
    explosionAmplitudes!( ;A, λ_0, ϵ_A, y_min, fitness_fireworks );
    A[cf]   = ( minimum( A[ Not( cf ) ] ) / 2.0f0 )::Float32;
    iter    = 0;
    err     = 2.0f0 * ϵ_conv;
    x_b     = X[:,cf];
    x_b_old = zeros( Float32, d );
    while err > ϵ_conv && iter <= maxiter
      cf              = argmin( fitness_fireworks )::Int;
      @inbounds y_cf  = fitness_fireworks[cf]::Float32;
      @inbounds A_cf  = A[cf]::Float32;
      # compute explosion amplitudes
      explosionAmplitudes!( ;A, λ_0, ϵ_A, y_min, fitness_fireworks );
      @inbounds A[cf]  = A_cf::Float32;
      @inbounds A[cf]  = dynExplosionAmplitude( y_min, y_cf, A_old[cf], C_a, C_r )::Float32;
      A_old .= A;
      # compute explosion sparks
      Threads.@threads for jj ∈ 1:1:nFireworks
        explosionSparks(;X_i             = X[:,jj],
                         A_i             = A[jj],
                         s               = S[jj],
                         lower           = lower,
                         upper           = upper,
                         rng             = rng );

        evaluateCandidates(;XPrimary = XPrimary,
                            yPrimary = yPrimary,
                            f        = objFunction,
                            X        = S[jj],
                            fitness  = fitness_sparks[jj] );
      end
      for jj ∈ 1:1:nFireworks
        @inbounds val = minimum( fitness_sparks[jj] );
        @inbounds idx = argmin( fitness_sparks[jj] );
        ## update best globally found solution
        if val < y_min
          y_min = val;
          @inbounds x_b   = S[jj][:,idx];
        end
        ## update fw move to best found local solution
        if val < fitness_fireworks[jj]
          @inbounds X[:,jj]              .= S[jj][:,idx];
          @inbounds fitness_fireworks[jj] = val;
        end
      end
      iter += 1;
    end
    # check if best global solution is contained in fw position
    if y_min > minimum( fitness_fireworks )
      idx             = argmin( fitness_fireworks );
      @inbounds y_min = fitness_fireworks[ idx ];
      @inbounds x_b   = X[:,idx];
    end
    return FWA( X, fitness_fireworks, S, fitness_sparks, x_b, y_min )
  end


  function evaluateCandidates( ;XPrimary::Vector{ Matrix{Float32} },
                               yPrimary::Vector{ Matrix{Float32} },
                               f::Function,
                               X,
                               fitness )
    @assert size( XPrimary, 2 ) == length( yPrimary )
    @assert size( X, 2 )        == size( fitness, 1 )

    n = size( X, 2 )::Int;
    for ii ∈ 1:1:n
      x            = view( X, :, ii );
      fitness[ii]  = f( x; XPrimary=XPrimary, yPrimary=yPrimary );
    end
  end


  function drawFireworksPositionsBoundary!(;rng,
                                           X::Matrix{Float32},
                                           rand_mat::Matrix{Float32},
                                           upper::Vector{Float32},
                                           lower::Vector{Float32} )
    @assert length( upper ) == length( lower )
    @assert all( size( X )  == size( rand_mat ) )

    nFireworks = size( X, 2 );
    d          = length( lower );
    rand_mat  .= Float32.( rand( rng, d, nFireworks ) );
    for iter ∈ 1:1:nFireworks
      x_sp     = view( X,        :, iter );
      rand_vec = view( rand_mat, :, iter );
      for k ∈ 1:1:d
        lu      = lower[k]::Float32;
        x_sp[k] = ( rand_vec[k] * ( upper[k] - lu ) + lu )::Float32;
      end
    end
  end


  function explosionAmplitudes!(;A::Vector{Float32},
                                 λ_0::Float32,
                                 ϵ_A::Float32,
                                 y_min::Float32,
                                 fitness_fireworks::Vector{Float32} )
    n      = length( fitness_fireworks );
    cacheA = Vector{Float32}( undef, n );
    for ii ∈ 1:1:n
      @inbounds fx         = fitness_fireworks[ii];
      @inbounds cacheA[ii] = ( fx - y_min )::Float32;
    end
    denomA = ( sum( cacheA ) + ϵ_A )::Float32;
    for ii ∈ 1:1:n
      @inbounds A[ii] = ( λ_0 * ( ( cacheA[ii] + ϵ_A ) / denomA ) )::Float32;
    end
  end


  function dynExplosionAmplitude( y_min::Float32,
                                  y_cf::Float32,
                                  A_cf_old::Float32,
                                  C_a::Float32,
                                  C_r::Float32 )
    A_cf = A_cf_old::Float32
    if y_min - y_cf < 0.0f0
      A_cf *= C_a;
    else
      A_cf *= C_r;
    end
    return A_cf
  end


  function explosionSparks( ;X_i, A_i, s, lower, upper, rng )
    nSparks = size( s, 2 );
    d       = size( s, 1 );
    for j ∈ 1:1:nSparks
      idz = bitrand( rng, d );
      for ii ∈ 1:1:d
        if idz[ii]
          @inbounds ΔX_k    = ( A_i * ( rand( rng, Float32, 1 )[1] * 2.0f0 - 1.0f0 ) )::Float32;
          @inbounds val     = ( X_i[ii] + ΔX_k )::Float32;
          if val >= lower[ii] && val <= upper[ii]
            @inbounds s[ii,j] = val::Float32;
          else
            @inbounds s[ii,j] = ( rand( rng, Float32, 1 )[1] * ( upper[ii] - lower[ii] ) + lower[ii] )::Float32;
          end
        end
      end
    end
  end

end
