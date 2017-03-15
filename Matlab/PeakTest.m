function [peaks,times,msgat,pidx] = PeakTest(data,time,msg,w)
peaks = [];
times = [];
msgat = [];
pidx = [];
istart = w;
iend = size(data,2)-w;
i = istart;
while i < iend
    pe = 1;
    for j = 1:2*w
        if pe == 1 && data(i) >= data(i+(w-j))
            pe = 1;
        else
            pe = 0;
        end
    end
    if pe == 1
        peaks = [peaks data(i)];
        times = [times time(i)];
        pidx = [pidx i];
        i = i+w;
        if msg(i) > .8
            msgat = [msgat 1];
        else
            msgat = [msgat 0];
        end
    else
        i = i+1;
    end
    
end
    
    