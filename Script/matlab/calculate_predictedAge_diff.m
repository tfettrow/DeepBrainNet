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

function calculate_predictedAge_diff(subject_cell)
% example: calculate_predictedAge_diff({'1002','1004'})
%(1) The purpose of this script is to collect the age information scttered on
%different folders and calculate the gap between predicted age and chronological age.

%(2) The user can set the subNum(the number of subjects) and the sub_vector
%(subject ID), and the number should match.

%(3) The order of sub ID must matchs the data in 'DBN_age_predict.csv' 
% TF: better to make this a bit more dynamic in case you want to look at a
% sub-group of people

dbn_data=readtable('DBN_age_predict.csv');
for this_subject_index = 1:length(subject_cell)
    this_subject_id = subject_cell{this_subject_index};
    this_subject_data = readtable(strcat(this_subject_id,filesep,'subject_info.csv'));
    actual_age(this_subject_index) = this_subject_data{1,2};
    
    % find the row for this subject in dbn_orig_data
    this_subject_dbn_data_index = find(contains(dbn_data.ID,this_subject_id));
    predicted_age(this_subject_index) = round(dbn_data.Pred_Age(this_subject_dbn_data_index),1);
end

predictedAge_diff = (predicted_age - actual_age);
predictedAge_diff_table = table(subject_cell', actual_age', predicted_age', predictedAge_diff');
predictedAge_diff_table.Properties.VariableNames = {'subject_ids', 'actual_age', 'predicted_age', 'predicted_age_diff'};
 
writetable(predictedAge_diff_table,'DBN_predictedAge_diff.csv')

end
    
    