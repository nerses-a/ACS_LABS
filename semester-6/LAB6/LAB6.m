clc
clear variables
close all force

T = 0.1;
zeta = 1;

s = tf('s');
K = 1;

W = K/(s * (T^2 * s^2 + 2 * T * zeta * s + 1))

% Положение полюсов определяет устойчивость системы - устойчивая система
% имеет только левые полюса, хотя бы один полюс справа делает систему
% неизбежно неустойчивой

% Поведение и полюса замкнутой системы при К = 1
figure
figure
step(feedback(W,1))

figure
pzmap(feedback(W,1))

% Построение корневого годографа (root locus) (по РАЗОМКНУТОЙ системе)

figure
rlocus(W)

% Вывод системы на границу устойчивости, К = 20
figure
step(feedback(21 * W,1), 10)

figure
pzmap(feedback(21 * W,1))

figure
margin(21 * W)
% при желании можно использовать инструмент sisotool