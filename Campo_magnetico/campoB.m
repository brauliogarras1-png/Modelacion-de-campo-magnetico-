% Braulio Garcia Rayas
%A01649125
%Campo magnetico

function [Bx,By,Bz,rx,ry,rz] = campoB (ds,km,Px,Py,Pz,dPx,dPy,dPz)
    rx = -6:ds:6;
    ry = 0;
    rz = -5:ds:5;

    Lx = length (rx);
    Ly = length (ry);
    Lz = length (rz);

    Bx = zeros(Lx,Ly,Lz,'single');
    By = zeros(Lx,Ly,Lz,'single');
    Bz = zeros(Lx,Ly,Lz,'single');

    rw = .2;

    for i=1:Lx
        for j=1:Ly
            for k=1:Lz
                for l = 1:length(Px)
                    drx = rx (i) - Px(l);
                    dry = ry (j) - Py(l);
                    drz = rz (k) - Pz(l);
                    r = sqrt (drx^2 + dry^2 + drz^2+rw^2);
                    r3 = r^3;

                    Bx(i,j,k) = Bx(i,j,k) + km * (dPy(l) * drz - dPz(l) * dry) / r3;
                    By(i,j,k) = By(i,j,k) + km * (dPz(l) * drx - dPx(l) * drz) / r3;
                    Bz(i,j,k) = Bz(i,j,k) + km * (dPx(l) * dry - dPy(l) * drx) / r3;

                end 
            end 
        end
    end 

end 


