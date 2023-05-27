% Función de transferencia del sistema
num = [0.393 0.2155];
den = [1 12.02 0.1393];
G = tf(num, den);

% Cálculo del lugar geométrico de raíces del sistema
figure;
rlocus(G);
title('Lugar geométrico de raíces del sistema sin controlador');

% Diseño del controlador
zeta = 0.9; % Factor de amortiguamiento deseado
wn = 8.0; % Frecuencia natural deseada
C = (s^2+2*zeta*wn*s+wn^2)/(0.1*s+1);

% Cálculo del lugar geométrico de raíces del sistema con controlador
figure;
rlocus(C*G);
title('Lugar geométrico de raíces del sistema con controlador');

% Respuesta del sistema a una entrada escalón unitario
T1 = feedback(C*G, 1);
figure;
step(T1);
title('Respuesta del sistema a una entrada escalón unitario');

% Respuesta del sistema a una entrada rampa
T2 = feedback(C*G/s, 1);
figure;
step(T2);
title('Respuesta del sistema a una entrada rampa');
