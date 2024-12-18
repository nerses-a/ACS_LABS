set(0,'DefaultFigureWindowStyle','docked');

clc;
clear;
close all;

s = tf('s');

% ЛАФЧХ систем

% Вариант 1 -> K = 1(нельзя так, слишком просто) -> Пусть K = 5
% K = 5 -> T1 = K / 10 = 0.5
% K = 5 -> T2 = K / 2 = 2.5

K    = 5;
T1 = 0.5;
T2 = 2.5;

K_var  = [5 8];
T1_var = [0.5 0.8];
T2_var = [2.5 4];

%{
    Если работает медленно или лагет, рекомендую запускать по частьям,
    коментируя остальные части через %{ %}
%}

%                           1.Интегрирующее звено

% W(s) = K / s;

figure;
desc = [];
for K_1 = K_var
    W(1) = K_1 / s;
    desc = [desc; sprintf('K = %0.1f', K_1)];

    
    % Получение АФЧХ
    [mag,phase,wout] = bode(W(1));

    % Преобразование размерностей вектора значений
    mag = squeeze(mag(1,1,:));
    phase = squeeze(phase(1,1,:));
    
    % Строим
    subplot(2,1,1)
    semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
    hold on

    subplot(2,1,2)
    semilogx(wout, phase, 'LineWidth', 1)
    hold on

end
subplot(2,1,1)
title('Логарифмическая амплитудная характеристика интегрирующего звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика интегрирующего звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor


%                           2.Дифференцирующее звено
% W(s) = K * s;

figure;
desc = [];
for K_1 = K_var
    W(2) = K_1 * s;
    desc = [desc; sprintf('K = %0.1f', K_1)];

    
    % Получение АФЧХ
    [mag,phase,wout] = bode(W(2));

    % Преобразование размерностей вектора значений
    mag = squeeze(mag(1,1,:));
    phase = squeeze(phase(1,1,:));
    
    % Строим
    subplot(2,1,1)
    semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
    hold on

    subplot(2,1,2)
    semilogx(wout, phase, 'LineWidth', 1)
    hold on

end
subplot(2,1,1)
title('Логарифмическая амплитудная характеристика дифференцирующего звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика дифференцирующего звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

%                           3.Усилительное(безынерционное) звено
% W(s) = K;

figure;
desc = [];
for K_1 = K_var
    W(3) = tf(K_1);
    desc = [desc; sprintf('K = %0.1f', K_1)];
    % Получение АФЧХ
    [mag,phase,wout] = bode(W(3));
    
    % Преобразование размерностей вектора значений
    mag = squeeze(mag(1,1,:));
    phase = squeeze(phase(1,1,:));
    
    % Строим
    subplot(2,1,1)
    semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
    hold on
    
    subplot(2,1,2)
    semilogx(wout, phase, 'LineWidth', 1)
    hold on
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика усилительного звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика усилительного звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

%                           4.Апериодическое 1-гопорядка (инерционное) звено

% W(s) = 1 / (T*s + 1)
% T = T2


W(4) = K / (T2 * s + 1);


desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(4) = K_1 / (T_2 * s + 1);
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        
        % Получение АФЧХ
        [mag,phase,wout] = bode(W(4));
        
        % Преобразование размерностей вектора значений
        mag = squeeze(mag(1,1,:));
        phase = squeeze(phase(1,1,:));
        
        % Строим
        subplot(2,1,1)
        semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
        hold on
        
        subplot(2,1,2)
        semilogx(wout, phase, 'LineWidth', 1)
        hold on
    end
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика апериодического звена 1-гопорядка')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика апериодического звена 1-гопорядка')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor



%                           5.Апериодическое 2-го порядка (все корни вещественные)

% W(s) = K / (T2^2 * s^2 + T1 * s + 1) при T2 <= T1;
% T2 <= T1 -> меняем местами T1 и T2  

desc = [];
figure;
for K_1 = K_var
    for T_1 = T1_var
        for T_2 = T2_var
            W(5) = K_1/(T_1^2 * s^2 + T_2 * s + 1);
            desc = [desc; sprintf('K = %0.1f, T_{1} = %0.1f, T_{2} = %0.1f', K_1, T_2, T_1)];
            % Получение АФЧХ
            [mag,phase,wout] = bode(W(5));
            
            % Преобразование размерностей вектора значений
            mag = squeeze(mag(1,1,:));
            phase = squeeze(phase(1,1,:));
            
            % Строим
            subplot(2,1,1)
            semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
            hold on
            
            subplot(2,1,2)
            semilogx(wout, phase, 'LineWidth', 1)
            hold on
        end
    end
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика апериодического звена 2-гопорядка')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика апериодического звена 2-гопорядка')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

%                           6.Колебательное звено

% W(6) = K/(T2^2 * s^2 + T1 * s + 1);

desc = [];
figure
for K_1 = K_var
    for T_1 = T1_var
        for T_2 = T2_var
            W(6) = K_1 / (T_2^2 * s^2 + T_1 * s + 1);
            desc = [desc; sprintf('K = %0.1f, T_{1} = %0.1f, T_{2} = %0.1f', K_1, T_1, T_2)];
            % Получение АФЧХ
            [mag,phase,wout] = bode(W(6));
            
            % Преобразование размерностей вектора значений
            mag = squeeze(mag(1,1,:));
            phase = squeeze(phase(1,1,:));
            
            % Строим
            subplot(2,1,1)
            semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
            hold on
            
            subplot(2,1,2)
            semilogx(wout, phase, 'LineWidth', 1)
            hold on
        end
    end
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика колебательного звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика колебательного звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor



%                           7.Kонсервативное звено

% W(s) = K / (T*s^2 + 1)
% T = T2

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(7) = K_1 / (T_2 * (s^2) + 1);
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        % Получение АФЧХ
        [mag,phase,wout] = bode(W(7));
        
        % Преобразование размерностей вектора значений
        mag = squeeze(mag(1,1,:));
        phase = squeeze(phase(1,1,:));
        
        % Строим
        subplot(2,1,1)
        semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
        hold on
        
        subplot(2,1,2)
        semilogx(wout, phase, 'LineWidth', 1)
        hold on
    end
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика консервативного звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика консервативного звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor


%                           8.Интегрирующее с запаздыванием (реальное интегрирующее)

% W(s) = K / (s*(T*s + 1))
% T = T2

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(8) = K_1 / (s * (T_2 * s + 1));
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        % Получение АФЧХ
        [mag,phase,wout] = bode(W(8));
        
        % Преобразование размерностей вектора значений
        mag = squeeze(mag(1,1,:));
        phase = squeeze(phase(1,1,:));
        
        % Строим
        subplot(2,1,1)
        semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
        hold on
        
        subplot(2,1,2)
        semilogx(wout, phase, 'LineWidth', 1)
        hold on
    end
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика интегрирующего с запаздыванием звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика интегрирующего с запаздыванием звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor


%                           9.Дифференцирующее с запаздыванием (реальное дифференцирующее)

% W(s) = (K * s) / (T * s + 1)
% T = T2

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(9) = (K_1 * s) / (T_2 * s + 1);
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        % Получение АФЧХ
        [mag,phase,wout] = bode(W(9));
        
        % Преобразование размерностей вектора значений
        mag = squeeze(mag(1,1,:));
        phase = squeeze(phase(1,1,:));
        
        % Строим
        subplot(2,1,1)
        semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
        hold on
        
        subplot(2,1,2)
        semilogx(wout, phase, 'LineWidth', 1)
        hold on
    end
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика дифференцирующего с запаздыванием звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

subplot(2,1,2)
title('Логарифмическая фазовая характеристика дифференцирующего с запаздыванием звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor

    
%                           10.Форсирующее звено
% W(s) = K * (T * s + 1)
% T = T2
    
desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(10) = K_1 * (T_2 * s + 1);
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        % Получение АФЧХ
        [mag,phase,wout] = bode(W(10));
        
        % Преобразование размерностей вектора значений
        mag = squeeze(mag(1,1,:));
        phase = squeeze(phase(1,1,:));
        
        % Строим
        subplot(2,1,1)
        semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
        hold on
        
        subplot(2,1,2)
        semilogx(wout, phase, 'LineWidth', 1)
        hold on
    end
end
    
subplot(2,1,1)
title('Логарифмическая амплитудная характеристика форсирующего звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor
    
subplot(2,1,2)
title('Логарифмическая фазовая характеристика форсирующего звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor


%                           11.Изодромное звено

% W(s) = (K * (T * s + 1)) / s
% T = T2

desc = [];
figure
for K_1 = K_var
    for T_2 = T2_var
        W(11) = (K_1 * (T_2 * s + 1)) / s;
        desc = [desc; sprintf('K = %0.1f, T = %0.1f', K_1, T_2)];
        % Получение АФЧХ
        [mag,phase,wout] = bode(W(11));
        
        % Преобразование размерностей вектора значений
        mag = squeeze(mag(1,1,:));
        phase = squeeze(phase(1,1,:));
        
        % Строим
        subplot(2,1,1)
        semilogx(wout, 20 * log10(mag), 'LineWidth', 1)
        hold on
        
        subplot(2,1,2)
        semilogx(wout, phase, 'LineWidth', 1)
        hold on
    end
end

subplot(2,1,1)
title('Логарифмическая амплитудная характеристика изодромного звена')
xlabel('Частота, рад/с')
ylabel('Амплитуда, дБ')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor
    
subplot(2,1,2)
title('Логарифмическая фазовая характеристика изодромного звена')
xlabel('Частота, рад/с')
ylabel('Фаза, град')
legend(desc, 'location', 'northeastoutside')
grid on
grid minor
