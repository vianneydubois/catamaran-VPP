function [x,fval] = systemSolving(Vwt, beta_t, delta_s)
%UNTITLED Summary of this function goes here
%   Vwt     True wind speed [knots]
%   beta_t  True wind angle [deg]
%   delta_s Sail setting angle [deg]



Vwt = Vwt /3.6 * 1.852; % knots to meters/second conversion

% initial guess
delta0 = 0;
delta_r0 = 0;
Vbh0 = 10;
x0 = [delta0 delta_r0 Vbh0];

% defining the system to solve
systemFunction = @(x) ...
   computeLoads(Vwt, beta_t, delta_s, x(1), x(2), x(3));

% system solving
[x,fval] = fsolve(systemFunction, x0);

end

