clc; clear; close all;

% Define a square in 2D (XY plane, centered at origin)
L = 2; % Side length of square
vertices = [-L/2 -L/2 0;  L/2 -L/2 0;  L/2  L/2 0; -L/2  L/2 0];

% Define square edges (connectivity matrix)
edges = [1 2; 2 3; 3 4; 4 1];

% Initialize figure
figure;
hold on; axis equal; grid on;
xlabel('X'); ylabel('Y'); zlabel('Z');
view(3);
title('2D Square Rotating in 3D Around Origin');

% Plot the initial square
h_lines = gobjects(size(edges,1),1);
for i = 1:size(edges,1)
    h_lines(i) = plot3(vertices(edges(i,:),1), vertices(edges(i,:),2), vertices(edges(i,:),3), 'k', 'LineWidth', 2);
end

% Scatter plot for workspace points
h_workspace = scatter3([], [], [], 10, 'r', 'filled');

% Number of frames for animation
num_frames = 200;
workspace = [];

% Define cumulative rotation angles
theta_x = 0; theta_y = 0; theta_z = 0;

for i = 1:num_frames
    % Increment rotation angles smoothly
    theta_x = theta_x + 2; % Steady rotation around X-axis
    theta_y = theta_y + 1.5; % Steady rotation around Y-axis
    theta_z = theta_z + 1; % Steady rotation around Z-axis

    % Create cumulative rotation matrices
    Rx = [1 0 0; 0 cosd(theta_x) -sind(theta_x); 0 sind(theta_x) cosd(theta_x)];
    Ry = [cosd(theta_y) 0 sind(theta_y); 0 1 0; -sind(theta_y) 0 cosd(theta_y)];
    Rz = [cosd(theta_z) -sind(theta_z) 0; sind(theta_z) cosd(theta_z) 0; 0 0 1];

    % Apply combined rotations
    rotated_vertices = (Rz * Ry * Rx * vertices')';

    % Store rotated edge points in workspace
    workspace = [workspace; rotated_vertices];

    % Update square plot
    for j = 1:size(edges,1)
        set(h_lines(j), 'XData', rotated_vertices(edges(j,:),1), ...
                        'YData', rotated_vertices(edges(j,:),2), ...
                        'ZData', rotated_vertices(edges(j,:),3));
    end

    % Update workspace points plot
    set(h_workspace, 'XData', workspace(:,1), 'YData', workspace(:,2), 'ZData', workspace(:,3));

    % Pause for visualization
    pause(0.05);
end