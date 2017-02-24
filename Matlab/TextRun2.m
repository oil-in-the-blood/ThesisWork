%Load In M(t) from text
mID = fopen('test5.txt','r');
m2 = fscanf(mID,'%c');
fclose(mID);

%Setup Constants
sTIME = int2str((charPERrun*8/freq) + .1/freq);

nTotRuns = floor(size(m2,2)/charPERrun);

% clear x1;
% clear x2;
% clear x3;
% clear z1;
% clear z2;
% clear z3;
% 
% x1 = [x0(1)];
% x2 = [x0(2)];
% x3 = [x0(3)];
% z1 = [z0(1)];
% z2 = [z0(2)];
% z3 = [z0(3)];

% FinalBitCount = 0;
% FinalMissCount = 0;
% FinalLowMissCount = 0;
% FinalLowBitCount = 0;
% SNRsum = 0;


for nRun = 1:nTotRuns
	istart = 1+(nRun-1)*charPERrun;
	iend = charPERrun*nRun;
	nsig = [];
	for u = istart:iend
		nsig = [nsig;unicode2native(m2(u))];
	end
	[message] = cmsg2bitmsg(nsig,freq,res,pad); 
	
    %%%%%%%%%SET UP INITIAL CONDITIONS FOR RUN
    x0 = [x1(size(x1,1)) x2(size(x2,1)) x3(size(x3,1))];
    z0 = [z1(size(z1,1)) z2(size(z2,1)) z3(size(z3,1))];
    
    warning('off','all');
    
    CSK_TS_PM_Message
    set_param('CSK_TS_PM_Message','StopTime',sTIME); 
    sim('CSK_TS_PM_Message');
    save_system('CSK_TS_PM_Message');
    close_system('CSK_TS_PM_Message');
    
    warning('on','all');
    
    
    pdata = ProcessSync (t,sync,freq,weight,cut);
    [allbits,misses,hits,lowmiss,bitmiss,missindex,lowbits] = ErrChk(t,pdata,m,freq);
    
   
    
    FinalBitCount = FinalBitCount + allbits;
    FinalMissCount = FinalMissCount + misses;
    FinalLowMissCount = FinalLowMissCount + lowmiss;
    FinalLowBitCount = FinalLowBitCount + lowbits;
    
    fprintf('Character Number %d of %d\n High Miss: %d out of %d\n Low Miss: %d out of %d\n',nRun,nTotRuns,FinalMissCount-FinalLowMissCount,FinalBitCount-FinalLowBitCount,FinalLowMissCount,FinalLowBitCount);
    
    
%     SNR = 10*log10((rms(x1)^2)/(rms(ni)^2));
%     
%     disp(['SNR: ',num2str(SNR)]);
%     SNRsum = SNRsum + SNR;
    
end
%disp(['***********************************************************************************']);
disp(['Final Misses: ',num2str(FinalMissCount),' OUT OF Final Bits:',num2str(FinalBitCount)]);
disp(['***********************************************************************************']);
% SNRavg = SNRsum/nTotRuns;