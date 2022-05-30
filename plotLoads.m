function [] = plotLoads(delta, delta_s, delta_r, beta_t, Vwt, Vbh)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

run environment.m

%% computing apparent wind
% in the hydro frame
[Vwa, theta] = windTriangle(Vwt, beta_t, Vbh);
% adding the drifting angle delta to convert to the body frame
beta = theta + delta;

%% dynamic pressures
q_a = 0.5 * rho_a * Vwa^2;
q_h = 0.5 * rho_w * Vbh^2;

%% computing forces
[Fs, Fd, Fr, Fh] = computeForces(...
    delta, delta_r, beta, delta_s, q_h, q_a);
% accounting for the 2 hulls/daggerboards/rudders
Fd_tot = 2*Fd;
Fr_tot = 2*Fr;
Fh_tot = 2*Fh;

Ftot = Fs + Fd_tot + Fr_tot + Fh_tot;

%% computing loads
[Ms, Md, Mr, Mh] = computeMoments(Fs, Fd, Fr, Fh, delta_s, delta_r);
% total yawing moment aroud the cg
Mtot = Ms + Md + Mr + Mh;
Mz = Mtot(3);

%% PLOTS

% normalising force vectors
F_norm = max([norm(Fs) norm(Fd_tot) norm(Fr_tot) norm(Fh_tot) norm(Ftot)]);
Fs_norm = Fs./F_norm;
Fd_norm = Fd_tot./F_norm;
Fr_norm = Fr_tot./F_norm;
Fh_norm = Fh_tot./F_norm;
Ftot_norm = Ftot./F_norm;

drawArrow = @(a,b,varargin) ...
    quiver(a(1),a(2),b(1)-a(1),b(2)-a(2),0,varargin{:});

fontSize = 18;
arrowsHeadSize = 0.2;
figure('Name', 'Final state');
hold on;

% sail position
plot([-0.8*cosd(delta_s) 0], [-0.8*sind(delta_s) 0], ...
    'linewidth',1,'color',[0.7 0.7 0.7], 'linewidth',4);

% x_b unit vector
drawArrow([0 0], [1 0], 'linewidth',1,'color','k', ...
    'MaxHeadSize', arrowsHeadSize/norm([1 0]));

text(1+0.05, 0, '\itx_b','FontSize',fontSize);

% y_b unit vector
drawArrow([0 0], [0 1], 'linewidth',1,'color','k', ...
    'MaxHeadSize', arrowsHeadSize/norm([1 0]));

text(0.05, 1-0.1, '\ity_b','FontSize',fontSize);

% x_h unit vector
drawArrow([0 0], [cosd(delta), sind(delta)], 'linewidth',1,'color',[0 0 0.9], ...
    'MaxHeadSize', arrowsHeadSize/norm([cosd(delta), sind(delta)]));

text(cosd(delta)+0.05, sind(delta), '\itx_h','FontSize',fontSize, ...
    'color',[0 0 0.9]);

% sail force
drawArrow([0 0], Fs_norm,'linewidth',5,'color',[0.3 0.7 0.9], ...
    'MaxHeadSize', arrowsHeadSize/norm(Fs_norm));

text(Fs_norm(1)/2+0.05, Fs_norm(2)/2, '\itF_s','FontSize',fontSize, ...
    'color', [0.3 0.7 0.9]);

% daggerboards force
drawArrow([0 0], Fd_norm,'linewidth',5,'color',[0.9 0.3 0.1], ...
    'MaxHeadSize', arrowsHeadSize/norm(Fd_norm));

text(Fd_norm(1)/2+0.05, Fd_norm(2)/2, '\itF_d','FontSize',fontSize, ...
    'color', [0.9 0.3 0.1]);

% rudders force
drawArrow([0 0], Fr_norm,'linewidth',5,'color',[0.5 0.7 0.2], ...
    'MaxHeadSize', arrowsHeadSize/norm(Fr_norm));

text(Fr_norm(1)/2+0.05, Fr_norm(2)/2, '\itF_r','FontSize',fontSize, ...
    'color', [0.5 0.7 0.2]);

% hull force
drawArrow([0 0], Fh_norm,'linewidth',5,'color',[0.4 0.4 0.4], ...
    'MaxHeadSize', arrowsHeadSize/norm(Fh_norm));

text(Fh_norm(1), Fh_norm(2)/2-0.1, '\itF_h','FontSize',fontSize, ...
    'color', [0.4 0.4 0.4]);

% total force and yawing moment
% display the force vector only if it is not null
if (norm(Ftot) > 0.1)
    drawArrow([0 0], Ftot_norm,'linewidth',5,'color',[1 0 0], ...
        'MaxHeadSize', arrowsHeadSize/norm(Ftot_norm));
    text(Ftot_norm(1)+0.05, Ftot_norm(2)/2, '\Sigma\it{F}', ...
        'FontSize',fontSize, 'color', [1 0 0]);
end

FtotText = sprintf('\\Sigma\\it{F}\\rm = %.1f N', norm(Ftot));
MzText = sprintf('\\itM_z\\rm = %.1f Nm', Mz);
text(-0.9, -0.9, {FtotText, MzText},'FontSize',fontSize, 'color', [1 0 0]);


% apparent wind
appWindArrowSize = arrowsHeadSize/norm([cosd(beta) sind(beta)]);
drawArrow([cosd(beta) sind(beta)], [0 0],'linewidth',3,'color',[1 0.6 0.2], ...
    'MaxHeadSize', appWindArrowSize);

appWindText = sprintf('\\it V_{app} \\rm= %.1f kts', Vwa*3.6/1.852);
text(cosd(beta)/2+0.05, sind(beta)/2, appWindText, ...
    'FontSize',fontSize, 'color', [1 0.6 0.2]);

% boat speed
text(+0.2, -0.9, sprintf('\\itV_{boat}\\rm = %.1f kts', Vbh*3.6/1.852), ...
    'FontSize',fontSize, 'color', [1 0 0]);


% backgroung image
%h = image([-0.9 0.9],[-0.9 0.9],imread('top_view.png'));
h = image([-1 1],[-1 1],imread('top_view.png'));
uistack(h,'bottom');

xlim([-1, 1]);
ylim([-1.1, 1.1]);
axis equal;
set(gca, 'YDir', 'reverse');

    
end

