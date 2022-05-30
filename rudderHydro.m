% run geometry.m

r_oswald_e = 0.8;

%% 2D AIRFOIL
r_Cl_alpha = 2*pi;

%% 3D LIFT
r_AR = r_length^2/r_area;
r_alpha0 = 0;
r_CL_alpha = r_Cl_alpha/(1+r_Cl_alpha/(pi*r_AR));

%% DRAG

% Parasitic drag
r_CD0 = 0.050;

% Induced drag
r_Ki = 1/(pi*r_AR*r_oswald_e);
