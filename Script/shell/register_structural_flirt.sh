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

subject=$1

ml fsl/6.0.1
Study_dir=/blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/MiM_Data
##### MIM DATA #####
# rm -r ${subject}/Processed/MRI_files/02_T1/${subject}

mkdir -p ${Study_dir}/${subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/

cp ${Study_dir}/${subject}/Processed/MRI_files/02_T1/SkullStripped_T1.nii ${Study_dir}/${subject}/Processed/MRI_files/02_T1/FLIRT_Normalization
cd ${Study_dir}/${subject}/Processed/MRI_files/02_T1/FLIRT_Normalization

flirt -in ${Study_dir}/${subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/SkullStripped_T1.nii -ref /apps/fsl/6.0.3/data/standard/MNI152_T1_1mm_brain.nii.gz -out ${Study_dir}/${subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/${subject}_flirtToMNI_SkullStripped_T1.nii.gz -omat ${Study_dir}/${subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/warpToMNI_flirt.mat -dof 12


##### GABA DATA #####
# mkdir -p ${subject}/FLIRT_Normalization/

# cp ${subject}/SkullStripped_T1.nii ${subject}/FLIRT_Normalization
# cd ${subject}/FLIRT_Normalization

# flirt -in SkullStripped_T1.nii -ref /apps/fsl/6.0.3/data/standard/MNI152_T1_1mm_brain.nii.gz -out ${subject}_flirtToMNI_SkullStripped_T1.nii.gz -omat warpToMNI_flirt.mat -dof 12