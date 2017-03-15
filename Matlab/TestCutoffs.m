cuts = logspace(-5,-3,20);
sts = .2:.01:.4;

for j = 1:20
   totalLOWbits = 0;
   totalHIGHbits = 0;
   totalHIGHmiss = 0;
   totalLOWmiss = 0;
   for k = 1:1620
      fname = ['Run',num2str(k)];
      load(fname,'time','sync','data');
      %condata = Condition(data(:,2);
      message = data(:,1);
      sync = data(:,3).*data(:,3);
      m = reconMSG(message,f,time);
      pdata = ProcessSync(time,sync,f,1,cuts(j));
      [allbits,misses,hits,lowmiss,bitmiss,missindex,lowbits] = ErrChk(time,pdata,m,f);
      totalLOWbits = totalLOWbits + lowbits;
      totalHIGHbits = totalHIGHbits + (allbits-lowbits);
      totalHIGHmiss = totalHIGHmiss + bitmiss;
      totalLOWmiss = totalLOWmiss + lowmiss;
      %plot(time,m,time,message,time,sync,time,pdata);
   end
   fprintf('Cutoff %3.2e\n High Miss: %d out of %d\n Low Miss: %d out of %d\n',cuts(j),totalHIGHmiss,totalHIGHbits,totalLOWmiss,totalLOWbits)
end