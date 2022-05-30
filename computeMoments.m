function [Ms, Md, Mr, Mh] = computeMoments(Fs, Fd, Fr, Fh, ...
    delta_s, delta_r)
% computes the yawing moments around the CG

run mass.m
run geometry.m

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

d_OP = d_le_root + [-1/3 * d_MAC 0 1/2*d_length];
d_GP = -GO + d_OP;

% rudder (appl. point is considered at 1/3 of the MAC (@ aero centre))
r_taper = r_tip/r_root;
r_MAC = 2/3 * r_root * (1+r_taper+r_taper^2) / (1+r_taper);

r_OP = r_le_root - 1/3 * r_MAC * [cosd(-delta_r) sind(-delta_r) 0] ...
    + [0 0 1/2*r_length];
r_GP = -GO + r_OP;

% hulls yawing moments are negligated

%% Yawing moments
Ms = cross(s_GP, Fs)';
Md = 2 * cross(d_GP, Fd)';
Mr = 2 * cross(r_GP, Fr)';
Mh = 2 * 0 * Fh;

end