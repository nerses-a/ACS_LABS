function dx = lab_ode_diodes(t, x)

dx = zeros(2,1);

    function h = h1(x1)
        
        h = 17.76* x1 - 103.79 *x1^2 + 229.62*x1^3 - 226.31*x1^4 + 83.72*x1^5;
    end

dx(1) = 0.5 * (-h1(x(1)) + x(2));
dx(2) = 0.2 * (-x(1) - 1.5 * x(2) + 1.2);

end