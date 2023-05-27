% Define la función de transferencia del sistema
G = tf([1], [1 1 1]);

% Grafica el LGR
rlocus(G);

% Diseña un compensador de adelanto
K = 3;
Td = 0.5;
Ti = 0.2;
C = leadlag(K, Td, Ti);

% Verifica el desempeño del sistema con el compensador
sys_cl = feedback(C*G, 1);
t = 0:0.1:10;
step(sys_cl, t);