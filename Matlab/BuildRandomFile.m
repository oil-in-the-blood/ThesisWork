fID = fopen('test3.txt','w');


for e = 1:2500
    r = 32 + randi(94);
    fprintf(fID,'%c',r);
end

fclose(fID);