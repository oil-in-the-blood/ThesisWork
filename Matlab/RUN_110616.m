%%%Run for school stuff
SetupConstants;
eta = 5;
freq = .2;
% 
% CSK_Std_PulseTrain                                  %Opens Model
% set_param('CSK_Std_PulseTrain','StopTime','805');   %Sets Stop Time
% sim('CSK_Std_PulseTrain');                          %Runs Simulation
% close_system('CSK_Std_PulseTrain',1);
% 
CSK_Std_PulseTrain_SlidingMode_UU                                  %Opens Model
set_param('CSK_Std_PulseTrain_SlidingMode_UU','StopTime','805');   %Sets Stop Time
sim('CSK_Std_PulseTrain_SlidingMode_UU');                          %Runs Simulation
close_system('CSK_Std_PulseTrain_SlidingMode_UU',1);

range = logspace(-8,-6,20);
weight = .6;

for i = 1:20
   cut = range(i);
   pdata = ProcessSync(t,sync,freq,weight,cut);
   [allbits,misses,hits,lows,highs] = ErrChk(t,pdata,m,freq);

   fprintf('cut: %6.2e misses: %d   out of     %d     low misses: %d     high misses: %d\n',cut,misses,allbits,lows,highs); 
   
end

close all
figure
plot(t,1e-6*m)
hold on
plot(t,sync,'r--')
plot(t,2e-6*pdata,'g--')
axis([0,(1/freq)*8, -1, 1])
axis autoy