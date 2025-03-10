clc; clear; close all;

% Define square side length
L_square = 3; 

% Define lines in 2D (XY plane, next to the square)
l = L_square; 
l_1 = l/2; 
l_2 = L_square; 
l_3 = 6 * L_square;

a_i = l + l_1; 
q_i = linspace(0, 2 * pi, 45);

% Define square vertices (centered at origin)
vertices = [-L_square/2 -L_square/2 0; 
             L_square/2 -L_square/2 0;
             L_square/2  L_square/2 0;
            -L_square/2  L_square/2 0];

% Define square edges (connectivity matrix)
edges = [1 2; 2 3; 3 4; 4 1];

% Initialize figure
figure;
hold on; axis equal; grid on;
xlabel('X'); ylabel('Y'); zlabel('Z');
view(3);
title('2D 6-DOF Redundant Dexterous Parallel Robot in 3D plane');

% Plot the initial square
h_lines = gobjects(size(edges,1), 1);
for i = 1:size(edges, 1)
    h_lines(i) = plot3(vertices(edges(i,:), 1), vertices(edges(i,:), 2), vertices(edges(i,:), 3), 'k', 'LineWidth', 2);
end

% Plot lines connected to square and each other
center = [0 2 2];
square_side_center = [1.5 L_square/2 0];
plot3([square_side_center(1) l], [square_side_center(2) l_1], [square_side_center(3) 0], 'g-', 'LineWidth', 2);
plot3([l l], [-l_1 0], [0 0], 'm-', 'LineWidth', 2);
plot3([l l_3], [l_1 -l_1], [l_2 -l_2], 'b-', 'LineWidth', 2);

% Scatter plot for workspace points
h_workspace = scatter3([], [], [], 10, 'r', 'filled');

% Number of frames for animation
num_frames = 200;
workspace = [];

hold off;
