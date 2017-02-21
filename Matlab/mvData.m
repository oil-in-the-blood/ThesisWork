
function mvData(src,event)
    time = event.TimeStamps;
    data = event.Data;
    sync = (data(:,2)-0.5).*(data(:,2)-0.5);
    message = data(:,1);
    plot(time,message,time,sync);
    save log.mat time message sync;
end