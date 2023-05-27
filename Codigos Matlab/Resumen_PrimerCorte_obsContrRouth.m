clc;
clear
%Funcion de transferencia, numerador = b, denominador =a. 
b = [1];
a = [1 20 1];
G = tf(b,a)
%Matrices de estados
[A,B,C,D] = tf2ss(b,a)
sys = ss(A,B,C,D);
%Observabilidad
Ob = obsv(sys)
rank(Ob)
%Controlabilidad
Co = ctrb(sys)
rank(Co)
co = ctrb(A,B);
Unco = length(A) - rank(co);
if Unco == 0
    men = 'Es controlable';
else 
    men = 'No es controlable';
end
disp(men)

Ob = obsv(A,C);
Unobsv = length(A)-rank(Ob);
if Unobsv == 0
    men2 = 'Es observable';
else 
    men2 = 'No es observable';
end
disp(men2)


%Criterio de estabilidad Routh Hurwitz.
roots(a)
figure
subplot(2,1,1)
%Grafica Lugar de raices con ruta.
rlocus(b,a)
grid;

subplot(2,1,2)
title ('Lugar de las raíces de G(s) = (10s^2+2s+1)/(6s^2+8s+12)')
%Grafica de raices,  polos y ceros 
pzmap(G)

figure
subplot(2,1,1)
Gct1 = pidtune(G,'PID') %Usar pidtool
Hd = c2d(G,0.1,'foh')
step(G,'-r',Hd,'b')

subplot(2,1,2)
%Grafica de impulso
impulse(G)