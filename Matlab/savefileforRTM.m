%Saves the file to include the RTM

fRTM = fopen(['Data\RTM',fSave],'a');
%fSig = fopen(['SIG',fSave],'a');

% r = size(t,1);
% 
% for n = 1:r
%    fprintf(fSig,'%0.5e \t %0.5e \t %0.5e \t %0.5e \n',t(n),x1(n),m(n),pdata(n));    
% end
% fclose(fSig);

if(size(a0,2)<=size(a1,2))
    r = size(a0,2);
else
    r = size(a1,2);
end

for n = 1:r
   fprintf(fRTM,'%0.5e \t %0.5e \t %0.5e \t %0.5e \n',a0(n),b0(n),a1(n),b1(n)); 
end
fclose(fRTM);

clear r;
clear n;