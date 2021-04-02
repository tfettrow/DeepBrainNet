%order of correlation matrix:chronological,dbn,cole
cd /blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/GABA_Data/
% correlation overall
data=readtable('Kathleen’s GABA data_age_diff.csv');
cole_diff=data.cole_diff;
DBN_diff=data.DBN_diff;
R_cole_DBN=corrcoef(cole_diff,DBN_diff)
%plot
x=cole_diff;
y=DBN_diff;
b1=x\y;
yCalc1 = b1*x;
c='#9DC8C8';
sz=50;
scatter(x,y,sz,'filled','MarkerFaceColor',c)
hold on
plot(x,yCalc1)
xlabel('Cole Brain-PAD')
ylabel('DeepBrainNet Brain-PAD')
title('Linear Regression Relation Between Two Models')
hold off
f=gcf;
exportgraphics(f,'overall_correlation.jpg','Resolution',500)
clear


