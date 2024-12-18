function dx = lab_ode_pendulum(t, x)

dx = zeros(2,1);

dx(1) = x(2);
dx(2) = -10 * sin(x(1)) - x(2);

% Критерий линейности: f (ax + by) = af(x) + bf(y)

end