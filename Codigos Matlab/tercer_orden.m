% Sistemas de Tercer Orden
% Dos polos complejos conjugados
% un polo real
% Sergio Andres Castaño Giraldo

clc
clear all
close all

%Parámetros del sistema
Wn = 1;
ep = 0.7;

for i=[0.5 1 2 4 10]
beta = i;

% El polo real es el encargado de reducir el máximo sobreimpulso y tambien 
% aumentar o disminuir el tiempo de establecimiento. La proporción del polo 
% real con los polos complejos conjugados es dado por:

p = beta*ep*Wn;

%función de transferencia
num = Wn^2*p;
den = conv([1 2*ep*Wn Wn^2],[1 p]);
G=tf(num,den);

figure(1)
[y,t]=step(G,20);
plot(t,y,'Linewidth',2)
hold on
if i == 0.5
    figure(2)
    pzmap(G);
    title('\beta=0.5');
    grid
elseif i == 4
    figure(3)
    pzmap(G);
    title('\beta=4');
    grid
end
end
ylabel('Amplitud');
xlabel('Tiempo');
title('Respuesta al Escalón unitario')
grid on
set(gca,'FontSize',18 )
% legend('\beta=0.5', '\beta=1','\beta=2','\beta=4','\beta=10')

%% Respuesta temporal
tr=0:0.1:20;
beta=7.14286;
p = beta*ep*Wn;
num = Wn^2*p;
den = conv([1 2*ep*Wn Wn^2],[1 p]);
G=tf(num,den);
[y,t]=step(G,20);

%Frecuencia natural amortiguada
Wd = Wn*sqrt(1-ep^2);

% parámetros de Ogata
denO = beta*ep^2*(beta-2)+1;
numC = beta*ep^2*(beta-2);
numS = beta*ep*(ep^2*(beta-2)+1)/sqrt(1-ep^2);

% Respuesta de Ogata
yo = 1 - (exp(-(ep*Wn).*t)/denO).*(numC.*cos(Wd.*t)+numS.*sin(Wd.*t))...
    - exp(-p.*t)/denO;

%Respuesta de Sergio
A=1;
B= (p^2-2*ep*Wn*p)/(2*ep*Wn*p-p^2-Wn^2);
Ba_C = -((2*ep^2*Wn-ep*p-Wn)*p*Wn)/((2*ep*p*Wn-p^2-Wn^2)*Wd);
D = -Wn^2/(p^2-2*ep*p+Wn^2);


ys = A + B*exp(-(ep*Wn).*t).*cos(Wd.*t)+Ba_C*exp(-(ep*Wn).*t).*sin(Wd.*t)...
    + D*exp(-p.*t);

figure
plot(t,y,t,yo,'--',t,ys,':','Linewidth',2)
ylabel('Amplitud');
xlabel('Tiempo');
title('Respuesta Transitoria')
grid on
set(gca,'FontSize',18 )
legend('Matlab', 'Ogata','Sergio')

