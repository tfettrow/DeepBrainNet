% run this from MiM_Data folder

data=readtable('DBN_MiM_Data.csv');
marker_color='#9DC8C8';
marker_size=50;

% loading data
pad=data.predicted_age_diff;
TimeToWalk400m=data.TimeToWalk400m;


for i_data_entry = 1:length(TimeToWalk400m)
    this_data_entry = TimeToWalk400m{i_data_entry};
    split_data_entry = strsplit(this_data_entry, ':');
    if ~(length(split_data_entry) == 1)
        TimeToWalk400m_mat(i_data_entry) = (str2num(split_data_entry{1}) * 60) + str2num(split_data_entry{2});
    end
end

[r,p]=corrcoef(pad,TimeToWalk400m_mat);



figure; hold on;
scatter(pad,TimeToWalk400m_mat,marker_size,'filled','MarkerFaceColor',marker_color)
xLimits = get(gca,'XLim');
coefs = polyfit(pad,TimeToWalk400m_mat,1);
fittedX=linspace(xLimits(1), xLimits(2), 100);
fittedY=polyval(coefs, fittedX);
plot(fittedX,fittedY,'-')
text(0.5,0.1,strcat('r=',num2str(round(r(1,2),2)), ' m=',num2str(round(coefs(1),3))),'Units','normalized','FontSize',12)
xlabel('DBN Brain-PAD','FontSize',16)
ylabel('TimeToWalk400m','FontSize',16)
title('DBN Brain-PAD vs TimeToWalk400m','FontSize',16)