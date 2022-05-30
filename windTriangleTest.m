% true wind
Vwt = 15;
theta_t = 90; %deg

% relative wind
Vwr = 7;

% apparent wind :
[Vwa, theta_a] = windTriangle(Vwt, theta_t, Vwr);

fprintf('Vwa = %.1f knots\ntheta_a = %.1f deg\n', Vwa, theta_a);

figure('Name', 'Wind triangle');
hold on

plot([0, 0], [0, Vwr], 'LineWidth', 2, 'Color', 'red');
plot([0, 0], [-Vwr, 0], '--r');

plot([0, Vwt*sind(theta_t)], [0, Vwt*cosd(theta_t)], ...
    'LineWidth', 2, 'Color', 'blue');
plot([0, Vwa*sind(theta_a)], [0, Vwa*cosd(theta_a)], ...
    'LineWidth', 2, 'Color', 'black');
plot([0, Vwa*sind(theta_a)], [-Vwr, -Vwr+Vwa*cosd(theta_a)], ...
    '--k');
axis('equal')