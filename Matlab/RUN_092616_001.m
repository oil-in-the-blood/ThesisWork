%This run is to gather data from the std CSK system to generate a RTM and
%compare to a similar CSK-TS Systems

fSave = 'CSK_Std_RUN_092616.txt';
SetupConstants;
CSK_Std_PulseTrain                                   %Opens Model
set_param('CSK_Std_PulseTrain','StopTime','200');   %Sets Stop Time
%sim('CSK_Std_PulseTrain');                           %Runs Simulation

[a1,a0,b1,b0,max,min] = RTM(x1,m);                             %Get Return Map Attack

pdata = ProcessSync(t,sync,freq,weight,cut);
[allbits,misses] = ErrChk(t,pdata,m,freq);

%savefileforRTM;