run geometry.m

s_oswald_e = 0.7; %?


%% 2D AIRFOIL
s_Cl_alpha = 2*pi;
s_alpha0_airfoil = -2.5;

%% 3D CORRECTIONS
s_AR = s_luff^2/s_area; % aspect ratio

s_alpha0 = s_alpha0_airfoil;
% s_alpha0 = s_alpha0_airfoil - s_twist_angle/2; % zero lift AoA, see Raymer

s_CL_alpha = s_Cl_alpha/(1+s_Cl_alpha/(pi*s_AR)); %S. Gudmundsson, p.345
%s_CL_alpha = 2*pi*s_AR/(2+sqrt(s_AR^2+4)); % S. Gudmundsson, p.346


%% DRAG

% Parasitic drag
s_CD0 = 0.02;

% Induced drag
s_Ki = 1/(pi*s_AR*s_oswald_e);
