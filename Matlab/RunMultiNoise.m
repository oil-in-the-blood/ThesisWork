sig = 10;
rho = 2;
beta = 60;
freq = 1/20;
wc = 2;
Ratio = zeros(8,1);
Error = zeros(8,1);
Ratio2 = zeros(8,1);
levels = logspace(-2,-6);


for e = 1:50

%load in initial conditions
x1 = [0;.5];
x2 = [0; .7];
x3 = [0; .9];
z1 = x1;
z2 = x2;
z3 = x3;
    
NPower = levels(e);

RunMultiSimsTextFile;

NoiseLevel = rms(ni)^2;
SignalLevel = rms(x1)^2;
sn = un-x1;
SNoise = rms(sn)^2;

Ratio(e) = SignalLevel/NoiseLevel;
Error(e) = missestotal/bitstotal;
Ratio2(e) = SignalLevel/SNoise;

end

close all
scatter(Ratio,Error);
set(gca,'xscale','log');