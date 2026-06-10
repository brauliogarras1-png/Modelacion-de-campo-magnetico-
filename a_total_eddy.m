function a = a_total_eddy(z, v, dPhi_dz, z_mid, R_circuito, gamma, m)
% Aceleración de un aro conductor cayendo (corrientes de Eddy)
% Entradas:
%   z          : posición actual del aro [m]
%   v          : velocidad actual [m/s]
%   dPhi_dz    : derivada discreta del flujo (vector)
%   z_mid      : posiciones donde está definido dPhi_dz (puntos medios)
%   R_circuito : resistencia eléctrica del aro [Ohms]
%   k_force    : no se usa (legacy, pasar 0)
%   gamma      : coeficiente de fricción viscosa
%   m          : masa [kg]

% Interpolar dPhi/dz en la posición continua z
% 'linear' con valor 0 fuera del rango (fuera del solenoide, no hay flujo)
dPhi_dz_local = interp1(z_mid, dPhi_dz, z, 'linear', 0);

% Si por alguna razón salió NaN, tratarlo como 0
if isnan(dPhi_dz_local)
    dPhi_dz_local = 0;
end

% FEM inducida: ε = -(dΦ/dz) * v
fem = -dPhi_dz_local * v;

% Corriente inducida: I = ε / R
I_ind = fem / R_circuito;

% Fuerza de Eddy (se opone al movimiento, por eso el signo sale solo)
% F_eddy = I_ind * dPhi_dz_local = -(dΦ/dz)² * v / R
F_eddy = I_ind * dPhi_dz_local;

% Fricción viscosa
Ff = -gamma * v;

% Gravedad
Fg = -m * 9.81;

% Aceleración total
a = (F_eddy + Ff + Fg) / m;

end