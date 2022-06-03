clear;

run mass.m
run geometry.m

delta_s = 25;
delta_r = 50;


%% Computing distances from CG to the forces application points
% OP -  distance from the geometry ref point ("O") to the force application
%       point ("P")
% GP -  distance from the CG ("G") to the force application point ("P")
GO = -b_cg;

% sail (application point is considered at 1/3 of the MAC (@ aero centre))
s_taper = s_tip/s_foot;
s_MAC = 2/3 * s_foot * (1+s_taper+s_taper^2) / (1+s_taper);

s_OP = -1/3*s_MAC*[cosd(delta_s) sind(delta_s) 0] ...
    + [0 0 -0.5*s_luff+s_tack(3)];
s_GP = -GO + s_OP;

% daggerboard (appl. point is considered at 1/3 of the MAC (@ aero centre))
d_taper = d_tip/d_root;
d_MAC = 2/3 * d_root * (1+d_taper+d_taper^2) / (1+d_taper);
% port daggerboard
d_OP_p = d_le_root + [-1/3 * d_MAC 0 1/2*d_length];
d_GP_p = -GO + d_OP_p;
% starboard daggerboard
d_OP_s = d_le_root .*[1 -1 1] + [-1/3 * d_MAC 0 1/2*d_length];
d_GP_s = -GO + d_OP_s;

% rudder (appl. point is considered at 1/3 of the MAC (@ aero centre))
r_taper = r_tip/r_root;
r_MAC = 2/3 * r_root * (1+r_taper+r_taper^2) / (1+r_taper);
% port rudder
r_OP_p = r_le_root - 1/3 * r_MAC * [cosd(-delta_r) sind(-delta_r) 0] ...
    + [0 0 1/2*r_length];
r_GP_p = -GO + r_OP_p;
% starboard rudder
r_OP_s = r_le_root .* [1 -1 1] - 1/3 * r_MAC * [cosd(-delta_r) sind(-delta_r) 0] ...
    + [0 0 1/2*r_length];
r_GP_s = -GO + r_OP_s;


%% 3D PLOT
figure('Name', '3D geometry');

% SAIL
fill3(s_x, s_y, s_z, [0.3 0.7 0.9]);
hold on

% DAGGERBOARDS
fill3(d_x, d_y, d_z, [0.8 0.5 0.4]);
fill3(d_x, -d_y, d_z, [0.8 0.5 0.4]);

% RUDDERS
fill3(r_x, r_y, r_z, [0.5 0.7 0.2]);
fill3(r_x_port, r_y_port, r_z_port, [0.5 0.7 0.2]);

% HULLS
fill3(h_x, h_y, h_z, [0.9 0.9 0.9]);
fill3(h_x, -h_y, h_z, [0.9 0.9 0.9]);

% WEIGHT
quiver3(b_cg(1), b_cg(2), b_cg(3), b_W(1)/1000, b_W(2)/1000, b_W(3)/1000, 'color', 'black', 'LineWidth', 1.5);

% FORCE APPLICATION POINTS
plot3(s_OP(1),s_OP(2),s_OP(3), 'k.','MarkerSize',10);

plot3(d_OP_p(1),d_OP_p(2),d_OP_p(3), 'r.','MarkerSize',10);
plot3(d_OP_s(1),d_OP_s(2),d_OP_s(3), 'g.','MarkerSize',10);

plot3(r_OP_p(1),r_OP_p(2),r_OP_p(3), 'r.','MarkerSize',10);
plot3(r_OP_p(1),r_OP_s(2),r_OP_s(3), 'g.','MarkerSize',10);

hold off;
xlim([-10 10]);
axis equal;
grid;
set(gca, 'XDir','reverse', 'YDir', 'reverse', 'Zdir', 'reverse');
