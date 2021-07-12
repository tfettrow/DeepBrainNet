# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.



ml fsl/6.0.1
Study_dir=/blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/MiM_Data
subject_array=(1002 1004 1007 1009 1010 1011 1012 1013 1020 1022 1024 1026 1027 2002 2007 2008 2012 2013 2015 2017 2018 2020 2021 2022 2023 2025 2026 2027 2033 2034 2037 2042 2052 3004 3008 3006 3007 3021 3023 3024 1025 1018 1019 1017 2039 3024 3029 3023 3025 3026 3027 3010 3036)
for this_subject in "${subject_array[@]}"; do	Subject_dir=/blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/MiM_Data/${this_subject}
	mkdir -p ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/
	cp ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/SkullStripped_biascorrected_T1.nii ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/FLIRT_Normalization
	cd ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/FLIRT_Normalization
	flirt -in ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/SkullStripped_biascorrected_T1.nii -ref /apps/fsl/6.0.3/data/standard/MNI152_T1_1mm_brain.nii.gz -out ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/${this_subject}_flirtToMNI_SkullStripped_T1.nii.gz -omat ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/warpToMNI_flirt.mat -dof 12
done
##### GABA DATA #####
# mkdir -p ${subject}/FLIRT_Normalization/

# cp ${subject}/SkullStripped_T1.nii ${subject}/FLIRT_Normalization
# cd ${subject}/FLIRT_Normalization

# flirt -in SkullStripped_T1.nii -ref /apps/fsl/6.0.3/data/standard/MNI152_T1_1mm_brain.nii.gz -out ${subject}_flirtToMNI_SkullStripped_T1.nii.gz -omat warpToMNI_flirt.mat -dof 12
