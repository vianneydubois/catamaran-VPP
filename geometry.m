% reference point : midpoint of front beam (mast foot junction)
% Ship body frame : Xb : forward, Yb : to starboard, Zb : downwards

%% SETTINGS
s_sheet_angle = 25; %deg
s_twist_angle = 0; %deg MUST BE LATER SET TO s_twist from sail_aero (aeroelasticity?)
r_rudder_angle = 50; %deg

%% SAIL GEOMETRY
s_tack = [0. 0. -0.40]; % Tack corner location
s_luff = 6.0;
s_foot = 1.90;
s_tip = 0.80;

% Flat surface to compute area
s_x = s_tack(1) + [0. 0. -s_tip -s_foot];
s_z = s_tack(3) + [0. -s_luff -s_luff 0.];

s_area = area(polyshape(s_x, s_z));

%% HULLS GEOMETRY
h_width = 0.48;
h_spacing = 2.4 - 2*h_width/2;
h_bow_tip = [2.40 h_spacing/2 0.];
h_length = 4.80;
h_bow_height = 0.40;
h_stern_height = 0.30;
h_max_height = 0.50;
h_rocker_start = 2.70;
h_rocker_end = 3.80;

h_x = h_bow_tip(1) + [0. 0. -h_rocker_start -h_rocker_end -h_length -h_length];
h_y = h_bow_tip(2) + [0. 0. 0. 0. 0. 0.];
h_z = h_bow_tip(3) + [0. h_bow_height h_max_height h_max_height h_stern_height 0.];

%% DAGGERBOARD GEOMETRY
d_le_root = [-0.50 h_spacing/2 0.50];
d_root = 0.25;
d_length = 1.00;
d_tip = 0.25;

d_x = d_le_root(1) + [0. 0. -d_tip -d_root];
d_y = d_le_root(2) + [0. 0. 0. 0.];
d_z = d_le_root(3) + [0. d_length d_length 0.];

d_area = area(polyshape(d_x, d_z));

%% RUDDER GEOMETRY
r_le_root = [h_bow_tip(1)-h_length h_spacing/2 0.30];
r_root = 0.20;
r_length = 0.60;
r_tip = 0.20;

% Flat surface to compute area
r_x = r_le_root(1) + [0. 0. -r_tip -r_root];
r_z = r_le_root(3) + [0. r_length r_length 0.];

r_area = area(polyshape(r_x, r_z));


%% 3D COORDINATES CONSIDERING PREVIOUS SETTINGS

s_x = s_tack(1) + [0. 0. -s_tip*cosd(s_sheet_angle+s_twist_angle) -s_foot*cosd(s_sheet_angle)];
s_y = s_tack(2) + [0. 0. -s_tip*sind(s_sheet_angle+s_twist_angle) -s_foot*sind(s_sheet_angle)];
s_z = s_tack(3) + [0. -s_luff -s_luff 0.];

r_x = r_le_root(1) + [0. 0. -r_tip*cosd(-r_rudder_angle) -r_root*cosd(-r_rudder_angle)];
r_y = r_le_root(2) + [0. 0. -r_tip*sind(-r_rudder_angle) -r_root*sind(-r_rudder_angle)];
r_z = r_le_root(3) + [0. r_length r_length 0.];

r_x_port = r_le_root(1) + [0. 0. -r_tip*cosd(-r_rudder_angle) -r_root*cosd(-r_rudder_angle)];
r_y_port = -r_le_root(2) + [0. 0. -r_tip*sind(-r_rudder_angle) -r_root*sind(-r_rudder_angle)];
r_z_port = r_le_root(3) + [0. r_length r_length 0.];
