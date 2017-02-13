% SetupConstants
% close all;
% beta = 60;
% rho = 2;
% sig = 10;
% 
% % CSK_Std_PulseTrain
% % set_param('CSK_Std_PulseTrain','StopTime','300');   %Sets Stop Time
% % sim('CSK_Std_PulseTrain');                          %Runs Simulation
% % close_system('CSK_Std_PulseTrain',1);
% 
% %[a1,a0,b1,b0,max,min] = RTM(x1,m);
% 
% % figure
% % scatter(a1,b1,'rx')
% % hold on
% % scatter(a0,b0,'bp')
% % p = get(gca, 'Position');
% % h = axes('Parent', gcf, 'Position', [p(1)+.56 p(2)+.56 p(3)-.5 p(4)-.5]);
% % box on
% % scatter(a0,b0,'bp');
% % hold on
% % scatter(a1,b1,'rx')
% % axis tight
% %set(h, 'Xlim', [-0.2 0], 'Ylim', [-5 -4]);
% 
% beta = 25.6;
% CSK_TS_PM_PulseTrain                                  %Opens Model
% set_param('CSK_TS_PM_PulseTrain','StopTime','300');   %Sets Stop Time
% sim('CSK_TS_PM_PulseTrain');                          %Runs Simulation
% close_system('CSK_TS_PM_PulseTrain',1);
% 
% [a1,a0,b1,b0,max,min] = RTM(x1,m);

figure
scatter(a1,b1,'rx')
hold on
scatter(a0,b0,'bp')
% p = get(gca, 'Position');
% h = axes('Parent', gcf, 'Position', [p(1)+.56 p(2)+.56 p(3)-.5 p(4)-.5]);
% box on
% scatter(a0,b0,'bp');
% hold on
% scatter(a1,b1,'rx')
% axis tight