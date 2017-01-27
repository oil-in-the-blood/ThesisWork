for i = 1:size(t,1)
    
    if(t(i) > 0)
        break;     
    end
end

for j = 1:size(t,1)
    if(t(j) > 10)
        break;
    end
end

fprintf('%d to %d\n',i,j);