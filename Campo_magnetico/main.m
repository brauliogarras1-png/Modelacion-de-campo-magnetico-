% Braulio Garcia Rayas
%A01649125
%Campo magnetico
clear;
close all;

import 'espiras.*'
import 'campoB.*'

nl = 5;                    %Numero de espiras 
N = 20;                     %Puntos en la espira
R = 1.5;                      %Radio de cada espira
sz = 1.5;                  %Separacion entre espiras (paso en Z)
I = 450;                    %Corriente (A)
mo = 4*pi*1e-7;             %Permeabilidad magnetica del vacio
km = mo * I / (4*pi);       %Constante de Biot-Savart
ds = 0.1;                   %Grosor efectivo del alambra para evitar singularidades 

[Px,Py,Pz,dPx,dPy,dPz] = espiras (nl,N,R,sz);

% Graficarlo
figure('Color','w');
hold on;

%plot3(Px,Py,Pz,'k-','LineWidth',1.5);
quiver3 (Px,Py,Pz,dPx,dPy,dPz,0.5,'r','LineWidth',1);
grid on;
view (3);
title ('Campo magnetico');
xlabel ('Eje x'),
ylabel ('Eje y');
zlabel ('Eje z');
hold on;



[Bx,By,Bz,rx,ry,rz] = campoB (ds,km,Px,Py,Pz,dPx,dPy,dPz);
Bmag = sqrt(Bx.^2 + By.^2 + Bz.^2);

Bx_2D = squeeze(Bx(:, 1, :))'; 
Bz_2D = squeeze(Bz(:, 1, :))';
Bmag_2D = squeeze(Bmag(:, 1, :))';




figure('Color', 'w');
hold on
h = pcolor(rx, rz, Bmag_2D.^(1/3)); 
shading interp; 
colormap(jet(256));
colorbar;
st = streamslice(rx, rz, Bx_2D, Bz_2D, 3);
set(st, 'Color', 'w', 'LineWidth', 0.8);

axis equal tight;
set(gca, 'Color', 'w', 'XColor', 'k', 'YColor', 'k');
xlabel('X'); ylabel('Z');
title('Campo Magnetico Solenoide')

xlim([-6 6]); 
ylim([-5 5]);
hold off



