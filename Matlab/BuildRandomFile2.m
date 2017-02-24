fID = fopen('test5.txt','w');

for e = 1:7500
    r = 32 + randi(94);
    fprintf(fID,'%c',r);
end

fclose(fID);