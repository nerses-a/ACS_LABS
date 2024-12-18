function dx = lab_ode_2(t, x)

    dx = zeros(4,1);
    
    global m l mu g xk Kpt Kpdt Kit Kidt Kpp Kpdp Kip Kidp
    
    persistent t_prev theta_int phi_int dtheta_int dphi_int
    
    if (t == 0)
        
       t_prev     = 0;
       theta_int  = 0;
       phi_int    = 0;
       dtheta_int = 0;
       dphi_int   = 0;
    end
    
    % Ошибки по углу (от заданного значения)
    err_theta = xk(1) - x(1);
    err_phi   = xk(3) - x(3);
    
    % Ошибки по угловой скорости (от заданного значения)
    err_dtheta = xk(2) - x(2);
    err_dphi   = xk(4) - x(4);
    
    % Интегралы ошибок угловых положений
    theta_int = theta_int + err_theta * (t - t_prev);
    phi_int   = phi_int + err_phi * (t - t_prev);
    
    % Интегралы ошибок угловых скоростей
    dtheta_int = dtheta_int + err_dtheta * (t - t_prev);
    dphi_int   = dphi_int + err_dphi * (t - t_prev);
    
    % Регулирующие воздействия по углам
    gamma_theta = Kpt * err_theta + Kit * theta_int;
    gamma_phi = Kpp * err_phi + Kip * phi_int;
    
    % Регулирующие воздействия по угловым скоростям
    gamma_dtheta = Kpdt * err_dtheta + Kidt * dtheta_int;
    gamma_dphi = Kpdp * err_dphi + Kidp * dphi_int;
    
    v(1) = gamma_theta + gamma_dtheta;
    v(2) = gamma_phi + gamma_dphi;
    
    u(1) = -m*l^2*(x(4)^2*cos(x(1))*sin(x(1)) + m*g/l*sin(x(1))) + m*l^2*v(1);
    
    u(2) = m*l^2*(sin(x(1)))^2*(2*x(2)*x(4)*cos(x(1))/sin(x(1)) +...
            mu/(m*l^2*(sin(x(1)))^2)*x(4) - mu/(m*l^2)*x(4)) + ...
            m*l^2*(sin(x(1)))^2 * v(2);
    
    dx(1) = x(2);
    dx(2) = x(4)^2*cos(x(1))*sin(x(1)) + m * g/l *sin(x(1)) - mu/(m * l^2) *x(2) ...
            +1/(m*l^2) * u(1);
    dx(3) = x(4);
    dx(4) = -2*x(2)*x(4)*cos(x(1))/sin(x(1)) - mu/(m*l^2*(sin(x(1)))^2)*x(4) ...
            + 1/(m*l^2*(sin(x(1)))^2)*u(2);
        
    t_prev     = t;
end