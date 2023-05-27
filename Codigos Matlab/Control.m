%%Control pendulo invertido.
function [F, gip]=fcn(teta, tetap, xc, xcp, gi)
x=[teta; tetap; xc; xcp];
r=1;
y=xc;
gip=r-y;

%Ganancias.
k=[-157.6336 -35.3733 -56.0652 -36.7466];
ki=-50.9664;

%Control.
ue=-k*x+ki*gi;
F=ue;