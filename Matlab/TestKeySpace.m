LorenzCircuitSim                                       %Opens Model
set_param('LorenzCircuitSim','StopTime','5');          %Sets Stop Time
                                                       %Runs Simulation


for i = 0:2
    for j = 0:4
        sigResistor = 30e3 + i*5e3;
        s = num2str(sigResistor,'%5.2e');
        rhoResistor = 750e3 - j*100e3;
        r = num2str(rhoResistor,'%5.2e');
        sim('LorenzCircuitSim');
        plotitle = ['Sig = ',s,' and Rho = ',r];
        figure
        plot(t,x);
        title(plotitle);
        fprintf('i = %d and j = %d',i,j);
    end
end

close_system('LorenzCircuitSim',1);