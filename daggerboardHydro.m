% run geometry.m

d_oswald_e = 0.8;

%% 2D AIRFOIL
d_Cl_alpha = 2*pi;
d_t_c = 0.12; %thickness ratio

%% 3D LIFT
d_AR = d_length^2/d_area;
d_alpha0 = 0;
d_CL_alpha = d_Cl_alpha/(1+d_Cl_alpha/(pi*d_AR));


%% Parasitic drag
% % Based on Raymer - method for conceptual aircraft design
% 
% % Form factor
% FF = 1;
% 
% %
% 
% 
% % Friction coefficient
% roughness = 0.052e-5;
% Recutoff = 38.21*(d_root/roughness)^1.053;
% Reactual = reynolds(rho_w, V_b_w, d_root, mu_w);
% if Recutoff<Reactual
%     Cf = 0;
% else
%     Cf = 0;
% end

%% DRAG

% Parasitic drag
d_CD0 = 0.050;

% Induced drag
d_Ki = 1/(pi*d_AR*d_oswald_e);
