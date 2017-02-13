%Performs the calulations to find the local minima and maxima to perform a
%return map attack on the provided signal S
function [a1,a0,b1,b0,max,min] = RTM(s,m)

a0 = [];
a1 = [];
b0 = [];
b1 = [];
min = [];
max = [];
mATmax = [];

%Vector Test
Nt = numel(s);
if Nt ~= length(s)
 error('Entry must be a vector.')
end


for i = 2:length(s)-1
    if (s(i) >= s(i-1)) && (s(i) > s(i+1))%Bigger than Before and After
        max = [max s(i)];
        mATmax = [mATmax m(i)];
    elseif (s(i) <= s(i-1)) && (s(i) < s(i+1))%Smaller than Before and After
        min = [min s(i)];
    end
end

%Resize to lowest count
if (size(max,2)>size(min,2))
    max = max(1:size(min,2));
    mATmax = mATmax(1:size(min,2));
elseif (size(min,2) > size(max,2))
    min = min(1:size(max,2));
end

%The Return Map
r = size(max,2);
for n = 1:r
   if(mATmax(n) > .5)
        a1 = [a1 max(n)+min(n)];
        b1 = [b1 max(n)-min(n)];
   else
       a0 = [a0 max(n)+min(n)];
       b0 = [b0 max(n)-min(n)];
   end
end