function new_coords = transform_point(B, T, R)
    % Convertir les angles de degrés à radians
    R = deg2rad(R);
    
    % Matrices de rotation autour des axes X, Y et Z
    Rx = [1 0 0; 0 cos(R(1)) -sin(R(1)); 0 sin(R(1)) cos(R(1))];
    Ry = [cos(R(2)) 0 sin(R(2)); 0 1 0; -sin(R(2)) 0 cos(R(2))];
    Rz = [cos(R(3)) -sin(R(3)) 0; sin(R(3)) cos(R(3)) 0; 0 0 1];

    % Appliquer la rotation dans l'ordre Z -> Y -> X
    Rmat = Rz * Ry * Rx;
    
    % Appliquer la transformation sur le vecteur relatif T et ajouter la base B
    new_coords = B + (Rmat * T')';
end
