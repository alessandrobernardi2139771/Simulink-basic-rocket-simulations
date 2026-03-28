clear; clc; close all;

% Constants
T = 1000; % Thrust
t_b = 15; % Burn time
R = 0.3; % Radius
H = 1; % Height
A = R^2*pi; % Frontal area
m_s = 30; % Dry mass
m_p = 70; % Propellant mass
I_s = 1/12*m_s*(3*R^2+H^2); % empty inertia
I_p = 1/12*(m_s+m_p)*(3*R^2+H^2); % full inertia
C_D = 0.6; % Drag coefficient
p = 1.225; % Air density
cm_cp_distance = 0.01; % Distance between centre of mass and centre of pressure

