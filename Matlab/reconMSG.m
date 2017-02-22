function [m] = reconMSG(msg,f,t)

per = 1/f;
m = zeros(size(msg,1),1);
g = 1;
count = 0;
sum = 0;
istart = 1;
iend = 0;

for u = 1:size(msg,1)
    if (t(u) > g*per)
        g = g+1;
        avg = sum/count;
        iend = u-1;
        if avg > 1
            for r = istart:iend
               m(r) = 1; 
            end
        end
        sum = 0;
        count = 0;
        istart = u;
    end
    sum = sum + msg(u);
    count = count + 1;
end