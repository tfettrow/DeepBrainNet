%% run this from the GABA folder (being so specific with the path makes it hard to jump between machines.. needs to be more dynamic)
%% settings
close all;
clear,clc
data=readtable('Kathleen’s GABA data.csv');
marker_color='#9DC8C8';
marker_size=50;

%% loading data
cole_diff=data.cole_diff;
DBN_diff=data.DBN_diff;
MoCA_Sum=data.MoCA_Sum;
Avg_4min_Walk_Speed=data.Avg_4min_Walk_Speed;


%% Cole Vs. MoCA_Sum
[r,p]=corrcoef(cole_diff,MoCA_Sum);

figure; subplot(2,2,1); hold on;
scatter(cole_diff,MoCA_Sum,marker_size,'filled','MarkerFaceColor',marker_color)
xLimits = get(gca,'XLim');
coefs = polyfit(cole_diff, MoCA_Sum,1);
fittedX=linspace(xLimits(1), xLimits(2), 100);
fittedY=polyval(coefs, fittedX);
plot(fittedX,fittedY,'-')
text(0.5,0.1,strcat('r=',num2str(round(r(1,2),2)), ' m=',num2str(round(coefs(1),3))),'Units','normalized','FontSize',12)
xlabel('Cole Brain-PAD','FontSize',16)
ylabel('MoCA','FontSize',16)
title('Cole vs MoCA','FontSize',16)


%% DBN Vs. MoCA_Sum
[r,p]=corrcoef(DBN_diff,MoCA_Sum);
subplot(2,2,2); hold on
scatter(DBN_diff,MoCA_Sum,marker_size,'filled','MarkerFaceColor',marker_color)
xLimits = get(gca,'XLim');
coefs = polyfit(DBN_diff, MoCA_Sum,1);
fittedX=linspace(xLimits(1), xLimits(2), 100);
fittedY=polyval(coefs, fittedX);
plot(fittedX,fittedY,'-')
text(0.5,0.1,strcat('r=',num2str(round(r(1,2),2)), ' m=',num2str(round(coefs(1),3))),'Units','normalized','FontSize',12);
xlabel('DBN Brain-PAD','FontSize',16)
ylabel('MoCA','FontSize',16)
title('DBN vs MoCA','FontSize',16)

%% Cole Vs. Avg_walk_speed
[r,p]=corrcoef(cole_diff,Avg_4min_Walk_Speed);
subplot(2,2,3); hold on
scatter(cole_diff,Avg_4min_Walk_Speed,marker_size,'filled','MarkerFaceColor',marker_color)
xLimits = get(gca,'XLim');
coefs = polyfit(cole_diff, Avg_4min_Walk_Speed,1);
fittedX=linspace(xLimits(1), xLimits(2), 100);
fittedY=polyval(coefs, fittedX);
plot(fittedX,fittedY,'-')
text(0.5,0.1,strcat('r=',num2str(round(r(1,2),2)), ' m=',num2str(round(coefs(1),3))),'Units','normalized','FontSize',12);
xlabel('Cole Brain-PAD','FontSize',16)
ylabel('400m speed','FontSize',16)
title('Cole vs. 400','FontSize',16)

%% DBN Vs. Avg_walk_speed
[r,p]=corrcoef(DBN_diff,Avg_4min_Walk_Speed);
subplot(2,2,4); hold on
scatter(DBN_diff,Avg_4min_Walk_Speed,marker_size,'filled','MarkerFaceColor',marker_color)
xLimits = get(gca,'XLim');
coefs = polyfit(DBN_diff, Avg_4min_Walk_Speed,1);
fittedX=linspace(xLimits(1), xLimits(2), 100);
fittedY=polyval(coefs, fittedX);
plot(fittedX,fittedY,'-')
text(0.5,0.1,strcat('r=',num2str(round(r(1,2),2)), ' m=',num2str(round(coefs(1),3))),'Units','normalized','FontSize',12);
xlabel('DBN Brain-PAD','FontSize',16)
ylabel('400m speed','FontSize',16)
title('DBN vs. 400','FontSize',16)





