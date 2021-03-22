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

function plot_predictedAge_diff(varargin)
% example: plot_predictedAge_diff('task_folder', '02_T1', 'subjects', {'1002','1004','1007','1009','1010','1011','1013','1020','1022','1024','1027','2021','2015','2002','2018','2017','2012','2025','2020','2026','2023','2022','2007','2013','2008','2033','2034','2037','2052','2042','3004','3006','3007','3008'},'group_names',{'YA' 'hOA' 'lOA'},'group_ids',[1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 ],'save_figures',0, 'no_labels', 0)
parser = inputParser;
parser.KeepUnmatched = true;
addParameter(parser, 'subjects', '')
addParameter(parser, 'group_names', '')
addParameter(parser, 'group_ids', '')
addParameter(parser, 'no_labels', 0)
addParameter(parser, 'save_figures', 0)
parse(parser, varargin{:})
subjects = parser.Results.subjects;
group_names = parser.Results.group_names;
group_ids = parser.Results.group_ids;
no_labels = parser.Results.no_labels;
save_figures = parser.Results.save_figures;

close all;
project_path = pwd;
group_color_matrix = distinguishable_colors(length(group_names));
dbn_data = readtable('DBN_predictedAge_diff.csv');

for this_group_index = 1 : length(group_names)
    this_group_subject_indices = find(group_ids==this_group_index);
    this_group_dbn_data = dbn_data.predicted_age_diff(this_group_subject_indices);
    
    singleBoxPlot(this_group_dbn_data,'abscissa', this_group_index, 'EdgeColor',group_color_matrix(this_group_index,:), 'MarkerColor',group_color_matrix(this_group_index,:), ...
        'WiskColor',group_color_matrix(this_group_index,:), 'MeanColor',group_color_matrix(this_group_index,:), 'EdgeLinewidth', 1, 'WiskLinewidth', 1, 'MeanLinewidth', 1 )
end
 xlim([ 0 length(group_names)+1])
 title('Deep Brain Net Age Differences')
 xlim([0 length(group_names)+1])
%  ylim([0 1])
 ylabel('Predicted - Actual Age')
 set(gca,'XTick',1:length(group_names),'xticklabel',{'YA','high-OA','low-OA'},'TickLabelInterpreter','none')
 xtickangle(45)
 set(gcf, 'ToolBar', 'none');
 set(gcf, 'MenuBar', 'none');
 if no_labels
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
    
    