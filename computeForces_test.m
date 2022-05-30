clear
run environment.m

%% initial conditions

% true wind
Vwt = 15; % m/s
beta_t = 80; % deg

% boat speed
Vbh = 7; % m/s

% settings
delta_s = 25; % deg
delta_r = 0; % deg

% boat drifting angle
delta = -2; %deg


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

%% PLOTS
plotFlags = [1, 0]; % [Forces, Wind]

% normalising force vectors
F_norm = max([norm(Fs) norm(Fd_tot) norm(Fr_tot) norm(Fh_tot) norm(Ftot)]);
Fs_norm = Fs./F_norm;
Fd_norm = Fd_tot./F_norm;
Fr_norm = Fr_tot./F_norm;
Fh_norm = Fh_tot./F_norm;
Ftot_norm = Ftot./F_norm;

drawArrow = @(a,b,varargin) quiver(a(1),a(2),b(1)-a(1),b(2)-a(2),0,varargin{:});

if plotFlags(1)
    fontSize = 18;
    arrowsHeadSize = 0.2;
    figure('Name', 'Forces');
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
    text(cosd(delta)+0.05, sind(delta), '\itx_h','FontSize',fontSize,'color',[0 0 0.9]);
    
    % forces
    drawArrow([0 0], Fs_norm,'linewidth',5,'color',[0.3 0.7 0.9], ...
        'MaxHeadSize', arrowsHeadSize/norm(Fs_norm));
    text(Fs_norm(1)/2+0.05, Fs_norm(2)/2, '\itF_s','FontSize',fontSize, 'color', [0.3 0.7 0.9]);
    
    drawArrow([0 0], Fd_norm,'linewidth',5,'color',[0.9 0.3 0.1], ...
        'MaxHeadSize', arrowsHeadSize/norm(Fd_norm));
    text(Fd_norm(1)/2+0.05, Fd_norm(2)/2, '\itF_d','FontSize',fontSize, 'color', [0.9 0.3 0.1]);

    drawArrow([0 0], Fr_norm,'linewidth',5,'color',[0.5 0.7 0.2], ...
        'MaxHeadSize', arrowsHeadSize/norm(Fr_norm));
    text(Fr_norm(1)/2+0.05, Fr_norm(2)/2, '\itF_r','FontSize',fontSize, 'color', [0.5 0.7 0.2]);
    
    drawArrow([0 0], Fh_norm,'linewidth',5,'color',[0.4 0.4 0.4], ...
        'MaxHeadSize', arrowsHeadSize/norm(Fh_norm));
    text(Fh_norm(1), Fh_norm(2)/2-0.1, '\itF_h','FontSize',fontSize, 'color', [0.4 0.4 0.4]);
    
    drawArrow([0 0], Ftot_norm,'linewidth',5,'color',[1 0 0], ...
        'MaxHeadSize', arrowsHeadSize/norm(Fh_norm));
    text(Ftot_norm(1)+0.05, Ftot_norm(2)/2, '\Sigma\it{F}','FontSize',fontSize, 'color', [1 0 0]);
    
    % apparent wind
    drawArrow([cosd(beta) sind(beta)], [0 0],'linewidth',3,'color',[1 0.6 0.2], ...
        'MaxHeadSize', arrowsHeadSize/norm([cosd(beta) sind(beta)]));
    text(cosd(beta)/2+0.05, sind(beta)/2, '\itV_{app}','FontSize',fontSize, 'color', [1 0.6 0.2]);
    
    xlim([-1, 1]);
    ylim([-1, 1]);
    axis equal;
    set(gca, 'YDir', 'reverse');

    
    % backgroung image
    h = image([-0.9 0.9],[-0.9 0.9],imread('top_view.png')); 
    uistack(h,'bottom')
end

if plotFlags(2)
    figure('Name', 'Wind');
    hold on;
    drawArrow([Vwt*sind(beta_t+delta) Vwt*cosd(beta_t+delta)], [0, 0],'color','r');
    drawArrow([Vwa*sind(beta) Vwa*cosd(beta)], [0, 0],'color','b');
    drawArrow([Vbh*sind(delta) Vbh*cosd(delta)], [0, 0],'color',[0 0.5 0]);
    axis equal;
end
