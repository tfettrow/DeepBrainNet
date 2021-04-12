	

cp ${Template_dir}/TPM.nii ${Subject_dir}
cd ${Subject_dir}
gunzip -f *nii.gz 
matlab -nodesktop -nosplash -r "try; segment_t1; catch; end; quit"
matlab -nodesktop -nosplash -r "try; skull_strip_t1; catch; end; quit"
rm TPM.nii