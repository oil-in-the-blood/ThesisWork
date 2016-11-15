SetupConstants;

CSK_Std_PulseTrain                                  %Opens Model
set_param('CSK_Std_PulseTrain','StopTime','50');   %Sets Stop Time
sim('CSK_Std_PulseTrain');                          %Runs Simulation
close_system('CSK_Std_PulseTrain',1);

figure
plot(t,.5*m)
hold on
plot(t,error,'r--')

figure
plot3(x1,x2,x3)