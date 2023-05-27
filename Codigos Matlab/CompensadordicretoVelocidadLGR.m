close all
clear all
clc
%sistema inicial torque en funcion del voltaje
Km=0.23351629;
B=0.00223579;
L=0.0015;
J=0.00040095;
R=3.4;
Ka=0.23351629;
num=[0 (Km)]
den=[0 (L*J) (R*J+L*B) (R*B+Km*Ka)]
G=tf(num,den);
J=tf(1,[1 0])
t_m = 0.15/5;
% Conversoin a discreto
 Ftz = c2d(G*J,t_m,'zoh')
% Conversoin a tiempo cpntinua ficticio
 Ftw = d2c(Ftz,'tustin')
% 
% Encontrar K
Kv=2;
[a,b]=tfdata(Ftw,'v');
syms s
pnum=poly2sym(a,s);pden=poly2sym(b,s);
FF=s*pnum/pden;
pretty(vpa(FF,3))
li=limit(FF,s,0);
K=double(Kv/li);
J=zpk([],[0 -1],K);
% Conversoin a discreto
Ftz = c2d(G*J,t_m,'zoh')
% Conversoin a tiempo cpntinua ficticio
Ftw = d2c(Ftz,'tustin')
[Gm,Pm,Wcg,Wcp]= margin(Ftw);
margin(Ftw);Mfobtenido=Pm;
figure
bode(G)
hold on
bode(Ftz)
bode(Ftw)
hold off
legend('Continuo','Discreto','Continuo ficticio')
grid
Mfdeseado=50;Mfadc=8;
phi=Mfdeseado-Mfobtenido+Mfadc;
alpha=(1-sind(phi))/(1+sind(phi));
magm=-10*log(1/alpha)
Vm=2.11
tau=1/(sqrt(alpha)*Vm)
Gdw=tf([tau 1],[alpha*tau 1]);
Gcw=Ftw*Gdw
figure
margin(Ftw)
hold on
margin(Gcw)
hold off
legend('Original','Compensado')
[Gm,Pm,Wcg,Wcp]= margin(Gcw);
MFfinal=Pm; 
Gdz=c2d(Gdw,t_m,'tustin')
GG=Gdz*Ftz
H=feedback(GG,1)
figure
hold on
step(H)
step(G)
hold off
figure
step(H)
figure
impulse(H)
figure
step((H*c2d(tf([1],[1 0]),t_m,'zoh')))