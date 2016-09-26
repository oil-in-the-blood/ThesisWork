%{
        Error Checking function
        
            Checks for missed bit errors in Pdata compared to the message
            signal m

            t = Time Vector

            pdata = extracted message vector

            m = original message vector

            freq = message baud rate

            allbits = total number of bits

            misses = total number of missed bits

            hits = total number of non missed bits

            lowmiss = missed bit on a 0 value in message

            bitmiss = missed bit on a 1 value in message

%}

function [allbits,misses,hits,lowmiss,bitmiss] = ErrChk(t,pdata,m,freq)

r = size(t,1);
spot = (1/freq)/2;
cycles = 0;
hits = 0;
misses = 0;
lowmiss = 0;
bitmiss = 0;
missloc = 0;
lowbits = 0;
highbits = 0;
%fID = fopen(filetouse,'w');
%fprintf(fID,'Miss Time\tM(t)\tMR(t)\r\n');
for n = 1:r
    if t(n) >= spot;
        cycles = cycles + 1;
        spot = spot + 1/freq;
        t1 = pdata(n);
        t2 = m(n);
        t3 = t(n);
        
        if m(n) == 0
            lowbits = lowbits + 1;
        else
            highbits = highbits + 1;
        end
        
        if pdata(n) == m(n)
            hits = hits+1;
        else
            if (m(n) == 0)
                lowmiss = lowmiss + 1;
            else
                bitmiss = bitmiss + 1;
            end
            misses = misses + 1;
            missloc = [missloc, t3];
            %fprintf(fID,'%10.5f\t%2.1f\t%2.1f\r\n',t3,t2,t1);
        end
    end
end

% hitrate = hits/cycles;
% missrate = misses/cycles;
 allbits = highbits + lowbits;
% fprintf(fID,'Hit Rate: %3.3f\r\n',hitrate*100);
% fprintf(fID,'Miss Rate: %3.3f\r\n',missrate*100);
% fprintf(fID,'1 Bits missed: %3.3f\r\n',bitmiss);
% fprintf(fID,'0 Bits missed: %3.3f\r\n',lowmiss);
% fclose(fID);