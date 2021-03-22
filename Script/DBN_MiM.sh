#! /bin/bash
#SBATCH --job-name=DBN_MiM             # Job name
#SBATCH --mail-type=END,FAIL                # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=<tfettrow@ufl.edu>      # Where to send mail  
#SBATCH --ntasks=1                          # Run a single task
#SBATCH --mem=24000mb                          # Memory limit
#SBATCH --qos=rachaelseidler
#SBATCH --time=96:00:00                     # Time limit hrs:min:sec
#SBATCH --output=DBN_MiM.%A_%a.out   # Standard output and error log
#SBATCH --array=0                # array range
pwd; hostname; date

### THINGS THAT MAY NEED UPDATED ####
DBN_dir=/blue/rachaelseidler/tfettrow/Crunch_Code/DeepBrainNet
Study_dir=/blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/MiM_Data
subject_array=(1002 1004 1007 1009 1010 1011 1012 1013 1020 1022 1024 1026 1027 2002 2007 2008 2012 2013 2015 2017 2018 2020 2021 2022 2023 2025 2026 2033 2034 2037 2042 2052 3004 3008 3006 3007 3021 3023)
#####################################

cd "$Study_dir"
rm -r temp_processing_folder
rm -r temp_data_folder
mkdir -p temp_processing_folder/Test
mkdir -p temp_data_folder/

for this_subject in "${subject_array[@]}"; do
  cp ${Study_dir}/${this_subject}/Processed/MRI_files/02_T1/FLIRT_Normalization/${this_subject}_flirtToMNI_SkullStripped_T1.nii.gz temp_data_folder
done

module load tensorflow/1.14.0

python ${DBN_dir}/Script/Slicer.py ${Study_dir}/temp_data_folder/ ${Study_dir}/temp_processing_folder/

python ${DBN_dir}/Script/Model_Test.py ${Study_dir}/temp_processing_folder/ ${Study_dir}/DBN_age_predict.csv ${DBN_dir}/Models/DBN_model.h5
