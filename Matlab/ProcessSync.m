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
function [pdata] = ProcessSync (t,sync,freq,weight,cut)


r = size(t,1); %How many data points
limit = (1/freq);
q = 0;
sum = 0;
upbound = limit - (1/freq)*weight;
lowbound = limit - (1/freq)*(1-weight);
pdata = zeros(r,1);
sdata = zeros(r,1);
for n = 1:r
    if (t(n) <= limit)
      if(t(n) <= upbound && t(n) >= lowbound)
          q = q + 1;
          sum = sum + 2*sync(n);
      elseif (t(n) < lowbound)
          q = q + 1;
          sum = sum + .5*sync(n);
      else    
          q = q + 1;
          sum = sum + sync(n);
      end
    elseif (t(n) >= limit)
      %disp(['Sum Is:',num2str(sum)]);
      limit = limit + 1/freq;
      %disp(['Time Is:',num2str(t(n))]);
      %disp(['Sum/Q is:',num2str(sum/q)]);
      if ((sum/q) >= cut)
          %disp(['Averaged Greater Than',sum/q]);
          for j = n-q:n
              pdata(j) = 1;
              sdata(j) = sum/q;
          end
      end
      sum = .5*sync(n);
      upbound = limit - (1/freq)*weight;
      lowbound = limit - (1/freq)*(1-weight);
      q = 0;
    end
end
%%errm = abs((m-pdata));
    