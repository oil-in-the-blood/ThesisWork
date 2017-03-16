% SetupConstants;
% beta = 25.6;
% CSK_TS_PM_PulseTrain                                  %Opens Model
% set_param('CSK_TS_PM_PulseTrain','StopTime','300');   %Sets Stop Time
% sim('CSK_TS_PM_PulseTrain');                          %Runs Simulation
% close_system('CSK_TS_PM_PulseTrain',1);

%ts = .008;
%[ti,xi] = Interpol(time1,Vx,ts);
%
ts = time(2)-time(1);
ti = time';
xi = X';
Fs = 1/ts;
L = size(ti,2);

Y = fft(xi);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs * (0:(L/2))/L;
plot(f,P1);
dB = 10*log10(P1);
figure
plot(f,dB);