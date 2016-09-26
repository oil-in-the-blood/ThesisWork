%{
            Load Text

        Reads in an ASCII Text file and turns it into a bit stream
        file = File Name
        freq = Message Frequency
%}
function [message] = LoadText(fName,freq)

FID = fopen(fName,'r');
clear siig;
clear nsig;
nsig = [];
siig = fscanf(FID,'%c');    %Scan single character
fclose(FID);

for i=1:size(siig,2)
   nsig = [nsig;unicode2native(siig(i))];   %Convert character to number
end

Tp = 1/freq;                        %Set Bit Period
Res = 1000;                         %Resolution in counts per bit
L = size(nsig,1)*(Res)*8 - 1;       %Set Length

tt = (Tp/Res)*[0:L]';               %Set timeset per resolution (signal "t" vector)
fill = zeros(size(tt,1),1);         
afill = fill;
curbit = 0;
temp1 = zeros(1,8);
temp2 = de2bi(nsig(fix(curbit/8)+1)); %Convert decimals to binary vectors 
for f = 1:size(temp2,2)               %Load binary vector into size 8 vector
     temp1(f) = temp2(f);
end
cval = temp1(8-mod(curbit,8));        %current value (in time) is set to first point
for i=1:size(tt,1)
    q = fix(tt(i)/Tp);                %q = time/period (looking for time transistions
    if(q>curbit)                      %Onto next bit
        curbit = curbit + 1;          
        temp1 = zeros(1,8);                     
        temp2 = de2bi(nsig(fix(curbit/8)+1));   %Load in bits
        for f = 1:size(temp2,2)
            temp1(f) = temp2(f);
        end
        cval = temp1(8-mod(curbit,8));  
    end
    
    if(tt(i) > (curbit+1)*Tp-(Tp*.2))       %Add bit padding
        fill(i) = 0;
    else
        fill(i) = cval;
    end
    afill(i) = cval;
    
end
message = [tt fill];                        %Send Message

