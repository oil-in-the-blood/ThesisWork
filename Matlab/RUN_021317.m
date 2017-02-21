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

q = logspace(-1,3,10);

for i=1:10
    cut = q(i);
    disp(['Cutoff = ',num2str(cut)]);
    TextRun;
    disp(['Cutoff = ',num2str(cut)]);
end