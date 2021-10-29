% Reductor params

i = 19;
kpdr = 0.81;
Jp = 0.05*10^(-7); % kg*m^2 

% Load params

Jnagr = 0.027*10^(-7); % kg*m^2 

% Motor params

R = 5.3; % Ohm
L = 0.14 / 1000; % H
km = 9.32 / 1000; % N*m/A
kw = 60 / (2*pi * 1020); % V*s/rad
Jd = 0.85*10^(-7); % kg*m^2
Unom = 12; % V
Mnom = 8.02 / 1000; % N*m
Inom = 0.909; % A
nnom = 7300; % rpm
wnom = nnom * 2*pi / 60; % rad/s
Ixx = 64.2 / 1000; % A
nxx = 11900; % rpm
wxx = nxx * 2*pi / 60; % rad/s

Jsum = Jd + Jp + Jnagr;

Tm = (R * Jsum) / (km * kw); % s
Te = L / R; % s