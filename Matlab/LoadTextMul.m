Tp = 1/freq;             %Set Bit Period
Res = 1000;         %Resolution in counts per bit
L = size(nsig,1)*(Res)*8 - 1; 

tt = (Tp/Res)*[0:L]';
fill = zeros(size(tt,1),1);
afill = fill;
curbit = 0;
temp1 = zeros(1,8);
temp2 = de2bi(nsig(fix(curbit/8)+1));
for f = 1:size(temp2,2)
     temp1(f) = temp2(f);
end
cval = temp1(8-mod(curbit,8));
for i=1:size(tt,1)
    q = fix(tt(i)/Tp);
    if(q>curbit)
        curbit = curbit + 1;
        temp1 = zeros(1,8);
        temp2 = de2bi(nsig(fix(curbit/8)+1));
        for f = 1:size(temp2,2)
            temp1(f) = temp2(f);
        end
        cval = temp1(8-mod(curbit,8));
    end
    
    if(tt(i) > (curbit+1)*Tp-(Tp*.2))
        fill(i) = 0;
    else
        fill(i) = cval;
    end
    afill(i) = cval;
    
end
message = [tt fill];

