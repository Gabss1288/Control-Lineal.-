% ------------- Respuesta a un escalón unitario -------------
% ***** Introduzca el numerador y el denominador de la función
% de transferencia *****
num = [0,2087 0,1993];
den = [1 0,1486 0,04365];
% ***** Introduzca la siguiente orden de respuesta escalón *****
step(num,den)
% ***** Introduzca grid y el título de la gráfica *****
grid
title ('Respuesta a un escalón unitario de G(s)=25/(sp2+4s+25)')

impulse(num,den);
grid
title('Respuesta a un impulso unitario de G(s)=0.2087s+0.1993/s^2+0.1486s+0.04365')