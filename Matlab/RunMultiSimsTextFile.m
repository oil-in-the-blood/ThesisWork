%clc;
filetouse = 'ErrorLog_MultiRun.txt'; 
bitstotal = 0;
missestotal = 0;
fID = fopen(filetouse,'w');

%Load In Text File
mID = fopen('test.txt','r');
clear siig;
clear nsig;
nsig = [];
siig = fscanf(mID,'%c');
fclose(mID);

%Clear Write to Text File
fSV = fopen('out.txt','w');
fclose(fSV);

fsize = ceil(size(siig,2)/64);

for runno = 1:fsize    
istart = 1+(runno-1)*64;
iend = 64*runno;
nsig = [];
for i=istart:iend
   nsig = [nsig;unicode2native(siig(i))];
end
LoadTextMul;
%Load Initial Conditions
q = size(x1);
qt = q(1);
x0(1) = x1(qt);
q = size(x2);
qt = q(1);
x0(2) = x2(qt);
q = size(x3);
qt = q(1);
x0(3) = x3(qt);
q = size(z1);
qt = q(1);
z0(1) = z1(qt);
q = size(z2);
qt = q(1);
z0(2) = z2(qt);
q = size(z3);
qt = q(1);
z0(3) = z3(qt);
delay = 0;
%Run Sim
disp('Running Simulation');
sim('Timeshift_03_20_2016');
 disp(' ');
%Process and Save Run Errors
disp('Processing Run');
weight = 0.30;
cut = 0.06;
ProcessSync;
ErrChk;
disp(NPower);
disp(['Misses: ',num2str(misses),'/',num2str(cycles)]);
disp(['1 Bit Misses: ',num2str(bitmiss),'/',num2str(highbits)]);
disp(['0 Bit Misses: ',num2str(lowmiss),'/',num2str(lowbits)]);
disp(' ');
fprintf(fID,'1 Bits missed: %3.3f  0 Bits missed: %3.3f Out of: %3.3f\r\n',bitmiss,lowmiss,allbits);
bitstotal = bitstotal+allbits;
missestotal = missestotal + bitmiss + lowmiss;
buildfile;
close all;
plot(t,sync);
hold on;
plot(t,m,'r--');
end

fprintf(fID,'Missed Total: %3.3f Out of: %3.3f\r\n',missestotal,bitstotal);
disp('All Done');