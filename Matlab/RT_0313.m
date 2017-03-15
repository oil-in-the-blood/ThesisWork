% load Run001 time data;
% [peaks,ptime,pmsg] = PeakTest(data(:,2),time,data(:,1));
% [mins,mtime,mmsg] = MinTest(data(:,2),time,data(:,1));
% w = 20;
% 
% [peaks,ptime,pmsg,pidx] = PeakTest(Vx,time,Vmsg,w);
% [mins,mtime,mmsg,midx] = MinTest(Vx,time,Vmsg,w);

A0 = [];
B0 = [];
A1 = [];
B1 = [];

if ptime(1) > mtime(1)
    mtime = mtime(2:size(mtime,2));
    mins = mins(2:size(mins,2));
    mmsg = mmsg(2:size(mmsg,2));
end

if size(ptime,2) > size(mtime,2)
    tr = size(mtime,2);
else
    tr = size(ptime,2);
end

for i = 1:tr
    if pmsg(i) == 1
        A1 = [A1 peaks(i)+mins(i)];
        B1 = [B1 peaks(i)-mins(i)];
    else
        A0 = [A0 peaks(i)+mins(i)];
        B0 = [B0 peaks(i)-mins(i)];
    end
end

dt0 = [];
X0 = [];
dt1 = [];
X1 = [];
for i = 1:size(ptime,2)-1
    if pmsg(i) == 1
        X1 = [X1 peaks(i)];
        dt1 = [dt1 ptime(i+1)-ptime(i)];
    else
        X0 = [X0 peaks(i)];
        dt0 = [dt0 ptime(i+1)-ptime(i)];
    end
end