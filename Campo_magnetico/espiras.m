% Braulio Garcia Rayas
%A01649125
%Campo magnetico

function [Px,Py,Pz,dPx,dPy,dPz] = espiras (nl,N,R,sz)
dtheta = 2*pi /N;                %Recorremos en la espiral
ang = 0:dtheta:(2*pi - dtheta);  %Vector de angulo
s=1;

    %For sobre el numero de espiras
    for i = 1:nl
        idx = s:s+N-1;
        Px (idx)    = R * cos (ang);           %Todas las cordenadas de x
        Py (idx)    = R * sin (ang);           %Todas las cordenadas de y
        Pz (idx)    = -(nl-1)/2*sz + (i-1)*sz;       
        dPx (idx)   = R * -sin(ang) * dtheta;
        dPy (idx)   = R * cos (ang) * dtheta;
        dPz (idx)   = 0;
        s = s+N;
    end
end 