%The Run is to gather the RTM for the CSK-TS modulus system

fSave = 'CSK_TS_RUN_092716.txt';
SetupConstants;
CSK_TS_MOD_PulseTrain                                  %Opens Model
set_param('CSK_TS_MOD_PulseTrain','StopTime','800');   %Sets Stop Time
sim('CSK_TS_MOD_PulseTrain');                          %Runs Simulation
close_system('CSK_TS_MOD_PulseTrain',1);

[a1,a0,b1,b0,max,min] = RTM(x1,m);                     %Get Return Map Attack

pdata = ProcessSync(t,sync,freq,weight,cut);
[allbits,misses] = ErrChk(t,pdata,m,freq);

save(['Data\' fSave],'a1','b1','a0','b0');