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
Fs = 1/ts;
Ln = size(nbitx,1);

Yn = fft(nbitx);
P2n = abs(Yn/Ln);
P1n = P2n(1:Ln/2+1);
P1n(2:end-1) = 2*P1n(2:end-1);
fn = Fs * (0:(Ln/2))/Ln;
dBn = 10*log10(P1n);
figure
plot(fn,dBn);


Lz = size(zbitx,1);

Yz = fft(zbitx);
P2z = abs(Yz/Lz);
P1z = P2z(1:Lz/2+1);
P1z(2:end-1) = 2*P1z(2:end-1);
fz = Fs * (0:(Lz/2))/Lz;
dBz = 10*log10(P1z);
figure
plot(fz,dBz);

Lq = size(qbitx,1);

Yq = fft(qbitx);
P2q = abs(Yq/Lq);
P1q = P2z(1:Lq/2+1);
P1q(2:end-1) = 2*P1q(2:end-1);
fq = Fs * (0:(Lq/2))/Lq;
dBq = 10*log10(P1q);
figure
plot(fq,dBq);