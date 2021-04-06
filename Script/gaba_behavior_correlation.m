cd /blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/GABA_Data/
data=readtable('Kathleen’s GABA data.csv');
cole_diff=data.cole_diff;
DBN_diff=data.DBN_diff;
MoCA_Sum=data.MoCA_Sum;
Avg_4min_Walk_Speed=data.Avg_4min_Walk_Speed;
R_MoCA_cole=corrcoef(cole_diff,MoCA_Sum);
R_Moca_DBN=corrcoef(DBN_diff,MoCA_Sum);
R_400_cole=corrcoef(cole_diff,Avg_4min_Walk_Speed);
R_400_DBN=corrcoef(DBN_diff,Avg_4min_Walk_Speed);
%plot
subplot(2,2,1)
x1=cole_diff;
y1=Avg_4min_Walk_Speed;
b1=x1\y1;
yCalc1 = b1*x1;
c='#9DC8C8';
sz=50;
scatter(x1,y1,sz,'filled','MarkerFaceColor',c)
hold on
plot(x1,yCalc1)
xlabel('Cole Brain-PAD')
ylabel('400m speed')
title('cole-400')

subplot(2,2,2)
x=cole_diff;
y=MoCA_Sum;
b2=x\y;
yCalc2 = b2*x;
c='#9DC8C8';
sz=50;
scatter(x,y,sz,'filled','MarkerFaceColor',c)
hold on
plot(x,yCalc2)
xlabel('Cole Brain-PAD')
ylabel('MoCA')
title('cole_moca')

subplot(2,2,3)
x=DBN_diff;
y=Avg_4min_Walk_Speed;
b3=x\y;
yCalc3 = b3*x;
c='#9DC8C8';
sz=50;
scatter(x,y,sz,'filled','MarkerFaceColor',c)
hold on
plot(x,yCalc3)
xlabel('DBN-PAD')
ylabel('400m speed')
title('dbn 400')

subplot(2,2,4)
x=DBN_diff;
y=MoCA_Sum;
b4=x\y;
yCalc4 = b4*x;
c='#9DC8C8';
sz=50;
scatter(x,y,sz,'filled','MarkerFaceColor',c)
hold on
plot(x,yCalc4)
xlabel('DBN-PAD')
ylabel('Moca')
title('moca_dbn')





