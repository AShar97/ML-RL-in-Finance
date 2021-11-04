clear; clc;

sigma = 0.01; k = 0.86;
t = 0; T = 1;

gamma = 2\(k\sigma*(exp(-k*(T-t))-1))^2;

gamma%*10^4

% 

t0 = 4\(0:7);
t1 = 4\(1:8);

% F(0, t0, t1)
F = [6, 8, 9, 10, 10, 10, 9, 9]./100;

% P(0, t1)
P = zeros(1, 8);
P(1) = 1/( 1 + ( t1(1) - t0(1) ) * F(1) );
for i=2:8
    P(i) = P(i-1) / ( 1 + ( t1(i) - t0(i) ) * F(i) );
end

% R_swap(first_reset_time, maturity)
% first_reset_time = 0.25
% maturities = 2
% semi annual fixed payments i.e. delta = 0.25
K = ( P(1) - P(8) ) / ( 0.25 * sum(P(2:8)) );

cap_price = 0.01;

black_d1 = @(i, sigma, K) ( log( F(i)./K ) + 0.5 .* sigma^2 .* t0(i) ) ./ ( sigma .* sqrt( t0(i) ) );
black_d2 = @(i, sigma, K) black_d1(i, sigma, K) - ( sigma .* sqrt( t0(i) ) );

black_cpl = @(i, sigma, K) 0.25 .* P(i) .* ( F(i) .* normcdf( black_d1(i, sigma, K) ) - K .* normcdf( black_d2(i, sigma, K) ) );

black_cap = @(sigma) sum( black_cpl( 2:i, sigma, K ) );

black_cap_sigma_error = @(sigma) black_cap(sigma) - cap_price;
black_sigma = fzero( black_cap_sigma_error, 0.1 );
black_sigma%*10^2

bachelier_D = @(i, sigma, K) (F(i) - K) ./ ( sigma .* sqrt(t0(i)) );

bachelier_cpl = @(i, sigma, K) 0.25 .* P(i) .* sigma .* sqrt(t0(i)) .* ( bachelier_D(i, sigma, K).*normcdf(bachelier_D(i, sigma, K)) + normpdf(bachelier_D(i, sigma, K)) );

bachelier_cap = @(sigma) sum( bachelier_cpl( 2:i, sigma, K ) );

bachelier_cap_sigma_error = @(sigma) bachelier_cap(sigma) - cap_price;
bachelier_sigma = fzero( bachelier_cap_sigma_error, 0.1 );
bachelier_sigma%*10^4

black_cap(0.141)%*10^2

% 

r0 = 0.08;
k = 0.86;
theta = 0.09;
sigma = 0.0148;

B = @(t, k) k.\(1-exp(-k.*t));
A = @(t, k, theta, sigma) t.*(theta - 2.\(sigma./k).^2) + k.\(.75.*(sigma./k).^2 - theta) + (exp(-k.*t)./k).*(theta - (sigma./k).^2) + (exp(-2.*k.*t)/(4.*k)).*(sigma./k).^2;

t0 = (0:119)/4;
t1 = ( (0:119) + 1 )/4;

P = exp( -A(t1, k, theta, sigma) - B(t1, k)*r0 );

% R_swap(first_reset_time, maturity)
% first_reset_time = 0.25
% maturities = 120/4 = 30
% semi annual fixed payments i.e. delta = 0.25
S = ( P(1) - P(120) ) / ( 0.25 * sum(P(2:120)) );

% hjm framework
beta = k; v = sigma;

vol = @(i, beta, v) ( beta .\ v .* ( exp(-beta.*t0(i)) - exp(-beta.*t1(i)) ) ).^2 .* ( exp( 2.*beta.*t0(i) ) - 1) ./ (2.*beta);

hjm_d1 = @(i, beta, v, K) (log( P(i-1).\P(i).*(1 + 0.25.*K) ) + 0.5.*vol(i, beta, v) ) ./ sqrt( vol(i, beta, v) );
hjm_d2 = @(i, beta, v, K) (log( P(i-1).\P(i).*(1 + 0.25.*K) ) - 0.5.*vol(i, beta, v) ) ./ sqrt( vol(i, beta, v) );

hjm_cpl = @(i, beta, v, K) (1 + 0.25.*K) .* ( (1 + 0.25.*K).\P(i-1).*normcdf(-hjm_d2(i, beta, v, K)) - P(i).*normcdf(-hjm_d1(i, beta, v, K)) );

hjm_cap = sum( hjm_cpl( 2:120, beta, v, S ) );

hjm_cap%*10^2