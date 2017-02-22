s = daq.createSession('ni');
p1 = serial('COM4');
set(p1,'BaudRate',9600);
fopen(p1);
s.Rate = 5000;
s.DurationInSeconds = 9;
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
s.startBackground;
fprintf(p1,'%s','message:')
fprintf(p1,'%c',85)
fprintf(p1,'');
fprintf(p1,'width:100')
fprintf(p1,'mode:0')
fprintf(p1,'start')
disp('Sent');
s.wait();
%plot(time,data);
load log.mat time message sync data;
figure
subplot(2,1,1);
plot(time, message);
subplot(2,1,2);
plot(time, data(:,2), 'r');
fclose(p1);
delete(lh);
