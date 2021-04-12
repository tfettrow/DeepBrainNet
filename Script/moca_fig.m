% data path:/blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/MiM_Data/
data=readtable('DBN_MiM_Data.csv');
marker_color='#9DC8C8';
marker_size=50;

% loading data
pad=data.predicted_age_diff;
moca=data.MoCA;

[r,p]=corrcoef(pad,moca);

hold on;
scatter(pad,moca,marker_size,'filled','MarkerFaceColor',marker_color)
xLimits = get(gca,'XLim');
coefs = polyfit(pad,moca,1);
fittedX=linspace(xLimits(1), xLimits(2), 100);
fittedY=polyval(coefs, fittedX);
plot(fittedX,fittedY,'-')
text(0.5,0.1,strcat('r=',num2str(round(r,2)), ' m=',num2str(round(coefs(1),3))),'Units','normalized')
xlabel('DBN Brain-PAD','FontSize',16)
ylabel('MoCA','FontSize',16)
title('DBN Brain-PAD vs MoCA','FontSize',16)