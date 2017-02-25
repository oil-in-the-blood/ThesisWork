function [t0,t1,X0,X1,ti,Xi] = RTIMEM(x,t,m)

ti = [];
Xi = [];
t0 = [];
t1 = [];
X0 = [];
X1 = [];
a = [];

limit = 1;

if(size(t,1) > 1)
    limit = size(t,1);
else
    limit = size(t,2);
end

for e = 2:limit-1
    if(x(e) > x(e-1) && x(e) > x(e+1))
       Xi = [Xi,x(e)];
       ti = [ti,t(e)];
       if(m(e) == 0)
           a = [a 0];
       else
           a = [a 1];
       end
    end
end

for e = 1:size(ti,2)-1
    if (a(e) == 1)
        X1 = [X1 Xi(e)];
        t1 = [t1 ti(e+1)-ti(e)];
    else
        X0 = [X0 Xi(e)];
        t0 = [t0 ti(e+1)-ti(e)];
    end
            
end
   