% Solves for the boat speed, drifting angle and rudder angle to sail in
% given true wind conditions

% WHAT NEEDS TO BE DONE
% - Moments are taken as equal for both hulls :
% update the momentcomputation code

clear;
close all;

%% plot flags
plotFlags = [
    0 % initial conditions
    1 % final conditions and forces
    ];

%% true wind conditions
% in body frame
Vwt = 10; %     true wind speed [KNOTS]
beta_t = 80; %  true wind angle (in body frame) [DEGREES]

%% sail settings
delta_s = 25; % sail angle [DEGREES]

%% system solving

Vwt = Vwt /3.6*1.852; % knots to meters/second conversion

% initial guess
delta0 = -5;
delta_r0 = 0;
Vbh0 = 10;
x0 = [delta0 delta_r0 Vbh0];

% defining the system to solve
systemFunction = @(x) ...
   computeLoads(Vwt, beta_t, delta_s, x(1), x(2), x(3));

% system solving
[x,fval,exitflag,output] = fsolve(systemFunction, x0);

%% Plots
if plotFlags(1)
    plotConditions(Vwt, beta_t, delta_s);
end

if plotFlags(2)
    plotLoads(x(1), delta_s, x(2), beta_t, Vwt, x(3));
    
    fprintf("\n- Final vector function value :\n");
    fprintf("\tFx\t=\t%.3f\tN\n\tFy\t=\t%.3f\tN\n\tMz\t=\t%.3f\tNm\n", ...
        fval(1), fval(2), fval(3));
    
    fprintf("\n- Parameters :\n");
    fprintf("\tdelta\t=\t%.2f\tdeg\n", x(1));
    fprintf("\tdelta_r\t=\t%.2f\tdeg\n", x(2));
    fprintf("\tVbh\t=\t%.2f\tm/s\n", x(3));
end
