clc
clear
close all

%{
Аветисян Нерсес ИУ2-71

    Лабораторная работа №1
«Особые точки и фазовые портреты»

%}


%{
Определение типа особых точек
Ду представлено в форме Коши (рассмотрим 2 порядок)
dx(1) = f_1(x(1), x(2));
dx(2) = f_2(x(1), x(2));

Матрица Якоби

      | df_1/dX_1 df_1/dX_2 |
A =   | df_2/dX_1 df_2/dX_2 |

Подставляем в матрицу Якоби x_1 и x_2, 
соответствующие точкам равновесия
системы, получаем матрицу, не зависящую от Х

Необходимо определить собственные числа 
матрицы через поиск решения

матричного уравнения |lambda * I - A| = 0, 
где I - единичная матрица
%}


% Маятник
func_ode_pend = @lab_ode_pendulum; % Указатель на функцию с маятником

X1 = [10, -8;6, -8;3.5, -8;-0.2, -8;-1.6, -8;...
-8, 7.1;-8, 8.9;-4.5, 10;-3.5, 10;0.5, 10]'; % Вектор начальных условий

t = 0 : 0.01 : 10;

% ode45
% ode23
% ode23t

% Проверка решения во временной области
[~, Y1] = ode45(func_ode_pend, t, X1(:,1));

figure
clf
yyaxis left
plot(t, rad2deg(Y1(:, 1)), 'LineWidth', 2)
ylabel('Угол, град')
grid on
grid minor
yyaxis right
plot(t, rad2deg(Y1(:, 2)), 'LineWidth', 2)
ylabel('Угловая скорость, град/с')
grid on
grid minor
xlabel('Время, с')

figure
clf
for i = 1 : 1 : length(X1)
    
    
% Решение ДУ
[~, Y1] = ode45(func_ode_pend, t, X1(:,i));

plot(Y1(:, 1), Y1(:, 2),'-d', 'LineWidth', 2, 'MarkerIndices', 1)
hold on

end

hold off
grid on
grid minor
title('Фазовый портрет маятника с изменением начальных условий')
xlabel('Координата, рад')
ylabel('Скорость, рад/c')

clear t
% Осциллятор Ван дер Поля

func_ode_vdp = @lab_ode_vanderpole;

X2 = [4, 4 ;-4, 4 ;0.1, 0.1 ;-4, -4 ;4, -4]';

t = 0 : 0.01 : 30;

% Проверка решения во временной области
[~, Y2] = ode45(func_ode_vdp, t, X2(:,1));

figure
clf
yyaxis left
plot(t, rad2deg(Y2(:, 1)), 'LineWidth', 2)
ylabel('Координата')
grid on
grid minor
yyaxis right
plot(t, rad2deg(Y2(:, 2)), 'LineWidth', 2)
ylabel('Скорость')
grid on
grid minor
xlabel('Время, с')

figure
clf
for i = 1 : 1 : length(X2)
    
    
% Решение ДУ
[~, Y2] = ode45(func_ode_vdp, t, X2(:,i));

plot(Y2(:, 1), Y2(:, 2),'-d', 'LineWidth', 2, 'MarkerIndices', 1)
hold on

end

hold off
grid on
grid minor
title('Фазовый портрет осциллятора Ван дер Поля с изменением начальных условий')
xlabel('Координата')
ylabel('Скорость')

clear t
% Схема на туннельных диодах
func_ode_td = @lab_ode_diodes;

X3 =  [-0.4, 0.2 ; -0.4, 1 ; -0.4, 1.25 ; -0.4, 1.58 ; 1.6, 0.8;...
    0.8, -0.4 ; 0.78, -0.4 ; 0.7, -0.4 ; 1.6, -0.3]';

t = 0 : 0.01 : 20;

% Проверка решения во временной области
[~, Y3] = ode45(func_ode_td, t, X3(:,1));

figure
clf
yyaxis left
plot(t, rad2deg(Y3(:, 1)), 'LineWidth', 2)
ylabel('Координата')
grid on
grid minor
yyaxis right
plot(t, rad2deg(Y3(:, 2)), 'LineWidth', 2)
ylabel('Скорость')
grid on
grid minor
xlabel('Время, с')

figure
clf
for i = 1 : 1 : length(X3)
    
    
% Решение ДУ
[~, Y3] = ode45(func_ode_td, t, X3(:,i));

plot(Y3(:, 1), Y3(:, 2),'-d', 'LineWidth', 2, 'MarkerIndices', 1)
hold on

end

hold off
grid on
grid minor
title('Фазовый портрет схемы на туннельных диодах с изменением начальных условий')
xlabel('Координата')
ylabel('Скорость')