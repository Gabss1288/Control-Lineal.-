clc;
clear all 
%%PARCIAL FINAL (SIMULACRO)
%%Ingresa funcion de transderencia. 
comp=tf('s');

num=[1 2];
den=[1 0 30 15];

fdt=tf(num,den)
% Graficar la respuesta al escalón de la función de transferencia
figure;
step(fdt);
title('Salida planta sin controlador');
xlabel('Tiempo');
ylabel('Amplitud');
% Cálculo del lugar geométrico de raíces del sistema
figure;
rlocus(fdt);
title('Lugar geométrico de raíces del sistema sin controlador');
xlabel('Tiempo');
ylabel('Amplitud');
%%Espacios de estado
[matrizA,matrizB,matrizC,matrizD] = tf2ss(num,den);
A=matrizA
B=matrizB
C=matrizC
D=matrizD
%%%%%%%Determinacion de controlabilidad y observabilidad%%%%%%
M=[B,A-B,A^2*B]
N=[C;C*A;C*A^2]
n=rank(A)
RM= rank(M)
RN= rank(N)
if RM==n
    controlable=1
else
    controlable=0
end
if RN==n
    observable=1
else
    observable=0
end
%%%%%% a %%%%%%%%
%% PID Discreto de OSHOL =10%
Gct1 = pidtune(fdt,'PID') %Usar pidtool
Hd = c2d(fdt,0.0001,'foh')
step(fdt,'-r',Hd,'b')
