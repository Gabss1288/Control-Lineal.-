clc;
clear
%% TF CONTROLADOR --- Continuo 
s=tf('s') 
Num = [1 3];
Den = [1 3 10 3];
Cs=tf(Num,Den)
%hold on 
%step(Cs) 
%impulse(Cs)
%% Controlador en Discreto_Metodos ZOH  FOH  IMPULSE  y MATCHED  con función c2d 
T=0.2
Czoh=c2d(Cs,T,'zoh')      %% Técnica Zero order hold 
Cfoh=c2d(Cs,T,'foh')      %% Técnica First order hold
Cimp=c2d(Cs,T,'impulse')  %% Técnica invariancia al impulso 
Cmat=c2d(Cs,T,'matched')  %% Técnica mapeo de polos y zeros 
figure
subplot(2,1,1)
hold on 
step(Czoh) 
step(Cfoh)
step(Cimp) 
step(Cmat)
subplot(2,1,2)

hold on 
step(Cs) 
impulse(Cs)

