%% Observador de Estados Lazo Cerrado
% Sergio Andres Castaño Giraldo
% https://controlautomaticoeducacion.com/

%% Cursos PREMIUM 
% 1) Curso de SIMULINK: https://controlautomaticoeducacion.com/go/simulink-cupon/
% 2) Curso de Control en Arduino: https://controlautomaticoeducacion.com/go/controles-en-arduino/
% 3) Curso de Control en PIC: https://controlautomaticoeducacion.com/go/controles-en-pic/


clc
clear
close all

%Sistema
A = [-20 1 ;-1 0]
b = [1; 0]
c = [0 1]
sys = ss(A,b,c,0);

%Sistema Dual
Ad = A';
bd = c';
cd = b';
sys_dual = ss(Ad,bd,cd,0)

%Resulevo una realimentacion de estados
Co = ctrb(sys_dual);

% Polos Deseados
polos = [-5, -6];

%Realimentación de Estados
k = place(Ad, bd, polos);

%Ganancia del Observador
l = k'

%Autovalores del observador
AO =(A-l*c)
eig(A-l*c)

