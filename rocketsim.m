clear; clc; close all;

% Constants
T = 1000; % Thrust
t_b = 15; % Burn time
A = 0.09*pi; % Frontal area
m_s = 30; % Dry mass
m_p = 70; % Propellant mass
C_D = 0.6; % Drag coefficient
p = 1.225; % Air density
g = 9.81; % Gravitational acceleration
dt = 0.1; % Time step

% Initial conditions
m_0 = m_s + m_p; % Initial total mass
t = 0;
h = 0; % Altitude
V = 0; % Velocity
M = m_0; % Current mass
t_max = t_b + 30; % Max time of simulation
H = zeros(1,t_max/t_b);
i = 1;
t_v = 0:dt:t_max;
figure (1)

while V >= 0
    % Calculations for powered ascent phase
    if M > m_s && t < t_b 
        % Forces
        F_thrust = T;
        F_gravity = M * g;
        F_drag = 0.5 * p * V^2 * C_D * A; % Drag force
        % Net force
        F_net = F_thrust - F_gravity - F_drag;
        if F_net < 0
            disp("Il razzo nn decolla");
            break;
        end
        % Directly calculating mass at time t
        M = m_0 - (m_p/t_b) * t;
        V = V + (F_net/ M) * dt; % Update velocity
        h = h + V * dt; % Update altitude
        H(i) = h;
        i = i + 1;
        t = t + dt; % Update time
        plot(t,h,'.k')
        drawnow
        hold on
    % After burn time
    else
        % Forces
        F_gravity = M * g;
        % Drag force
        F_drag = 0.5 * p * V^2 * C_D * A; 
        % Net force
        F_net = -F_gravity - F_drag;
        % Updates
        V = V + (F_net / M) * dt; % Update velocity
        h = h + V * dt; % Update altitude
        H(i) = h;
        i = i + 1;
        t = t + dt; % Update time
        plot(t,h,'.k')
        drawnow
        hold on
    end
end

[h,idx] = max(H); % See ReadMe
H = H(1:idx); 
t_v = t_v(1:idx);

title(1,"Discrete plot of height on time")

figure (2)
plot(t_v,H);
title("Continuos plot of height on time");

disp(['Maximum altitude reached: ', num2str(h), ' meters']);