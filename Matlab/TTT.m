aa1 = [];
bb1 = [];
aa0 = [];
bb0 = [];

for i = 1:size(A1,2)
   if A1(i) < -1
       aa1 = [aa1 A1(i)];
       bb1 = [bb1 B1(i)];
   end
end

for i = 1:size(A0,2)
    if A0(i) < -1
        aa0 = [aa0 A0(i)];
        bb0 = [bb0 B0(i)];
    end
end