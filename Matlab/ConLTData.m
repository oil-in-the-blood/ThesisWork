function [time,Vx,Vm] = ConLTData(time,Vx,Vm)

if size(time,1) > size(time,2)
    r = size(time,1);
else
    r = size(time,2);
end


i = 1;
e = 1;
while e > 0
   if abs(time(i)-time(i+1))/time(i) < 1e-4
       time = [time(1:i) time(i+2:r)];
       Vx = [Vx(1:i) Vx(i+2:r)];
       Vm = [Vm(1:i) Vm(i+2:r)];
       r = size(time,2);
   else
       i = i + 1;
   end
    
   if i >= r-1
       e = 0
   end
       
end
    