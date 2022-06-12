clear;

tws = 10; %                         true wind speed [KNOTS]
%twaRange = [30 45 60 75 90]; %     true wind angle [DEGREEES]
% twaRange = [
twaRange = [40, 50, 60, 70, 80, 90, 110, 135, 160, 180];
delta_s = 25;

Nrange = length(twaRange);

resList = zeros(Nrange,4);
resList(:,1) = twaRange';


for i = 1:Nrange
    beta_t = twaRange(i);
    Vwt = tws;
    [resList(i,2:end),] = systemSolving(Vwt, beta_t, delta_s);
end

resList(:,4) = resList(:,4) .* 3.6 ./ 1.852; % m/s to knots conversion

%% plots
ax = polaraxes;
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
hold(ax, 'on');
polarplot(deg2rad(twaRange), resList(:,4), 'b-o');
