%{
        Process Sync,

            Processes the syncronized signal error into a readable
            bitstream (i.e. message extraction)
            
            t = time vector
            sync = sync signal
            freq = expected bit frequency
            weight = Center weighting (0-1 value)
            cut = cutoff level for 0 and 1 value
%}
function [pdata] = ProcessSyncPeak2 (t,sync,freq,weight,cut)


r = size(t,1); %How many data points
limit = (1/freq);
q = 0;
sum = 0;
peaks = 0;
upbound = limit - (1/freq)*weight;
lowbound = limit - (1/freq)*(1-weight);
pdata = zeros(r,1);
sdata = zeros(r,1);
avgpeaksize = 0;
avgpeakcount = 0;
ovpeaks = 0;
for n = 1:r
   if (abs(sync(n)) < 0.04)
       sdata(n) = 0;
   else
       sdata(n) = abs(sync(n));
   end
end

for n = 2:r-1
     priorS = abs(sdata(n-1));
     curS = abs(sdata(n));
     nextS = abs(sdata(n+1));
     if(curS > priorS && curS > nextS)
         avgpeaksize = avgpeaksize + curS;
         avgpeakcount = avgpeakcount + 1;
     end
end
avgpeaksize = avgpeaksize/avgpeakcount;
for n = 2:r-1
    if (t(n) <= limit)
      priorS = abs(sdata(n-1));
      curS = abs(sdata(n));
      nextS = abs(sdata(n+1));
      q = q+1;
      if(curS > priorS && curS > nextS)
          if(curS >= avgpeaksize*.8)
            ovpeaks = ovpeaks + 1;
          end
          peaks = peaks + 1;
          sum = sum + curS;
%           disp(['Peak: ',num2str(curS),' @: ',num2str(t(n))]);
      end
    elseif (t(n) >= limit)
%       disp(['Sum Is:',num2str(sum)]);
      limit = limit + 1/freq;
%       disp(['Time Is:',num2str(t(n))]);
%       disp(['Peak Number is:',num2str(peaks)]);
%       disp(['Peak Average:',num2str(sum/peaks)]);
      if (ovpeaks > 4 && sum/peaks > cut)
          %disp(['Averaged Greater Than',sum/q]);
          for j = n-q:n
              pdata(j) = 1;
          end
      end
      sum = 0;
      upbound = limit - (1/freq)*weight;
      lowbound = limit - (1/freq)*(1-weight);
      q = 0;
      peaks = 0;
      ovpeaks = 0;
    end
end
%%errm = abs((m-pdata));
    