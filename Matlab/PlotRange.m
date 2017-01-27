function [ecode] = PlotRange(index,t,m,sync)

%start = typecast(start,'uint32');
%ending = typecast(ending,'uint32');
start = index - 5000;
ending = index + 5000;
if start < 0
    start = 0;
end
if ending > size(t,1)
    ending = size(t,1);
end
close all;
plot(t(start:ending),m(start:ending));
hold on;
plot(t(start:ending),sync(start:ending));
%axis([start,ending,-2,2]);