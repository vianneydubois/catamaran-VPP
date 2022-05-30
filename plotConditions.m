function [] = plotConditions(Vwt, beta_t, delta_s)
%plotConditions Plots the true wind vector and sail angle

drawArrow = @(a,b,varargin) quiver(a(1),a(2),b(1)-a(1),b(2)-a(2),0,varargin{:});


fontSize = 18;
arrowsHeadSize = 0.2;
figure('Name', 'Initial conditions');
hold on;

% sail position
plot([-0.8*cosd(delta_s) 0], [-0.8*sind(delta_s) 0], ...
    'color',[0.6 0.6 0.6], 'linewidth',4);

sailAngleText = sprintf('\\it\\delta_s\\rm = %.1f deg', delta_s);
text(-0.9, -0.9, sailAngleText,'FontSize',fontSize, 'color', [1 0 0]);


% x_b unit vector
drawArrow([0 0], [1 0], 'linewidth',1,'color','k', ...
    'MaxHeadSize', arrowsHeadSize/norm([1 0]));

text(1+0.05, 0, '\itx_b','FontSize',fontSize);

% y_b unit vector
drawArrow([0 0], [0 1], 'linewidth',1,'color','k', ...
    'MaxHeadSize', arrowsHeadSize/norm([1 0]));

text(0.05, 1-0.1, '\ity_b','FontSize',fontSize);

% true wind
trueWindArrowSize = arrowsHeadSize/norm([cosd(beta_t) sind(beta_t)]);
drawArrow([cosd(beta_t) sind(beta_t)], [0 0],'linewidth',3, ...
    'color',[1 0.6 0.2], 'MaxHeadSize', trueWindArrowSize);

trueWindText = sprintf('\\it V_{true} \\rm= %.1f kts', Vwt*3.6/1.852);
text(cosd(beta_t)/2+0.05, sind(beta_t)/2, trueWindText, ...
    'FontSize',fontSize, 'color', [1 0.6 0.2]);

xlim([-1, 1]);
ylim([-1, 1]);
axis equal;
set(gca, 'YDir', 'reverse');


% backgroung image
h = image([-0.9 0.9],[-0.9 0.9],imread('top_view.png'));
uistack(h,'bottom')
end

