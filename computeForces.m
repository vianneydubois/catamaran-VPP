function [F_s, F_d, F_r, F_h] = computeForces(...
    delta, delta_r, beta, delta_s, q_h, q_a)
%computes the forces on the the sail, daggerboards and rudders

%% definitions
% F_r and F_d accounts for only one daggerboard and one rudder respectively
% delta : hydro sideslip angle (relative to the water)
% delta_r : deflection of the rudder
% q_h : hydro dynamic pressure = 1/2 rho_h V_h^2

% F_s : sail force vector
% beta : apparent wind direction
% delta_s : sail setting angle
% q_a : aero dynamic pressure = 1/2 rho_a V_r^2

% each force is given as a vector in the body frame
%%
run geometry.m
run daggerboardHydro.m
run rudderHydro.m
run hullHydro.m
run sailAero.m

%% TRANSITION MATRICES
% From body frame to hydro frame
P_b_h = [   cosd(delta) -sind(delta)    0
            sind(delta) cosd(delta)     0
            0           0               1
        ];

% From body frame to aero frame
P_b_a = [   cosd(beta)  -sind(beta) 0
            sind(beta)  cosd(beta)  0
            0           0           1
       ];

%% SAIL
s_aoa = delta_s - beta;
s_CL = s_CL_alpha * deg2rad(s_aoa - s_alpha0);
s_CD = s_CD0 + s_Ki * s_CL^2;

F_s = P_b_a * (q_a*s_area) * [-s_CD s_CL 0]';

%% DAGGERBOARD
d_aoa = -delta;
d_CL = d_CL_alpha * deg2rad(d_aoa - d_alpha0);
d_CD = d_CD0 + d_Ki * d_CL^2;

F_d = P_b_h * (q_h*d_area) * [-d_CD d_CL 0]';

%% RUDDER
r_aoa = delta_r - delta;
r_CL = r_CL_alpha * deg2rad(r_aoa - r_alpha0);
r_CD = r_CD0 + r_Ki*r_CL^2;

F_r = P_b_h * (q_h*r_area) * [-r_CD r_CL 0]';

%% HULLS
h_CL = 0;
h_CD = h_CD0;

F_h = P_b_h * (q_h*h_refArea) * [-h_CD h_CL 0]';


end
