function dx = lab_ode_vanderpole(t, x)

dx = zeros(2,1);

mu = 0.5;

dx(1) = x(2);
dx(2) = -x(1) + mu * (1 - (x(1)) ^ 2) * x(2);

end