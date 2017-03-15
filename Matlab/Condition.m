function [condata] = Condition(dat,st)

condata = zeros(size(dat,1),1);

for w = 1:size(dat,1)
    if abs(dat(w)) < st
        condata(w) = 0;
    else
        condata(w) = dat(w);
    end
    
end