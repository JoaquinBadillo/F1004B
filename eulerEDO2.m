function [x,vSol] = eulerEDO2(F,x1,v1,xf,h)
% Método de Euler para resolver un sistema de EDO de primer orden
%   F es la relación funcional que define la ED
%   x1 es el punto inicial
%   xf es el valor final del intervalo de solución
%   h es el paso
%   v1 es el vector de valores iniciales v1=[p(0) y(0)...]

x=x1:h:xf; % Vector de valores de la variable independiente
x=x'; % Transposición
n=length(x);
vSol = zeros(n,length(v1)); %vSol es el arreglo solución, tiene tantas columnas como funciones incógnita
vSol(1,:)=v1; %La primera fila se llena con los valores iniciales de las funciones

for k=1:n-1
    %En cada paso se realiza el método de Euler para TODAS las funciones
    %incógnita
    vSol(k+1,:)=vSol(k,:)+ h*F(x(k) , vSol(k,:));
end

end