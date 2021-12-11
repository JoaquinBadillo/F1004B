clc; clear all; close all;

%condiciones iniciales w(0) = 0, theta(0) = 20
% definimos los parametros de nuestra ecuacion diferencial ordinaria de segundo orden
g = 3.7; %% (NASA) aceleracion de la gravedad en Marte
Mb = 136.2; %% masa de la llanta en kg
Mv = 899; %% (NASA) masa del vehiculo y el sistema de bielas en kg 
re = 0.5/2; %% (NASA)radio de la llanta en m
ri = 0.2; %% radio de la manivela en metros, el cual establecimos gracias al radio de la llanta.
Fp = 630; % fuerza del piston en N 
I = 0.5*Mb*re^2; %% (Reto) formula del momento de inercia 
Ue = 0.4; % coeficiente de friccion estatico 
Fgb = Mb*g; %% fuerza gravitacional del brazo en N 
Fgv = Mv*g; %% fuerza gravitacional del vehiculo en N
n = 6; %% (Reto) numero de ruedas del vehiculo 

%theta'=w
%theta'' = (2*ri*Fp/Mb*re^2)*sin(theta)+(2*Ue/Mb*re)*(Fgb+(Fgv/Nb)
F = @(t,s ) [s(2),(2*ri*Fp/(Mb*re^2))*sin(s(1))+(2*Ue/(Mb*re))*(Fgb+(Fgv/n))];
% Equivalencias para el vector:
% s(1) --> "theta"
% s(2) --> "w"
ti = 0; % Tiempo inicial en segundos
tf = 0.9873; % Tiempo final para la EDO en segundos
[xSol, vSol] = eulerEDO2(F,ti,[deg2rad(20),0],tf ,0.0001);

alpha=(2*ri*Fp/(Mb*re^2))*sin(vSol(:,1))+(2*Ue/(Mb*re))*(Fgb+(Fgv/n));

% Definimos funciones simbolicas para poder considerar funciones por partes, de tal forma que despues de llegar a una velocidad angular operacional mantengamos una aceleracion angular igual a 0.
length = size(vSol, 1); % Número de filas en la matriz solución

syms s(t) v(t) theta1(t) alpha1(t) omega1(t)
s(t) = vSol(length,2)*re*(t-tf)+vSol(length,1)*re;
v(t) = vSol(length,2)*re;
theta1(t) = cos(s(t)/re);
alpha1(t) = 0;
omega1(t) = vSol(length,2);

figure
plot(xSol,cos(vSol(:,1))) % pasamos a una funcion coseno  
title("Coseno del desplazamiento angular en funcion del tiempo")
xlabel("t (s)")
ylabel("cos (θ(t) rad)")
grid on
hold on
fplot(theta1,[tf,1.765])

figure
plot(xSol,vSol(:,2))
title("Velocidad angular en funcion del tiempo")
xlabel("t (s)")
ylabel("ω(t) (rad/s)")
grid on
hold on
fplot(omega1,[tf,1.765])

figure
plot(xSol,re*vSol(:,1)) % multiplicamos por el radio de la llanta para obtener la velocidad lineal 
title("Desplazamiento lineal en funcion del tiempo")
xlabel("t (s)")
ylabel("x(t) (m)")
grid on
hold on
fplot(s,[tf,1.765])

figure
plot(xSol,re*vSol(:,2))
title("Velocidad lineal en funcion del tiempo")
xlabel("t (s)")
ylabel("v(t) (m/s)")
grid on
hold on
fplot(v,[tf,1.765])

figure
plot(xSol, alpha)
title("Aceleracion angular en funcion del tiempo")
xlabel("t (s)")
ylabel("α(t) (rad/s²)")
grid on
hold on
fplot(alpha1,[tf,1.765])