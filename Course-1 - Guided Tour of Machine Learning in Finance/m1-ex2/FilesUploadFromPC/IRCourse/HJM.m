clear; clc;

t0 = 0:0.5:3.5;
t1 = 0.5:0.5:4;

% F(0, t0, t1)
F = [6, 8, 9, 10, 10, 10, 9, 9]./100;

% P(0, t1)
P = zeros(1, 8);
P(1) = 1/( 1 + ( t1(1) - t0(1) ) * F(1) );
for i=2:8
    P(i) = P(i-1) / ( 1 + ( t1(i) - t0(i) ) * F(i) );
end

% R_swap(first_reset_time, maturity)
% first_reset_time = 0.5
% maturities = [1, 2, 3, 4]
% semi annual fixed payments i.e. delta = 0.5
S = zeros(1, 8);
for i=2:8
    S(i) = ( P(1) - P(i) ) / ( 0.5 * sum(P(2:i)) );
end

% 
black_d1 = @(i, sigma, K) ( log( F(i)./K ) + 0.5 .* sigma^2 .* t0(i) ) ./ ( sigma .* sqrt( t0(i) ) );
black_d2 = @(i, sigma, K) black_d1(i, sigma, K) - ( sigma .* sqrt( t0(i) ) );

black_cpl = @(i, sigma, K) 0.5 .* P(i) .* ( F(i) .* normcdf( black_d1(i, sigma, K) ) - K .* normcdf( black_d2(i, sigma, K) ) );

black_cap = @(i, sigma) sum( black_cpl( 2:i, sigma, S(i) ) );

cap_prices = [0, 0.2, 0, 0.8, 0, 1.2, 0, 1.6]./100;

black_sigma = zeros(1, 8);
for i=2:2:8
    black_cap_sigma_error = @(sigma) black_cap(i, sigma) - cap_prices(i);
    black_sigma(i) = fzero( black_cap_sigma_error, 0.1 );
end

black_cpl_vega = @(i, sigma, K) 0.5 .* P(i) .* F(i) .* sqrt( t0(i) ) .* normpdf( black_d1(i, sigma, K) );

black_cap_vega = @(i) sum( black_cpl_vega( 2:i, black_sigma(i), S(i) ) );

black_cap_vega_val = zeros(1, 8);
for i=2:2:8
    black_cap_vega_val(i) = black_cap_vega(i);
end

% 
vol = @(i, beta, v) ( beta .\ v .* ( exp(-beta.*t0(i)) - exp(-beta.*t1(i)) ) ).^2 .* ( exp( 2.*beta.*t0(i) ) - 1) ./ (2.*beta);

hjm_d1 = @(i, beta, v, K) (log( P(i-1).\P(i).*(1 + 0.5.*K) ) + 0.5.*vol(i, beta, v) ) ./ sqrt( vol(i, beta, v) );
hjm_d2 = @(i, beta, v, K) (log( P(i-1).\P(i).*(1 + 0.5.*K) ) - 0.5.*vol(i, beta, v) ) ./ sqrt( vol(i, beta, v) );

hjm_cpl = @(i, beta, v, K) (1 + 0.5.*K) .* ( (1 + 0.5.*K).\P(i-1).*normcdf(-hjm_d2(i, beta, v, K)) - P(i).*normcdf(-hjm_d1(i, beta, v, K)) );

hjm_cap = @(i, beta, v) sum( hjm_cpl( 2:i, beta, v, S(i) ) );

% find if you can put iteration in @func
black_vega_weighted_hjm_cap_error_square = @(beta_v) sum( ( black_cap_vega_val(2:2:8).\( [hjm_cap(2, beta_v(1), beta_v(2)), hjm_cap(4, beta_v(1), beta_v(2)), hjm_cap(6, beta_v(1), beta_v(2)), hjm_cap(8, beta_v(1), beta_v(2))] - cap_prices(2:2:8) ) ).^2 );

hjm_beta_v = fminsearch(black_vega_weighted_hjm_cap_error_square, [0.1, 0.1]);

hjm_beta_v