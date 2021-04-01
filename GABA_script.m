%order of correlation matrix:chronological,dbn,cole
cd /blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/GABA_Data/
data=readtable('Kathleen’s GABA data OA.csv');
chronological_age=data.chronological_age;
cole_brainage=data.cole_brainage;
DBN_brainage=data.DBN_brainage;
R_cole_chronological=corrcoef(chronological_age,cole_brainage);
R_DBN_chronological=corrcoef(DBN_brainage,chronological_age);
R_DBN_cole=corrcoef(DBN_brainage,cole_brainage);
OA_correlation_matrix=ones(3,3);
OA_correlation_matrix(1,2)=R_DBN_chronological(1,2);
OA_correlation_matrix(1,3)=R_cole_chronological(1,2);
OA_correlation_matrix(2,3)=R_DBN_cole(1,2);
%plot
x=cole_brainage;
y=DBN_brainage;
b1=x\y;
yCalc1 = b1*x;
scatter(x,y)
hold on
plot(x,yCalc1)
xlabel('Cole predited brain age')
ylabel('DeepBrainNet predited brain age')
title('Linear Regression Relation Between Two Models')
hold off
f=gcf;
exportgraphics(f,'OA.pdf')
save('OA_matrix.mat','OA_correlation_matrix')
clear

data=readtable('Kathleen’s GABA data YA.csv');
chronological_age=data.chronological_age;
cole_brainage=data.cole_brainage;
DBN_brainage=data.DBN_brainage;
R_cole_chronological=corrcoef(chronological_age,cole_brainage);
R_DBN_chronological=corrcoef(DBN_brainage,chronological_age);
R_DBN_cole=corrcoef(DBN_brainage,cole_brainage);
YA_correlation_matrix=ones(3,3);
YA_correlation_matrix(1,2)=R_DBN_chronological(1,2);
YA_correlation_matrix(1,3)=R_cole_chronological(1,2);
YA_correlation_matrix(2,3)=R_DBN_cole(1,2);
%plot
x=cole_brainage;
y=DBN_brainage;
b1=x\y;
yCalc1 = b1*x;
scatter(x,y)
hold on
plot(x,yCalc1)
xlabel('Cole predited brain age')
ylabel('DeepBrainNet predited brain age')
title('Linear Regression Relation Between Two Models')
hold off
f=gcf;
exportgraphics(f,'YA.pdf')
save('YA_matrix.mat','YA_correlation_matrix')
clear