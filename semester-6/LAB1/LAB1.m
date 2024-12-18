set(0,'DefaultFigureWindowStyle','docked');

clc;
clear;
close all;

s = tf('s');

% Временные хар-ки передаточных функций 

% Вариант 1 -> K = 1(нельзя так, слишком просто) -> Пусть K = 5
% K = 5 -> T1 = K / 10 = 0.5
% K = 5 -> T2 = K / 2 = 2.5

K    = 5;
T1 = 0.5;
T2 = 2.5;

K_var  = [5 8];
T1_var = [0.5 0.8];
T2_var = [2.5 4];

%                           1.Интегрирующее звено

% W(s) = K / s;

% Ступенчатое воздействие
W(1) = K / s;
[y_s, t_s] = step(W(1));
figure;
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция интегрирующего звена на ступенчатое воздействие при K = 5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

figure;
desc = [];
for K_1 = K_var
    W(1) = K_1 / s;
    [y_s,t_s] = step(W(1));
    desc = [desc; sprintf('K = %0.1f', K_1)];
    plot(t_s, y_s, 'LineWidth', 2);
    hold on;
end
title('Реакция интегрирующего звена на ступенчатое воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;

% Импульсное воздействие
W(1) = K / s;
[y_i, t_i] = impulse(W(1));
figure;
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция интегрирующего звена на импульсное воздействие');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

figure
desc = [];
for K_1 = K_var
    W(1) = K_1 / s;
    [y_i,t_i] = impulse(W(1));
    desc = [desc; sprintf('K = %0.1f', K_1)];
    plot(t_i, y_i, 'LineWidth', 2);
    hold on;
end

title('Реакция интегрирующего звена на импульсное воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;



%                           2.Дифференцирующее звено
% W(s) = K * s;
% Нельзя


%                           3.Усилительное(безынерционное) звено
% W(s) = K;

% Ступенчатое воздействие
W(3) = tf(K);
[y_s, t_s] = step(W(3));
figure;
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция усилительного звена на ступенчатое воздействие при K = 5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

figure;
desc = [];
for K_1 = K_var
    W(3) = tf(K_1);
    [y_s,t_s] = step(W(3));
    desc = [desc; sprintf('K = %0.1f', K_1)];
    plot(t_s, y_s, 'LineWidth', 2);
    hold on;
end
title('Реакция усилительного звена на ступенчатое воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;

% импульсное воздействие
W(3) = tf(K);
[y_i, t_i] = impulse(W(3));
figure;
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция усилительного звена на импульсное воздействие при K = 5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

figure;
desc = [];
for K_1 = K_var;
    W(3) = tf(K_1);
    [y_i,t_i] = impulse(W(3));
    desc = [desc; sprintf('K = %0.1f', K_1)];
    plot(t_i, y_i, 'LineWidth', 2);
    hold on;
end

title('Реакция усилительного звена на импульсное воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;

%                           4.Апериодическое 1-гопорядка (инерционное) звено

% W(s) = 1 / (T*s + 1)
% T = T2

% Ступенчатое воздействие
W(4) = K / (T2 * s + 1);
[y_s, t_s] = step(W(4));
figure
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция апериодического звена 1-го порядка на ступенчатое воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on
grid minor

desc = [];
figure
for K_1 = K_var
        for T_2 = T2_var
            W(4) = K_1 / (T_2 * s + 1);
            [y_s,t_s] = step(W(4));
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_s, y_s, 'LineWidth', 2);
            hold on;
        end
end

title('Реакция апериодического звена 1-го порядка на ступенчатое воздействие');
xlabel('Время, с')
ylabel('Значение функции')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

% Импульсное воздействие
W(4) = K / (T2 * s + 1);
[y_i, t_i] = impulse(W(4));
figure
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция апериодического звена 1-го порядка на импульсное воздействие при K = 5 T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on
grid minor

desc = [];
figure
for K_1 = K_var
        for T_2 = T2_var
            W(4) = K_1 / (T_2 * s + 1);
            [y_i,t_i] = impulse(W(4));
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_i, y_i, 'LineWidth', 2);
            hold on;
        end
end

title('Реакция апериодического звена 1-го порядка на импульсное воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;



%                           5.Апериодическое 2-го порядка (все корни вещественные)

% W(s) = K / (T2^2 * s^2 + T1 * s + 1) при T2 <= T1;
% T2 <= T1 -> меняем местами T1 и T2  

% Ступенчатое воздействие
W(5) = K / (T1^2 * s^2 + T2 * s + 1); 
[y_s, t_s] = step(W(5));
figure
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция апериодическое звена 2-го порядка на ступенчатое воздействие при K = 5, T1 = 2.5 T2, = 0.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure;
for K_1 = K_var
    for T_1 = T1_var
        for T_2 = T2_var
            W(5) = K_1/(T_1^2 * s^2 + T_2 * s + 1);
            [y_s,t_s] = step(W(5));
            desc = [desc; sprintf('K = %0.1f, T_{1} = %0.1f, T_{2} = %0.1f', K_1, T_2, T_1)];
            plot(t_s, y_s, 'LineWidth', 2);
            hold on;
        end
    end
end

title('Реакция апериодическое звена 2-го порядка на ступенчатое воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;

% Импульсное воздействие
W(5) = K / (T1^2 * s^2 + T2 * s + 1);
[y_i, t_i] = impulse(W(5));
figure
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция апериодическое звена 2-го порядка на импульсное воздействие при K = 5, T1 = 2.5, T2 = 0.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
    for T_1 = T1_var
        for T_2 = T2_var
            W(5) = K_1/(T_1^2 * s^2 + T_2 * s + 1);
            [y_i,t_i] = impulse(W(5));
            desc = [desc; sprintf('K = %0.1f, T_{1} = %0.1f, T_{2} = %0.1f', K_1, T_2, T_1)];
            plot(t_i, y_i, 'LineWidth', 2);
            hold on;
        end
    end
end

title('Реакция апериодическое звена 2-го порядка на импульсное воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;

%                           6.Колебательное звено

% W(6) = K/(T2^2 * s^2 + T1 * s + 1);

% Ступенчатое воздействие
W(6) = K / (T2^2 * s^2 + T1 * s + 1);
[y_s, t_s] = step(W(6));
figure;
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция колебательного звена на ступенчатое воздействие при K = 5, T1 = 0.5, T2 = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
    for T_1 = T1_var
        for T_2 = T2_var
            W(6) = K_1 / (T_2^2 * s^2 + T_1 * s + 1);
            [y_s,t_s] = step(W(6));
            desc = [desc; sprintf('K = %0.1f, T_{1} = %0.1f, T_{2} = %0.1f', K_1, T_1, T_2)];
            plot(t_s, y_s, 'LineWidth', 2);
            hold on;
        end
    end
end

title('Реакция колебательного звена на ступенчатое воздействие')
xlabel('Время, с')
ylabel('Значение функции')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

% Импульсное воздействие
W(6) = K/(T2^2 * s^2 + T1 * s + 1);
[y_i, t_i] = impulse(W(6));
figure
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция колебательного звена на импульсное воздействие при K = 5, T1 = 0.5, T2 = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on
grid minor

desc = [];
figure
for K_1 = K_var
    for T_1 = T1_var
        for T_2 = T2_var
            W(6) = K_1 / (T_2^2 * s^2 + T_1 * s + 1);
            [y_i,t_i] = impulse(W(6));
            desc = [desc; sprintf('K = %0.1f, T_{1} = %0.1f, T_{2} = %0.1f', K_1, T_1, T_2)];
            plot(t_i, y_i, 'LineWidth', 2);
            hold on;
        end
    end
end

title('Реакция колебательного звена на импульсное воздействие')
xlabel('Время, с')
ylabel('Значение функции')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor



%                           7.Kонсервативное звено

% W(s) = K / (T*s^2 + 1)
% T = T2
% !!! Нужно время выставить вручную(у меня 100) !!!


% Ступенчатое воздействие
W(7) = K / (T2 * (s^2) + 1);
[y_s, t_s] = step(W(7), 100);
figure
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция консервативного звена на ступенчатое воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
        for T_2 = T2_var
            W(7) = K_1 / (T_2 * (s^2) + 1);
            [y_s,t_s] = step(W(7), 100);
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_s, y_s, 'LineWidth', 2);
            hold on;
        end
end

title('Реакция консервативного звена на ступенчатое воздействие');
xlabel('Время, с')
ylabel('Значение функции')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

% Импульсное воздействие
W(7) = K / (T2 * (s^2) + 1);
[y_i, t_i] = impulse(W(7), 100);
figure
plot(t_i, y_i, 'LineWidth', 2)
title('Реакция консервативного звена на импульсное воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on
grid minor

desc = [];
figure
for K_1 = K_var
        for T_2 = T2_var
            W(7) = K_1/(T_2 * (s^2) + 1);
            [y_i,t_i] = impulse(W(7), 100);
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_i, y_i, 'LineWidth', 2)
            hold on
        end
end

title('Реакция консервативного звена на импульсное воздействие');
xlabel('Время, с')
ylabel('Значение функции')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor


%                           8.Интегрирующее с запаздыванием (реальное интегрирующее)

% W(s) = K / (s*(T*s + 1))
% T = T2

% Ступенчатое воздействие
W(8) = K / (s * (T2 * s + 1));
[y_s, t_s] = step(W(8));
figure;
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция интегрирующего с запаздыванием звена на ступенчатое воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
        for T_2 = T2_var
            W(8) = K_1 / (s * (T_2 * s + 1));
            [y_s,t_s] = step(W(8));
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_s, y_s, 'LineWidth', 2);
            hold on;
        end
end

title('Реакция интегрирующего с запаздыванием на ступенчатое воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;

% Импульсное воздействие
W(8) = K/(s * (T2 * s + 1));
[y_i, t_i] = impulse(W(8));
figure;
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция интегрирующего с запаздыванием звена на импульсное воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
        for T_2 = T1_var
            W(8) = K_1/(s * (T_2 * s + 1));
            [y_i,t_i] = impulse(W(8));
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_i, y_i, 'LineWidth', 2);
            hold on;
        end
end

title('Реакция интегрирующего с запаздыванием звена на импульсное воздействие');
xlabel('Время, с')
ylabel('Значение функции')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor


%                           9.Дифференцирующее с запаздыванием (реальное дифференцирующее)

% W(s) = (K * s) / (T * s + 1)
% T = T2

% Ступенчатое воздействие
W(9) = (K * s) / (T2 * s + 1);
[y_s, t_s] = step(W(9));
figure;
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция дифференцирующего с запаздыванием звена на ступенчатое воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
            W(9) = (K_1 * s) / (T_2 * s + 1);
            [y_s,t_s] = step(W(9));
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_s, y_s, 'LineWidth', 2);
            hold on
        end
    end
    
title('Реакция дифференцирующего с запаздыванием на ступенчатое воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;
    
% Импульсное воздействие
W(9) = (K * s) / (T2 * s + 1);
[y_i, t_i] = impulse(W(9));
figure;
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция дифференцирующего с запаздыванием звена на импульсное воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(9) = (K_1 * s) / (T_2 * s + 1);
        [y_i,t_i] = impulse(W(9));
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        plot(t_i, y_i, 'LineWidth', 2);
        hold on;
    end
end

title('Реакция дифференцирующего с запаздыванием звена на Импульсное воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;


%                           10.Форсирующее звено

% W(s) = K * (T * s + 1)
% T = T2
% Нельзя

%                           11.Изодромное звено

% W(s) = (K * (T * s + 1)) / s
% T = T2

% Ступенчатое воздействие
W(11) = (K * (T2 * s + 1)) / s;
[y_s, t_s] = step(W(11));
figure;
plot(t_s, y_s, 'LineWidth', 2);
title('Реакция изодромного звена с на ступенчатое воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
            W(11) = (K_1 * (T_2 * s + 1)) / s;
            [y_s,t_s] = step(W(11));
            desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
            plot(t_s, y_s, 'LineWidth', 2);
            hold on;
        end
    end
    
title('Реакция изодромного звена на ступенчатое воздействие');
xlabel('Время, с')
ylabel('Значение функции')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor
    
% Импульсное воздействие
W(11) = (K * (T2 * s + 1)) / s;
[y_i, t_i] = impulse(W(11));
figure;
plot(t_i, y_i, 'LineWidth', 2);
title('Реакция изодромного звена с на импульсное воздействие при K = 5, T = 2.5');
xlabel('Время, с');
ylabel('Значение функции');
grid on;
grid minor;

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(11) = (K_1 * (T_2 * s + 1)) / s;
        [y_i,t_i] = impulse(W(11));
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        plot(t_i, y_i, 'LineWidth', 2);
        hold on;
    end
end

title('Реакция изодромного звена на импульсное воздействие');
xlabel('Время, с');
ylabel('Значение функции');
legend(desc, 'location', 'northeastoutside');
grid on;
grid minor;
