clc
clear all
close all

%% Diseño del Controlador PID

%Funcion de transferencia del proceso
% C=tf(Kc*[Ti 1],[Ti 0]);
P=tf(20,[1 8 17]);


%Obtiene el numerador y denominador de la FT
[n,d]=tfdata(P,'v');
%Nombro los terminos de la FT
k=n(3);
a=d(2);
b=d(3);

% Especificaciones de Diseño
Mp=50; %Maximo Pico
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