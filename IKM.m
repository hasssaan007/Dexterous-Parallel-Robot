clc; clear; close all;

% ------------------------------------------------------------------------- - Entrées
P = [0 0 10];                   % coordonnées de la base FIXE
R = [0 0 0];                    % rotation VARRIABLE
r = 1;                          % Rayon des disques
theta = linspace(0, 2*pi, 50);  % 50 points pour tracer le disque
h = 0.25;                       % espace entre les disques
h_e = 5;                        % hauteur des équère
% ------------------------------------------------------------------------- - Calcul

A = transform_point(P, [1 1 0], R);
B = transform_point(P, [1 -1 0], R);
C = transform_point(P, [-1 -1 0], R);
D = transform_point(P, [-1 1 0], R);
E = transform_point(P, [-1 2 0], R);
F = transform_point(P, [1 -2 0], R);

% - Premier bras
A1 = F + [5 0 0]; 
A2 = F + [4 0 0];
A3 = F + [3 0 0];
A4 = F + [2 0 0];
A5 = F + [1 0 0];

A6 = E + [-5 0 0]; 
A7 = E + [-4 0 0];
A8 = E + [-3 0 0];
A9 = E + [-2 0 0];
A10 = E + [-1 0 0];

% - equere
ang_E1 = 0;
ang_E2 = 0;
ang_E3 = 0;
ang_E4 = 0;
ang_E5 = 180;
ang_E6 = 180;
ang_E7 = 180;
ang_E8 = 180;
E1 = [3*cosd(ang_E1) 3*sind(ang_E1) 0*h];
E2 = [4*cosd(ang_E2) 4*sind(ang_E2) 2*h];
E3 = [5*cosd(ang_E3) 5*sind(ang_E3) 4*h];
E4 = [3.5*cosd(ang_E4) 3.5*sind(ang_E4) 6*h];
E5 = [3*cosd(ang_E5) 3*sind(ang_E5) 1*h];
E6 = [4*cosd(ang_E6) 4*sind(ang_E6) 3*h];
E7 = [5*cosd(ang_E7) 5*sind(ang_E7) 5*h];
E8 = [3.5*cosd(ang_E8) 3.5*sind(ang_E8) 7*h];
D1 = E1 + [0 0 h_e-0*h];
D2 = E2 + [0 0 h_e-2*h];
D3 = E3 + [0 0 h_e-4*h];
D4 = E4 + [0 0 h_e-0.5-6*h];
D5 = E5 + [0 0 h_e-1*h];
D6 = E6 + [0 0 h_e-3*h];
D7 = E7 + [0 0 h_e-5*h];
D8 = E8 + [0 0 h_e-0.5-7*h];

% ------------------------------------------------------------------------- - Partie affichage
figure;
hold on;
grid on;
axis equal;
view(3); % Vue en 3D

% Affichage des axes
xlabel('axe X');
ylabel('axe Y');
zlabel('axe Z');
title('Carré en 3D');

% Affichage des points A, B, C, D
plot3(A(1), A(2), A(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'r');
plot3(B(1), B(2), B(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'b');
plot3(C(1), C(2), C(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'g');
plot3(D(1), D(2), D(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'm');
plot3(E(1), E(2), E(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'c');
plot3(F(1), F(2), F(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'y');
plot3(A1(1), A1(2), A1(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A2(1), A2(2), A2(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A3(1), A3(2), A3(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A4(1), A4(2), A4(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A5(1), A5(2), A5(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A6(1), A6(2), A6(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A7(1), A7(2), A7(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A8(1), A8(2), A8(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A9(1), A9(2), A9(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');
plot3(A10(1), A10(2), A10(3), 'o', 'MarkerSize', 4, 'MarkerFaceColor', 'k');


% % Ajout de labels pour chaque point
% text(A(1), A(2), A(3), '  A', 'FontSize', 12, 'Color', 'r');
% text(B(1), B(2), B(3), '  B', 'FontSize', 12, 'Color', 'b');
% text(C(1), C(2), C(3), '  C', 'FontSize', 12, 'Color', 'g');
% text(D(1), D(2), D(3), '  D', 'FontSize', 12, 'Color', 'm');

% Tracer les segments entre les points
plot3([A(1) B(1)], [A(2) B(2)], [A(3) B(3)], 'k-'); % A -> B
plot3([B(1) C(1)], [B(2) C(2)], [B(3) C(3)], 'k-'); % B -> C
plot3([C(1) D(1)], [C(2) D(2)], [C(3) D(3)], 'k-'); % C -> D
plot3([D(1) A(1)], [D(2) A(2)], [D(3) A(3)], 'k-'); % D -> A
plot3([D(1) E(1)], [D(2) E(2)], [D(3) E(3)], 'k-'); % D -> E
plot3([B(1) F(1)], [B(2) F(2)], [B(3) F(3)], 'k-'); % B -> F
plot3([F(1) A1(1)], [F(2) A1(2)], [F(3) A1(3)], 'k-'); % F -> A1
plot3([E(1) A6(1)], [E(2) A6(2)], [E(3) A6(3)], 'k-'); % E -> A6

plot3([0 E1(1)], [0 E1(2)], [0*h E1(3)], 'k-'); %
plot3([0 E2(1)], [0 E2(2)], [2*h E2(3)], 'k-'); %
plot3([0 E3(1)], [0 E3(2)], [4*h E3(3)], 'k-'); %
plot3([0 E4(1)], [0 E4(2)], [6*h E4(3)], 'k-'); %
plot3([0 E5(1)], [0 E5(2)], [1*h E5(3)], 'k-'); %
plot3([0 E6(1)], [0 E6(2)], [3*h E6(3)], 'k-'); %
plot3([0 E7(1)], [0 E7(2)], [5*h E7(3)], 'k-'); %
plot3([0 E8(1)], [0 E8(2)], [7*h E8(3)], 'k-'); %

plot3([E1(1) D1(1)], [E1(2) D1(2)], [E1(3) D1(3)], 'k-');
plot3([E2(1) D2(1)], [E2(2) D2(2)], [E2(3) D2(3)], 'k-');
plot3([E3(1) D3(1)], [E3(2) D3(2)], [E3(3) D3(3)], 'k-');
plot3([E4(1) D4(1)], [E4(2) D4(2)], [E4(3) D4(3)], 'k-');
plot3([E5(1) D5(1)], [E5(2) D5(2)], [E5(3) D5(3)], 'k-');
plot3([E6(1) D6(1)], [E6(2) D6(2)], [E6(3) D6(3)], 'k-');
plot3([E7(1) D7(1)], [E7(2) D7(2)], [E7(3) D7(3)], 'k-');
plot3([E8(1) D8(1)], [E8(2) D8(2)], [E8(3) D8(3)], 'k-');


% Disque
fill3( r*cos(theta), r*sin(theta), 0*h*ones(size(theta)), 'b', 'FaceAlpha', 0.5);
fill3( r*cos(theta), r*sin(theta), 1*h*ones(size(theta)), 'r', 'FaceAlpha', 0.5);
fill3( r*cos(theta), r*sin(theta), 2*h*ones(size(theta)), 'r', 'FaceAlpha', 0.5);
fill3( r*cos(theta), r*sin(theta), 3*h*ones(size(theta)), 'r', 'FaceAlpha', 0.5);
fill3( r*cos(theta), r*sin(theta), 4*h*ones(size(theta)), 'r', 'FaceAlpha', 0.5);
fill3( r*cos(theta), r*sin(theta), 5*h*ones(size(theta)), 'r', 'FaceAlpha', 0.5);
fill3( r*cos(theta), r*sin(theta), 6*h*ones(size(theta)), 'r', 'FaceAlpha', 0.5);
fill3( r*cos(theta), r*sin(theta), 7*h*ones(size(theta)), 'r', 'FaceAlpha', 0.5);

hold off;