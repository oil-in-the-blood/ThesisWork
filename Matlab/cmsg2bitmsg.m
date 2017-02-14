%% Creates a bit message from an array of ASCII characters (in decimal representation)

function [message] = cmsg2bitmsg(nsig,freq,res,pad);

TOTchar = size(nsig,1); %Total Number of Characters
L = TOTchar*res*8; %Total Length of bit message array

msgTIME = (1/(freq*res))*[0:L]'; %Message time array

bitARRAY = [];

bitMSG = zeros(1,L);
for i = 1:TOTchar
	bitARRAY = [bitARRAY, de2bi(nsig(i),8,'left-msb')];
end
for i = 1:L
	dex = fix((i-1)/res)+1;
	padTEST = i-(dex-1)*res;
	if padTEST < res - res*pad
		bitMSG(i) = bitARRAY(dex);	
	else
		bitMSG(i) = 0;
	end
end
bitMSG = [bitMSG bitMSG(size(bitMSG,2))];
message = [msgTIME bitMSG'];