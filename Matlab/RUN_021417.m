sig = 10;
beta = 25.6;
rho = 2;
freq = .1;
x0 = [.1,.2,.3];
z0 = x0;
res = 1000;
pad = .2;
charPERrun = 10;
NPower = 0;
weight = 0.4;
cut = 18;
Ratio = zeros(1,20);
Error = zeros(1,20);
LowError = Error;

q = logspace(-1,1,10);

for i=1:10
    NPower = q(i);
    disp(['Noise = ',num2str(NPower)]);
    TextRun;
    Ratio(i) = SNRavg;
    Error(i) = FinalMissCount/FinalBitCount;
    LowError(i) = FinalLowMissCount/FinalLowBitCount;
end