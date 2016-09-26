%{
        Function buildfile

        Takes extracted message pdata and builds an output ASCII file

        fName = file to write to
        
        t = time vector
        
        pdata = extracted message

        freq = message baud

%}
function [] = buildfile(fName,t,pdata,freq)

fSV = fopen(fName,'a');
count = 1/(2*freq);
wrto = zeros(1,fix(t(size(t,1))*freq));
j = 1;

for i = 1:size(t,1)
    
   if(t(i) >= count)
       count = count + 1/freq;
       wrto(j) = pdata(i);
       j = j + 1;
   end
    
end

i = 1;
r = 1;
numwrt = zeros(size(wrto,2)/8,1);
while i < size(wrto,2)
    for j = 0:7
        numwrt(r) = numwrt(r) + wrto(i+j)*(2.^(7-j));
    end
    i = i + 8;
    r = r + 1;
    
end
charwrt = native2unicode(numwrt);

for i = 1:size(charwrt,1)
    fprintf(fSV,'%c',charwrt(i));
end

fclose(fSV);