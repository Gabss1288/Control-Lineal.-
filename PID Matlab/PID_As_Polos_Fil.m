% Control PID Por Asignación de Polos
% Sergio Andres Castaño Giraldo
% Universidade Federal de Rio de Janeiro
% Rio de Janeiro - 2017
% http://controlautomaticoeducacion.com
% ------------------------------------------------------
clc
clear all
close all


%% Parametros del Proceso del Tanque de Nivel
%Parametros

k1=0.04;
k2=0.03;
k3=0.055;
a1=0.0:0.1:1;   %Abertura de la Valvula entrada
a2=0:0.1:1;     %Abertura de la Valvula salida
A1=1;
A2=1.5;

%Abertura de las Valvulas para el punto de equilibrio
a1s=0.5;
a2s=0.45;

%Altura en los tanques en el punto de equilibrio
h1s=((k1*a1s)/k2)^2;
h2s=((k2^2*h1s)/(k3*a2s)^2);
Eq1=[h1s h2s];
%% Diseño del Controlador PID

%Funcion de transferencia del proceso
% C=tf(Kc*[Ti 1],[Ti 0]);
P=tf(0.0006,[1 0.03271 0.0002297]);

%Obtiene el numerador y denominador de la FT
[n,d]=tfdata(P,'v');
%Nombro los terminos de la FT
k=n(3);
a=d(2);
b=d(3);

% Especificaciones de Diseño
Mp=10; %Maximo Pico
ep=sqrt(((log(Mp/100))^2)/(pi^2+((log(Mp/100))^2))); %Fator de amortecimento

tau=1/(abs(max(roots(d)))); %Toma o valor do polo dominante
Tss=(tau*4)*0.75;
Wn=3/(ep*Tss); %Frequência Natural

Sd=[-ep*Wn+1i*Wn*sqrt(1-ep^2), -ep*Wn-1i*Wn*sqrt(1-ep^2)]; %Alocação de Polos
p3=real(Sd(1))*10; %Polo nao dominante 20 veces longe do dominante
Sd1=[Sd p3];
Pds=poly(Sd1);

alpha=0.01;

%Calculo del Controlador
Kc=(Pds(3)-b)/k;
ti=(k*Kc)/Pds(4);
td=(Pds(2)-a)/(k*Kc);

%Parametros del PID con Filtro en el termino Derivativo
d2=alpha*Kc*ti*td+Kc*ti*td;
d1=Kc*ti+alpha*Kc*td;
d0=Kc;

%Controlador PID
C=tf([d2 d1 d0],[alpha*ti*td ti 0]);

N=1/(td*alpha);

%Simulación con el Modelo en lazo cerrado
H=minreal((C*P)/(1+C*P));
step(H);
figure
pzmap(H);
