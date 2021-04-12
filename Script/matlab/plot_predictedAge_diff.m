%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.


%% use this within MiM_Data folder: plot_predictedAge_diff('subjects', {'1002','1004','1007','1009','1010','1011','1013','1020','1022','1024','1026','1027','2021','2015','2002','2018','2017','2012','2025','2020','2026','2023','2022','2007','2013','2008','2033','2034','2037','2052','2042','3004','3006','3007','3008','3021','3023'},'group_names',{'YA' 'high-OA' 'low-OA'},'group_ids',[1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3],'model_name', 'DBN')
%% use this within GABA_Data folder for DBN results: plot_predictedAge_diff('subjects', {'1001','1003','1004','1005','1006','1007','1009','1010','1011','1013','1014','1015','1016','1017','1018','1019','1021','1023','1025','1026','1027','1028','1029','1030','1031','1033','1035','1036','1037','2001','2002','2004','2006','2007','2009','2011','2012','2014','2016','2018','2020','2021','2022','2023','2025','2029','2030','2035'},'group_names',{'YA' 'OA'},'group_ids',[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2], 'model_name','DBN')
%% use this within GABA_Data folder for Cole results: plot_predictedAge_diff('subjects', {'1001','1003','1004','1005','1006','1007','1009','1010','1011','1013','1014','1015','1016','1017','1018','1019','1021','1023','1025','1026','1027','1028','1029','1030','1031','1033','1035','1036','1037','2001','2002','2004','2006','2007','2009','2011','2012','2014','2016','2018','2020','2021','2022','2023','2025','2029','2030','2035'},'group_names',{'YA' 'OA'},'group_ids',[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2], 'model_name','Cole')

function plot_predictedAge_diff(varargin)
% example: plot_predictedAge_diff('task_folder', '02_T1', 'subjects', {'1002','1004','1007','1009','1010','1011','1013','1020','1022','1024','1027','2021','2015','2002','2018','2017','2012','2025','2020','2026','2023','2022','2007','2013','2008','2033','2034','2037','2052','2042','3004','3006','3007','3008'},'group_names',{'YA' 'hOA' 'lOA'},'group_ids',[1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 ],'save_figures',0, 'no_labels', 0)
parser = inputParser;
parser.KeepUnmatched = true;
addParameter(parser, 'subjects', '')
addParameter(parser, 'group_names', '')
addParameter(parser, 'group_ids', '')
addParameter(parser, 'no_labels', 0)
addParameter(parser, 'model_name', 'DBN')
addParameter(parser, 'save_figures', 0)
parse(parser, varargin{:})
subjects = parser.Results.subjects;
group_names = parser.Results.group_names;
group_ids = parser.Results.group_ids;
no_labels = parser.Results.no_labels;
model_name = parser.Results.model_name;
save_figures = parser.Results.save_figures;

close all;
project_path = pwd;
project_path_split = strsplit(project_path,filesep);
project_folder = project_path_split{end};
group_color_matrix = distinguishable_colors(length(group_names));

if strcmp(project_folder,'GABA_Data')
if strcmp(model_name, 'DBN')
    loaded_data = readtable('Kathleen’s GABA data.csv');
    age_diff_data = loaded_data.DBN_diff;
    actual_age_data = loaded_data.chronological_age;
    predicted_age_data = loaded_data.DBN_brainage;
elseif strcmp(model_name,'Cole')
    loaded_data = readtable('Kathleen’s GABA data.csv');
    age_diff_data = loaded_data.cole_diff;
    actual_age_data = loaded_data.chronological_age;
    predicted_age_data = loaded_data.cole_brainage;
end
elseif strcmp(project_folder,'MiM_Data')
    loaded_data = readtable('DBN_predictedAge_diff.csv');
    age_diff_data = loaded_data.predicted_age_diff;
    actual_age_data = loaded_data.actual_age;
    predicted_age_data = loaded_data.predicted_age;
end

figure; hold on;
plot(actual_age_data,predicted_age_data,'o','MarkerFaceColor','c','MarkerSize',7.5)
linear_plot = plot(linspace(0,100,100), 'color', [0.7 0.7 0.7]);
uistack(linear_plot, 'bottom')
xlabel('Actual Age','FontSize', 16)
ylabel(strcat(model_name,' Predicted Age'),'FontSize', 16)
title(strcat('Actual Age vs.',{' '}, model_name, ' Predicted Age'),'FontSize', 16)



figure; hold on;
for this_group_index = 1 : length(group_names)
    this_group_subject_indices = find(group_ids==this_group_index);
    this_group_dbn_data = age_diff_data(this_group_subject_indices);
    
    singleBoxPlot(this_group_dbn_data,'abscissa', this_group_index, 'EdgeColor',group_color_matrix(this_group_index,:), 'MarkerColor',group_color_matrix(this_group_index,:), ...
        'WiskColor',group_color_matrix(this_group_index,:), 'MeanColor',group_color_matrix(this_group_index,:), 'EdgeLinewidth', 1, 'WiskLinewidth', 1, 'MeanLinewidth', 1 )
end
 xlim([ 0 length(group_names)+1])
 title(strcat(model_name, ' Predicted Age Differences'),'FontSize',16)
 xlim([0 length(group_names)+1])
%  ylim([0 1])
 ylabel(strcat(model_name, ' Brain-PAD'),'FontSize',16)
 set(gca,'XTick',1:length(group_names),'xticklabel',group_names,'TickLabelInterpreter','none','FontSize',16)
 xtickangle(45)
 if no_labels
     set(gcf, 'ToolBar', 'none');
     set(gcf, 'MenuBar', 'none');
     set(get(gca, 'xlabel'), 'visible', 'off');
     set(get(gca, 'ylabel'), 'visible', 'off');
     set(get(gca, 'title'), 'visible', 'off');
     legend(gca, 'hide');
 end
 if save_figures
     fig_title = 'dbn_age_diff';
     filename =  fullfile(project_path, 'figures', fig_title);
     saveas(gca, filename, 'tiff')
 end
end
    
    