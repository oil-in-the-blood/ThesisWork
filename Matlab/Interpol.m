function [ti,xi] = Interpol(t,x,ts)

ti = 0:ts:(floor(t(size(t,1))/ts)*ts);
xi = zeros(1,size(ti,1));
dex = [];
dcount = 1;
for i = 1:size(t,1)
   if t(i) == ti(dcount)
       dex = [dex i];
       xi(dcount) = x(i);
       dcount = dcount + 1;
   elseif i > 1
       if t(i-1) < ti(dcount) && t(i) > ti(dcount)
            k = (ti(dcount)-t(i-1))/(t(i)-t(i-1));
            xi(dcount) = k*(x(i)-x(i-1))+x(i-1);
            dcount = dcount + 1;
       end
   end
end
