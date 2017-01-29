function [cleansync] = SignalClean(sync,threshold)

cleansync = zeros(size(sync,1),1);

for n = 1:size(sync,1)
   if(abs(sync(n)) < threshold)
       cleansync(n) = 0;
       
   else
       cleansync(n) = abs(sync(n));
   end
end