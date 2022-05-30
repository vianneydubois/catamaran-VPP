function y = computeLoads(Vwt, beta_t, delta_s, ...
    delta, delta_r, Vbh)
%COMPUTELOADS compute total 2D forces and yawing moment around the CG
%   Used to solve for delta, delta_r and Vbh in given wind conditions
%
%   All speeds in   m/s = meters/second
%   All angles in   deg = degrees

% load air and water properties
run environment.m

%% computing apparent wind
% in the hydro frame
[Vwa, theta] = windTriangle(Vwt, beta_t, Vbh);
% adding the drifting angle delta to convert to the body frame
beta = theta + delta;

%% dynamic pressures
q_a = 0.5 * rho_a * Vwa^2;
q_h = 0.5 * rho_w * Vbh^2;

%% computing forces
[Fs, Fd, Fr, Fh] = computeForces(...
    delta, delta_r, beta, delta_s, q_h, q_a);

% accounting for the 2 hulls/daggerboards/rudders
Fd_tot = 2*Fd;
Fr_tot = 2*Fr;
Fh_tot = 2*Fh;

Ftot = Fs + Fd_tot + Fr_tot + Fh_tot;
Fx = Ftot(1);
Fy = Ftot(2);

%% computing moments
[Ms, Md, Mr, Mh] = computeMoments(Fs, Fd, Fr, Fh, delta_s, delta_r);
% total yawing moment aroud the cg
Mtot = Ms + Md + Mr + Mh;
Mz = Mtot(3);


y = [Fx,Fy,Mz];
end

