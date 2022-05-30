function [V_app, beta_app] = windTriangle(V_true, beta_true, V_rel)
% Computes apparent wind speed and direction from true and relative wind
% speeds and orientation

V_app = sqrt(V_rel^2 + V_true^2 + 2*V_rel*V_true*cosd(beta_true));

beta_app = rad2deg(atan2(V_true*sind(beta_true), V_rel+V_true*cosd(beta_true)));

end