clc; clear; close all;

% === Paramètres ===
L1 = 2; L2 = 3; L4 = 2; H = 5;
d_BC = 3; % Distance fixe entre B et C
P_Rz = 60; % Rotation en Z du point P

% === Configuration de la figure ===
figure;
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on; axis equal; view(3);
title('Animation avec distance fixe entre B et C');

% === Boucle d'animation ===
for Q1 = 1:360
    cla; % Effacer l'ancienne figure

    % === Définition des points ===
    base = [0, 0, 0];
    P = [0, 0, H];
    A = base + [L1*cosd(Q1), L1*sind(Q1), 0];
    B = A + [0, 0, H];
    C = B + [d_BC * cosd(P_Rz), d_BC * sind(P_Rz), 0];
    points = [base; A; B; C; P];
    
    % === Tracé des points et segments ===
    scatter3(points(:,1), points(:,2), points(:,3), 100, 'r', 'filled');
    hold on;
    plot3(points(:,1), points(:,2), points(:,3), '-ob', 'LineWidth', 2);
    
    % === Étiquetage des points ===
    labels = {'Base', 'A', 'B', 'C', 'P'};
    for i = 1:length(labels)
        text(points(i,1), points(i,2), points(i,3), labels{i}, 'FontSize', 12, 'FontWeight', 'bold');
    end
    
    % === Création du repère 3D en P ===
    R_size = 2;
    Rz_mat = [cosd(P_Rz), -sind(P_Rz), 0; sind(P_Rz), cosd(P_Rz), 0; 0, 0, 1];
    axes_vecs = Rz_mat * diag([R_size, R_size, R_size]);
    quiver3(P(1), P(2), P(3), axes_vecs(1,1), axes_vecs(2,1), axes_vecs(3,1), 'r', 'LineWidth', 2);
    quiver3(P(1), P(2), P(3), axes_vecs(1,2), axes_vecs(2,2), axes_vecs(3,2), 'g', 'LineWidth', 2);
    quiver3(P(1), P(2), P(3), axes_vecs(1,3), axes_vecs(2,3), axes_vecs(3,3), 'b', 'LineWidth', 2);
    
    % === Planche orientée selon P ===
    [x_plane, y_plane] = meshgrid([-1,1]*1.5, [-1,1]);
    z_plane = zeros(size(x_plane));
    planche_pts = Rz_mat * [x_plane(:)'; y_plane(:)'; z_plane(:)'];
    fill3(P(1) + reshape(planche_pts(1,:),2,2), P(2) + reshape(planche_pts(2,:),2,2), P(3) + reshape(planche_pts(3,:),2,2), 'cyan', 'FaceAlpha', 0.5);
    
    % === Animation ===
    drawnow;
end
