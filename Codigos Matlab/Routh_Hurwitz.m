%Criterio de estabilidad Routh Hurwitz.
clc;
clear
%CON FUNCION DE TRANSFERENCIA.
Num = [10 2 1];
Den = [6 8 12];
roots(Den)
G = tf(Num,Den)
%Grafica de raices,  polos y ceros 
pzmap(G)
%Grafica de impulso
impulse(G)
%Grafica Lugar de raices con ruta.
rlocus(Num,Den)
grid;
title ('Lugar de las raíces de G(s) = (10s^2+2s+1)/(6s^2+8s+12)')
%CON ESPACIOS DE ESTADO
% --------- Lugar de las raíces espacios de estados---------
A=[0 1 0;0 0 1;-160 -56 -14];
B=[0;1;-14];
C=[1 0 0];
D=[0];
rlocus(A,B,C,D);
grid
title('Lugar de las raíces de sistema definido en el espacio de estados')