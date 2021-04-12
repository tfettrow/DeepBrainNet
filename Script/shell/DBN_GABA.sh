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

############################################
DBN_dir=/blue/rachaelseidler/tfettrow/Crunch_Code/DeepBrainNet
GABA_Study_dir=/blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/GABA_Data
# Subject_dir=/blue/rachaelseidler/share/FromExternal/Research_Projects_UF/CRUNCH/MiM_Data/${subject}
Matlab_dir=/blue/rachaelseidler/tfettrow/Crunch_Code/Matlab_Scripts
Template_dir=/blue/rachaelseidler/tfettrow/Crunch_Code/MR_Templates

# gaba_subject_array=(1001 1004 1007 1009 1010 1011 1012 1013 1020 1022 1024 1026 1027 2002 2007 2008 2012 2013 2015 2017 2018 2020 2021 2022 2023 2025 2026 2027 2033 2034 2037 2042 2052 3004 3008 3006 3007 3021 3023)
gaba_subject_array=(1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1036 1037 2001 2002 2003 2004 2005 2006 2007 2009 2010 2011 2012 2013 2014 2016 2017 2018 2020 2021 2022 2023 2025 2029 2030 2033 2035)
# gaba_subject_array=(1001)
#####################################

# ml matlab/2020a
# export MATLABPATH=${Matlab_dir}/helper
# # for this_subject in "${gaba_subject_array[@]}"; do

	# this_subject=${gaba_subject_array[$SLURM_ARRAY_TASK_ID]}


# 	Subject_dir=${GABA_Study_dir}/${this_subject}
# 	cd ${Subject_dir}

# 	# mv T1.nii T1.nii.gz
# 	# gunzip -f *nii.gz 

# 	cp ${Template_dir}/TPM.nii ${Subject_dir}
	
# 	matlab -nodesktop -nosplash -r "try; segment_t1; catch; end; quit"
# 	matlab -nodesktop -nosplash -r "try; skull_strip_t1; catch; end; quit"
# 	rm TPM.nii
# done

##### REGISTER STRUCT ###################
# this_subject=${gaba_subject_array[$SLURM_ARRAY_TASK_ID]}
# cd $GABA_Study_dir
# ${DBN_dir}/Script/register_structural_flirt.sh $this_subject
#####################################################################




cd "$GABA_Study_dir"
rm -r temp_processing_folder
rm -r temp_data_folder
mkdir -p temp_processing_folder/Test
mkdir -p temp_data_folder/

for this_subject in "${gaba_subject_array[@]}"; do
  cp ${GABA_Study_dir}/${this_subject}/FLIRT_Normalization/${this_subject}_flirtToMNI_SkullStripped_T1.nii.gz temp_data_folder
done

module load tensorflow/1.14.0

python ${DBN_dir}/Script/Slicer.py ${GABA_Study_dir}/temp_data_folder/ ${GABA_Study_dir}/temp_processing_folder/

python ${DBN_dir}/Script/Model_Test.py ${GABA_Study_dir}/temp_processing_folder/ ${GABA_Study_dir}/DBN_age_predict.csv ${DBN_dir}/Models/DBN_model.h5