%Load In M(t) from text
mID = fopen('test3.txt','r');
m2 = fscanf(mID,'%c');
fclose(mID);

%Setup Constants
sTIME = int2str((charPERrun*8/freq) + .1/freq);

nTotRuns = floor(size(m2,2)/charPERrun);

clear x1;
clear x2;
clear x3;
clear z1;
clear z2;
clear z3;

x1 = [x0(1)];
x2 = [x0(2)];
x3 = [x0(3)];
z1 = [z0(1)];
z2 = [z0(2)];
z3 = [z0(3)];

FinalBitCount = zeros(1,20);
FinalMissCount = zeros(1,20);
FinalLowMissCount = zeros(1,20);
FinalLowBitCount = zeros(1,20);
SNRsum = 0;
cuts = 0.001:0.0005:0.01;

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
    
    CSK_TS_4Sec_Message
    set_param('CSK_TS_4Sec_Message','StopTime',sTIME); 
    sim('CSK_TS_4Sec_Message');
    save_system('CSK_TS_4Sec_Message');
    close_system('CSK_TS_4Sec_Message');
    
    warning('on','all');
    fprintf('Character Number %d of %d\n',nRun,nTotRuns);
    for e = 1:19
        pdata = ProcessSync (t,sync,freq,weight,cuts(e));
        [allbits,misses,hits,lowmiss,bitmiss,missindex,lowbits] = ErrChk(t,pdata,m,freq);
    
   
    
        FinalBitCount(e) = FinalBitCount(e) + allbits;
        FinalMissCount(e) = FinalMissCount(e) + misses;
        FinalLowMissCount(e) = FinalLowMissCount(e) + lowmiss;
        FinalLowBitCount(e) = FinalLowBitCount(e) + lowbits;
    
        fprintf('Cut Point:%5.4f\n High Miss: %d out of %d\n Low Miss: %d out of %d\n',cuts(e),FinalMissCount(e)-FinalLowMissCount(e),FinalBitCount(e)-FinalLowBitCount(e),FinalLowMissCount(e),FinalLowBitCount(e));
    end
    
%     SNR = 10*log10((rms(x1)^2)/(rms(ni)^2));
%     
%     disp(['SNR: ',num2str(SNR)]);
%     SNRsum = SNRsum + SNR;
    plot(t,sync,t,m);
end
%disp(['***********************************************************************************']);
% disp(['Final Misses: ',num2str(FinalMissCount),' OUT OF Final Bits:',num2str(FinalBitCount)]);
% disp(['***********************************************************************************']);
% SNRavg = SNRsum/nTotRuns;