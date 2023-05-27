clc;
%Criterios de ruth hurwitz
clear
%En primer lugar, se requiere obtener las dos primeras filas de la matriz de ruta
e=input('ingrese los coeficientes de la ecuación característica: ');
disp('-------------------------------------------------------------------------')
l=length(e);
m=mod(l,2);
if m==0
    a=rand(1,(l/2));
    b=rand(1,(l/2));
    for i=1:(l/2)
        a(i)=e((2*i)-1);
        b(i)=e(2*i);
    end
else
    e1=[e 0];
    a=rand(1,((l+1)/2));
    b=[rand(1,((l-1)/2)),0];
    for i=1:((l+1)/2)
        a(i)=e1((2*i)-1);
        b(i)=e1(2*i);
    end
end
%% ahora generamos las filas restantes de la matriz de ruta
l1=length(a);
c=zeros(l,l1);
c(1,:)=a;
c(2,:)=b;
for m=3:l
    for n=1:l1-1
        c(m,n)=-(1/c(m-1,1))*det([c((m-2),1) c((m-2),(n+1));c((m-1),1) c((m-1),(n+1))]);
    end
end
disp('la matriz de ruta:')
disp(c)
% ahora comprobamos la estabilidad del sistema
if c(:,1)>0
    disp('El sistema es estable')
else
    disp('El sistema es inestable');
end