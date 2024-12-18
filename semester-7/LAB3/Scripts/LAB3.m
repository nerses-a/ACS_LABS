clc
clear
close all

% Определение функций для решения ОДУ
ode_first = @lab_ode;
ode_second = @lab_ode_2;

% Глобальные переменные для параметров модели
global m l mu u g xk Kpt Kpdt Kit Kidt Kpp Kpdp Kip Kidp

% Инициализация параметров модели
m = 1;        % Масса
l = 1;        % Длина маятника
mu = 0.5;     % Коэффициент затухания
g = 9.815;    % Ускорение свободного падения

% Начальные условия для первой модели
X0 = [pi/2; 0.1; pi/2; 0.1];

% Управляющий вход для первой модели
u = [0; 1];

% Временной интервал моделирования
t = 0 : 0.01 : 20;

% Решение первой системы ОДУ
[~, X] = ode15s(ode_first, t, X0);

% Построение графиков для первой модели
figure
subplot(2,1,1)
yyaxis left
plot(t, X(:,1), 'LineWidth', 2)
ylabel('Угол, рад')
yyaxis right
plot(t, X(:,2), 'LineWidth', 2)
ylabel('Угловая скорость, рад/с')
title('Изменение координаты и скорости по \theta')
xlabel('Время, с')
legend('Угол \theta', 'Угловая скорость d\theta /dt')
grid on
grid minor


subplot(2,1,2)
yyaxis left
plot(t, X(:,3), 'LineWidth', 2)
ylabel('Угол, рад')
yyaxis right
plot(t, X(:,4), 'LineWidth', 2)
ylabel('Угловая скорость, рад/с')
title('Изменение координаты и скорости по \phi')
xlabel('Время, с')
legend('Угол \phi', 'Угловая скорость d\phi /dt')
grid on
grid minor


% Начальные условия для второй модели
X0 = [-pi/2; 0; 0; 0];

% Целевая точка для управления
xk = [5/6*pi; 0; pi/3; 0];

% Коэффициенты ПИД-регуляторов
Kpt = 60;
Kpdt = 20;
Kit = 0.05;
Kidt = 0.01;
Kpp = Kpt;
Kpdp = Kpdt;
Kip = Kit;
Kidp = Kidt;

% Временной интервал для второй модели
t = 0 : 0.01 : 3;

% Решение второй системы ОДУ
[~, X] = ode15s(ode_second, t, X0);

% Построение графиков для второй модели
figure
subplot(2,1,1)
yyaxis left
plot(t, X(:,1), 'LineWidth', 2)
ylabel('Угол, рад')
yyaxis right
plot(t, X(:,2), 'LineWidth', 2)
ylabel('Угловая скорость, рад/с')
title('Изменение координаты и скорости по \theta')
xlabel('Время, с')
legend('Угол \theta', 'Угловая скорость d\theta /dt')
grid on
grid minor

subplot(2,1,2)
yyaxis left
plot(t, X(:,3), 'LineWidth', 2)
ylabel('Угол, рад')
yyaxis right
plot(t, X(:,4), 'LineWidth', 2)
ylabel('Угловая скорость, рад/с')
title('Изменение координаты и скорости по \phi')
xlabel('Время, с')
legend('Угол \phi', 'Угловая скорость d\phi /dt')
grid on
grid minor
