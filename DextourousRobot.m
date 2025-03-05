clc;
clear;
close all;

%% 1) Configuration de la figure et de l'espace 3D
figure('Name','Système Robotisé - Axes parallèles, un seul point de contact par axe','NumberTitle','off');
hold on;
grid on;
axis equal;
xlabel('X-axis'); ylabel('Y-axis'); zlabel('Z-axis');
title('Moteurs, Équerres parallèles, Plateforme & Axes (un coin par axe)');

xlim([-10,10]); ylim([-10,10]); zlim([0,12]);

% Repères
quiver3(0,0,0, 5,0,0, 'r', 'LineWidth',2);
quiver3(0,0,0, 0,5,0, 'g', 'LineWidth',2);
quiver3(0,0,0, 0,0,5, 'b', 'LineWidth',2);

%% 2) Moteurs (empilés sur Z)
num_motors  = 8;
z_spacing   = 0.5;
motor_radius = 2;
theta       = linspace(0, 2*pi, 100);
colors      = lines(num_motors);

motor_positions = zeros(num_motors,3);
for i = 1:num_motors
    motor_positions(i,:) = [0, 0, (i-1)*z_spacing];
    
    % Cercle représentant le moteur
    x_circ = motor_positions(i,1) + motor_radius*cos(theta);
    y_circ = motor_positions(i,2) + motor_radius*sin(theta);
    z_circ = ones(size(theta)) * motor_positions(i,3);
    fill3(x_circ, y_circ, z_circ, colors(i,:), ...
          'FaceAlpha',0.6, 'EdgeColor','k', 'LineWidth',1.5);
end

%% 3) Équerres parallèles
% On choisit un décalage constant (0,2,0) pour que toutes les équerres soient parallèles
equerre_offset = [0, 2, 0];
equerre_positions = zeros(num_motors,3);

for i = 1:num_motors
    equerre_positions(i,:) = motor_positions(i,:) + equerre_offset;
    
    % Tracé de l'équerre (ligne verte)
    plot3([motor_positions(i,1), equerre_positions(i,1)], ...
          [motor_positions(i,2), equerre_positions(i,2)], ...
          [motor_positions(i,3), equerre_positions(i,3)], ...
          'g-', 'LineWidth',2);
end

%% 4) Plateforme & Axes (même niveau Z)
% On place la plateforme un peu au-dessus du dernier moteur
platform_z = motor_positions(end,3) + 2;

% Plateforme : rectangle axis-aligné 2x2
corner1 = [-1, -1, platform_z];  % Coin inférieur gauche
corner2 = [ 1, -1, platform_z];  % Coin inférieur droit
corner3 = [ 1,  1, platform_z];  % Coin supérieur droit
corner4 = [-1,  1, platform_z];  % Coin supérieur gauche

% Tracé de la plateforme (bordures plus fines pour ne pas confondre avec les axes)
fill3([corner1(1), corner2(1), corner3(1), corner4(1)], ...
      [corner1(2), corner2(2), corner3(2), corner4(2)], ...
      [corner1(3), corner2(3), corner3(3), corner4(3)], ...
      'c', 'FaceAlpha',0.7, 'EdgeColor',[0.2 0.2 0.2], 'LineWidth',1.5);

%% 5) Axes parallèles (noirs), chacun avec un seul point de contact sur la plateforme
% Axe 1 : part du coin1 (inférieur gauche) et s'étend en X
axis_length = -3;
axis1_start = corner1;
axis1_end   = corner1 + [axis_length, 0, 0];
plot3([axis1_start(1), axis1_end(1)], ...
      [axis1_start(2), axis1_end(2)], ...
      [axis1_start(3), axis1_end(3)], ...
      'k-', 'LineWidth',3);

% Axe 2 : part du coin3 (supérieur droit) et s'étend en X
axis_length2 = 3;
axis2_start = corner3;
axis2_end   = corner3 + [axis_length2, 0, 0];
plot3([axis2_start(1), axis2_end(1)], ...
      [axis2_start(2), axis2_end(2)], ...
      [axis2_start(3), axis2_end(3)], ...
      'k-', 'LineWidth',3);

%% 6) Bras reliant les équerres à la plateforme
% Moteurs 1-4 -> coin1
% Moteurs 5-8 -> coin3
for i = 1:num_motors
    if i <= 4
        % Vers coin1
        plot3([equerre_positions(i,1), corner1(1)], ...
              [equerre_positions(i,2), corner1(2)], ...
              [equerre_positions(i,3), corner1(3)], ...
              'b-', 'LineWidth',2);
    else
        % Vers coin3
        plot3([equerre_positions(i,1), corner3(1)], ...
              [equerre_positions(i,2), corner3(2)], ...
              [equerre_positions(i,3), corner3(3)], ...
              'b-', 'LineWidth',2);
    end
end

%% 7) Affichage final
view(3);
camlight;
lighting gouraud;
hold off;
