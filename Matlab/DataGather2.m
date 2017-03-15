s = daq.createSession('ni');
% p1 = serial('COM4');
% set(p1,'BaudRate',9600);
%fopen(p1);
s.Rate = 5000;
s.DurationInSeconds = 16.1;
ch1 = addAnalogInputChannel(s,'Dev1',1,'Voltage');
ch1.Range = [-10,10];
ch1.TerminalConfig = 'SingleEnded';
ch0 = addAnalogInputChannel(s,'Dev1',0,'Voltage');
ch0.Range = [-10,10];
ch0.TerminalConfig = 'SingleEnded';
tc = addTriggerConnection(s,'external','Dev1/PFI0','StartTrigger');
s.Connections(1).TriggerCondition = 'FallingEdge';
lh = addlistener(s,'DataAvailable',@mvData);
s.NotifyWhenDataAvailableExceeds = s.DurationInSeconds * s.Rate;
pause(3);

mID = fopen('test3.txt','r');
m2 = fscanf(mID,'%c');
fclose(mID);
fprintf(p1,'width:75')
fprintf(p1,'mode:0')
fprintf(p1,'period:2000')
f = .5;
totalHIGHbits = 0;
totalLOWbits = 0;
totalHIGHmiss = 0;
totalLOWmiss = 0;
fname = 'Run';


for i = 1:size(m2,2)
    fprintf(p1,'%s','message:')
    fprintf(p1,'%c',m2(i))
    fprintf(p1,'');
    disp(['At ',num2str(i),' of ',num2str(size(m2,2))]);
    s.startBackground;
    fprintf(p1,'start')
    s.wait();
    load log.mat time message sync data;
    tosv = [fname num2str(i)];
    condata = Condition(data(:,2));
    data = [data(:,1) data(:,2) condata];
    save(tosv,'time','sync','data');
    plot(time,data(:,1),'b',time,data(:,2),'r',time,data(:,3)+2,'g');
    sync = data(:,3).*data(:,3);
    m = reconMSG(message,f,time);
    pdata = ProcessSync(time,sync,f,1,.0008);
    plot(time,m,time,message,time,sync,time,pdata);
    [allbits,misses,hits,lowmiss,bitmiss,missindex,lowbits] = ErrChk(time,pdata,m,f);
    totalLOWbits = totalLOWbits + lowbits;
    totalHIGHbits = totalHIGHbits + (allbits-lowbits);
    totalHIGHmiss = totalHIGHmiss + bitmiss;
    totalLOWmiss = totalLOWmiss + lowmiss;
    fprintf('Character Number %d of %d\n High Miss: %d out of %d\n Low Miss: %d out of %d\n',i,size(m2,2),totalHIGHmiss,totalHIGHbits,totalLOWmiss,totalLOWbits);
end

%fclose(p1);
delete(lh);