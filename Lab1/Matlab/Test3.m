% Define the dimensions of the base and the links
L1 = 2.5; % Length of base in X-direction
L4 = 2;   % Length of base in Y-direction
L = 3;    % Length of the first link
L2 = 2;   % Length of the second link
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

% Link L3 connected to the other joint of L2 (initial position)
link_L3_start = link_L2_end;
link_L3_end = link_L3_start + [0, 0, -L3]; % L3 initial position along the Z-direction

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

% Initial plot of the links
link_L_plot = plot3([link_L_start(1), link_L_end(1)], ...
                    [link_L_start(2), link_L_end(2)], ...
                    [link_L_start(3), link_L_end(3)], 'b-', 'LineWidth', 2);
link_L2_plot = plot3([link_L2_start(1), link_L2_end(1)], ...
                     [link_L2_start(2), link_L2_end(2)], ...
                     [link_L2_start(3), link_L2_end(3)], 'g-', 'LineWidth', 2);
link_L3_plot = plot3([link_L3_start(1), link_L3_end(1)], ...
                     [link_L3_start(2), link_L3_end(2)], ...
                     [link_L3_start(3), link_L3_end(3)], 'r-', 'LineWidth', 2);

% Plot the rotating joint A1 at P1
joint_A1 = plot3(P1(1), P1(2), P1(3), 'ro', 'MarkerFaceColor', 'r');

% Set animation parameters
num_frames = 100; % Number of frames for animation
qi_max = 2 * pi;  % Maximum rotation angle (full rotation)
qi_vals = linspace(0, qi_max, num_frames); % Angle values for each frame

% Set the figure to update in real-time
for i = 1:num_frames
    % Calculate the new angle for the rotation (rotation of L3 around P1)
    q_i = qi_vals(i); % Angle for joint A1 (rotation around P1)
    
    % Rotation matrix for rotating L3 (about an axis)
    % Assume L3 rotates around the Z-axis of P1, you can adjust for any other axis
    R = [cos(q_i), -sin(q_i), 0; 
         sin(q_i), cos(q_i), 0; 
         0, 0, 1]; % Rotation matrix around the Z-axis
    
    % Calculate new position for the end of link L3
    link_L3_end_rotated = P1 + (link_L3_end - P1) * R; % Apply rotation
    
    % Update the positions of the other links based on the rotation (using forward kinematics)
    % Here you might adjust the positions dynamically (for simplicity, you can assume constant length).
    link_L2_end_new = link_L2_start + [0, L2, 0];  % Keep L2 in place for now, adjust as needed
    
    % Update the plot for the links
    set(link_L_plot, 'XData', [link_L_start(1), link_L_end(1)], ...
                     'YData', [link_L_start(2), link_L_end(2)], ...
                     'ZData', [link_L_start(3), link_L_end(3)]);
    set(link_L2_plot, 'XData', [link_L2_start(1), link_L2_end_new(1)], ...
                      'YData', [link_L2_start(2), link_L2_end_new(2)], ...
                      'ZData', [link_L2_start(3), link_L2_end_new(3)]);
    set(link_L3_plot, 'XData', [link_L3_start(1), link_L3_end_rotated(1)], ...
                      'YData', [link_L3_start(2), link_L3_end_rotated(2)], ...
                      'ZData', [link_L3_start(3), link_L3_end_rotated(3)]);
    
    % Optional: Pause to create animation effect
    pause(0.05); % Adjust speed of animation (larger value = slower animation)
    
end

% Final adjustment to the view
view(3);
