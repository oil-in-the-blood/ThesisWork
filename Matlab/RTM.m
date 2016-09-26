%Performs the calulations to find the local minima and maxima to perform a
%return map attack on the provided signal S
function [a,b,max,min] = RTM(s)

a = [];
b = [];
min = [];
max = [];

%Vector Test
Nt = numel(s);
if Nt ~= length(s)
 error('Entry must be a vector.')
end


for i = 2:length(s)-1
    if (s(i) >= s(i-1)) && (s(i) > s(i+1))%Bigger than Before and After
        max = [max s(i)];
    elseif (s(i) <= s(i-1)) && (s(i) < s(i+1))%Smaller than Before and After
        min = [min s(i)];
    end
end

%Resize to lowest count
if (size(max,2)>size(min,2))
    max = max(1:size(min,2));
elseif (size(min,2) > size(max,2))
    min = min(1:size(max,2));
end

%The Return Map
a = max + min;
b = max - min;