S1 = load('CSK_Std_RUN_092616');
S2 = load('CSK_TS_RUN_092716');
S3 = load('CSK_TS_PM_RUN_092716');

figure
subplot(2,2,1)
scatter(S1.a0,S1.b0);
hold on;
scatter(S1.a1,S1.b1,'r');
title('Standard CSK');

subplot(2,2,2)
scatter(S2.a0,S2.b0);
hold on;
scatter(S2.a1,S2.b1,'r');
title('CSK-TS Modulus');

subplot(2,2,3)
scatter(S3.a0,S3.b0);
hold on;
scatter(S3.a1,S3.b1,'r');
title('CSK-TS Positive Negative');