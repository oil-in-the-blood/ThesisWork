function [mins,times,msgat,midx] = MinTest(data,time,msg,w)
mins = [];
times = [];
msgat = [];
midx = [];
istart = w;
iend = size(data,1)-w;
i = istart;
while i < iend
    pe = 1;
    for j = 1:2*w
        if pe == 1 && data(i) <= data(i+(w-j))
            pe = 1;
        else
            pe = 0;
        end
    end
    if pe == 1
        mins = [mins data(i)];
        times = [times time(i)];
        midx = [midx i];
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
    
    