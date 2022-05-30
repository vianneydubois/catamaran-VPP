clear
run environment.m

%% initial conditions

% true wind
Vwt = 10; % m/s
beta_t = 70; % deg

% boat speed
Vbh = 9.1; % m/s
% boat drifting angle
delta = -5.1; %deg
% rudder deflection
delta_r = 0; % deg

% sail setting
delta_s = 25; % deg


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
fprintf("\tFx = %.1f N\n", Ftot(1));
fprintf("\tFy = %.1f N\n", Ftot(2));

%% computing moments

[Ms, Md, Mr, Mh] = computeMoments(Fs, Fd, Fr, Fh, delta_s, delta_r);

Mtot = Ms + Md + Mr + Mh;
fprintf("\tMz = %.1f Nm\n", Mtot(3));

