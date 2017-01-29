% cut = [.04,.05,.06,.07];
% weight = [.25,.4,.5,.8,1];
% freq = 2;
% 
% for i = 1:4
%     for j = 1:5
%         pdata = ProcessSync(t,sync,freq,weight(j),cut(i));
%         [allbits,misses,hits,lowmiss,bitmiss] = ErrChk(t,pdata,m,freq);
%         fprintf('Cut = %4.2f \t Weight = %4.2f\n',cut(i),weight(j));
%         fprintf('Bitmiss = %4.2f \t Lowmiss = %4.2f\n',bitmiss,lowmiss);
%     end
% end
cut = .02;
weight = .4;
pdata = ProcessSyncPeak2(t,sync,freq,weight,cut);
[allbits,misses,hits,lowmiss,bitmiss,missindex] = ErrChk(t,pdata,m,freq);