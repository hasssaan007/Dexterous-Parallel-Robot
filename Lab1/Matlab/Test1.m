% Define the dimensions of the base and the links
L1 = 2.5; % Length of base in X-direction
L4 = 2; % Length of base in Y-direction
L = 3;  % Length of the first link
L2 = 2; % Length of the second link
L3 = 1.5; % Length of the third link
P1 = [L1/2, L4/2, 0]; % Point P1 (center of the rectangle)

% Define the initial joint positions
base_points = [
    0, 0, 0;      % Bottom-left corner
    L1, 0, 0;     % Bottom-right corner
    L1, L4, 0;     % Top-right corner
    0, L4, 0;     % Top-left corner
];

% Link L is placed next to the left side of the rectangle
link_L_start = base_points(1, :);
link_L_end = link_L_start + [-3, 0, 0]; % L link along the X-direction

% Link L2 connected to the other side of the L joint
link_L2_start = link_L_end;
link_L2_end = link_L2_start + [0, L2, 0]; % L2 along the Y-direction

% Link L3 connected to the other joint of L2
link_L3_start = link_L2_end;
link_L3_end = link_L3_start + [-12, -6, -9]; % L3 along the X-direction

% Plotting the base (rectangle)
figure;
hold on;
grid on;
axis equal;
xlabel('X');
ylabel('Y');
zlabel('Z');

% Plot the base as a rectangle (4 edges)
for i = 1:4
    plot3([base_points(i, 1), base_points(mod(i, 4) + 1, 1)], ...
          [base_points(i, 2), base_points(mod(i, 4) + 1, 2)], ...
          [base_points(i, 3), base_points(mod(i, 4) + 1, 3)], 'k-', 'LineWidth', 2);
end

% Plot the link L
plot3([link_L_start(1), link_L_end(1)], ...
      [link_L_start(2), link_L_end(2)], ...
      [link_L_start(3), link_L_end(3)], 'b-', 'LineWidth', 2);

% Plot the link L2
plot3([link_L2_start(1), link_L2_end(1)], ...
      [link_L2_start(2), link_L2_end(2)], ...
      [link_L2_start(3), link_L2_end(3)], 'g-', 'LineWidth', 2);

% Plot the link L3
plot3([link_L3_start(1), link_L3_end(1)], ...
      [link_L3_start(2), link_L3_end(2)], ...
      [link_L3_start(3), link_L3_end(3)], 'r-', 'LineWidth', 2);

% Plot the rotating joint A1 at P1
plot3(P1(1), P1(2), P1(3), 'ro', 'MarkerFaceColor', 'r');

% Optional: Mark joints
plot3(link_L_start(1), link_L_start(2), link_L_start(3), 'bo', 'MarkerFaceColor', 'b'); % Joint 1
plot3(link_L_end(1), link_L_end(2), link_L_end(3), 'bo', 'MarkerFaceColor', 'b'); % Joint 2
plot3(link_L2_end(1), link_L2_end(2), link_L2_end(3), 'bo', 'MarkerFaceColor', 'b'); % Joint 3
plot3(link_L3_end(1), link_L3_end(2), link_L3_end(3), 'bo', 'MarkerFaceColor', 'b'); % Joint 4

% Adjust the view
view(3);
