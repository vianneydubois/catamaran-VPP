b_mass_empty = 140;
b_mass_crew = 130;
b_mass = b_mass_empty + b_mass_crew;

%% CG location

b_cg = [0 0 0]; % Xcg Ycg Zcg

%% Weight
b_W = [0 0 b_mass*9.81];