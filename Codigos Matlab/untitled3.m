% Plant transfer function
G = tf([0.2087 0.1993],[1 0.1486 0.04365]);

% Desired closed-loop pole location
zeta = 0.8;
wn = 5;
p = roots([1 2*zeta*wn wn^2]);

% Gain margin and phase margin specifications
GM = 90; % dB
PM = 50; % degrees

% Calculate the necessary phase shift
phi = -180 + PM - angle(evalfr(G,p(1)));

% Calculate the necessary zero location
wz = wn * sqrt((1-zeta^2)/(10^(GM/20)));

% Design the lead compensator
T = 1 / wz;
a = (1 + sin(phi*pi/180))/(1 - sin(phi*pi/180));
C = tf([a/T 1],[1/T 1]);

% Plot the root locus and compensated system
figure;
rlocus(G*C);
hold on;
sgrid(zeta,0);
title('Root Locus with Compensator');

% Calculate the closed-loop transfer function and plot the step response
H = feedback(C*G,1);
figure;
step(H);
title('Step Response with Compensator');
