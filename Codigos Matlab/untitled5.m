clc;
clear all 
% Función de transferencia de la planta de tercer orden
num = [1];
den = [1 2 3 0];
G = tf(num, den);

% Parámetros del controlador PID
Kp = 156;   % Ganancia proporcional
Ti = 0.248; % Tiempo integral
Td = 0.246; % Tiempo derivativo

% Parámetros de muestreo
Ts = 0.1; % Tiempo de muestreo

% Coeficientes del controlador PID discreto
Kp_d = Kp * (1 + Ts / (2 * Ti) + Td / Ts);
Ki_d = Kp * Ts / (2 * Ti);
Kd_d = Kp * Td / Ts;

% Controlador PID discreto
C = pid(Kp_d, Ki_d, Kd_d, Ts);

% Función de transferencia del lazo cerrado
T = feedback(C * G, 1);

% Respuesta a la entrada escalón con diferentes valores de Oshott
t = 0:Ts:5;
r = ones(size(t));

oshott_values = [0.1, 0.2, 0.3]; % Valores de Oshott a probar

figure;
hold on;

for i = 1:length(oshott_values)
    oshott = oshott_values(i);
    delay = tf(1, [1, oshott]); % Retardo del sistema

    % Función de transferencia del lazo cerrado con retardo
    T_delay = feedback(C * G * delay, 1);
    
    % Simulación de la respuesta al escalón con retardo
    [y_delay, t_delay] = lsim(T_delay, r, t);
    
    % Gráfica de la respuesta con retardo
    plot(t_delay, y_delay, 'LineWidth', 1.5);
end

xlabel('Tiempo');
ylabel('Respuesta');
legend('Oshott = 0.1', 'Oshott = 0.2', 'Oshott = 0.3');
title('Respuesta de la planta de tercer orden con controlador PID discreto y diferentes valores de Oshott');
grid on;

