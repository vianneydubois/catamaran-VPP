clear;
run geometry.m
run mass.m
%% flags

plotFlags.plot2d = 0;
plotFlags.plot3d = 1;


%% 2D PLOTS
if plotFlags.plot2d
    figure('Name', '2D geometry');
    hold on;
    
    plot(polyshape(s_x, s_z), 'FaceColor', [0.3 0.7 0.9]);
    plot(polyshape(d_x, d_z), 'FaceColor', [0.9 0.3 0.1]);
    plot(polyshape(r_x, r_z), 'FaceColor', [0.5 0.7 0.2]);
    plot(polyshape(h_x, h_z), 'FaceColor', [0.9 0.9 0.9]);
    
    hold off;
    axis equal;
    grid;
    set(gca, 'XDir','reverse', 'YDir', 'reverse');
end

%% 3D PLOTS
if plotFlags.plot3d
    figure('Name', '3D geometry');
    % SAIL
    fill3(s_x, s_y, s_z, [0.3 0.7 0.9]);
    hold on
    
    % DAGGERBOARDS
    fill3(d_x, d_y, d_z, [0.9 0.3 0.1]);
    fill3(d_x, -d_y, d_z, [0.9 0.3 0.1]);
    
    % RUDDERS
    fill3(r_x, r_y, r_z, [0.5 0.7 0.2]);
    fill3(r_x_port, r_y_port, r_z_port, [0.5 0.7 0.2]);
    
    % HULLS
    fill3(h_x, h_y, h_z, [0.9 0.9 0.9]);
    fill3(h_x, -h_y, h_z, [0.9 0.9 0.9]);
    
    % WEIGHT
    quiver3(b_cg(1), b_cg(2), b_cg(3), b_W(1)/1000, b_W(2)/1000, b_W(3)/1000, ...
        'color', 'black', 'LineWidth', 3);
    
    hold off;
    axis equal;
    grid;
    set(gca, 'XDir','reverse', 'YDir', 'reverse', 'Zdir', 'reverse');
end