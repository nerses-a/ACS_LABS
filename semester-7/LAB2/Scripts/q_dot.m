function out = q_dot(a)

% a = 15.5;
b = 1;
c = 1;

if (a >= b)
    
    out = -4*c*b/(pi*a^2);
else
    
    out = 0;    
end

end