ts = .008;
[t,x] = Interpol(time,Vx,ts);

Fs = 1/ts;
L = size(t,2);
%t = 0:1/Fs:(1/Fs)*L;
%x = sin(2*pi*10*t)+sin(2*pi*100*t)+10*sin(2*pi*400*t);

Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs * (0:(L/2))/L;
plot(f,P1);
dB = 10*log10(P1);
figure
plot(f,dB);