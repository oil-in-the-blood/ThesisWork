%RUN 09/28/16
%Runs the Plus or Minus CSK-TS scheme for RTM comparison

fSave = 'CSK_TS_PM_RUN_092716';
SetupConstants;
CSK_TS_PM_PulseTrain                                  %Opens Model
set_param('CSK_TS_PM_PulseTrain','StopTime','800');   %Sets Stop Time
sim('CSK_TS_PM_PulseTrain');                          %Runs Simulation
close_system('CSK_TS_PM_PulseTrain',1);

[a1,a0,b1,b0,max,min] = RTM(x1,m);                     %Get Return Map Attack

pdata = ProcessSync(t,sync,freq,weight,cut);
[allbits,misses] = ErrChk(t,pdata,m,freq);

save(['Data\' fSave],'a1','b1','a0','b0');