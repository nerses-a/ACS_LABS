function y = relay(x) %a, b, c

lower = -1;
upper = 1;

a = 15.5;
b = 1;
c = 1;

persistent sts y_prev

if isempty(sts)
    
    sts = lower;
    y_prev = -1;
end

if (sts == upper) && (x <= -b)
    
    y = -c;
    sts = lower;
elseif (sts == lower) && (x >= b)
    
    y = c;
    sts = upper;
else
    
    y = y_prev;
end

y_prev = y;
end