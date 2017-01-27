% n = size(t,1);
% 
% Per = 1/freq;
% 
% Half = Per/2;
% 
% center = t(1)+Half;
% 
% for i=1:size(t,1)
%    
%     if t(i) >= center
%     
%     
% end

for i=1:size(m,1)
    
    if (m(i) > .1)
        m(i) = 1;
    else
        m(i) = 0;
    end
end