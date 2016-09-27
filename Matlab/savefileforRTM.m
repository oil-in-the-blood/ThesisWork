%Saves the file to include the RTM

fRTM = fopen(['RTM',fSave],'a');
%fSig = fopen(['SIG',fSave],'a');

% r = size(t,1);
% 
% for n = 1:r
%    fprintf(fSig,'%0.5e \t %0.5e \t %0.5e \t %0.5e \n',t(n),x1(n),m(n),pdata(n));    
% end
% fclose(fSig);

r = size(a,2);

for n = 1:r
   fprintf(fRTM,'%0.5e \t %0.5e \t %0.5e \t %0.5e \n',a0(n),b0(n),a1(n),b1(n)); 
end
fclose(fRTM);

clear r;
clear n;