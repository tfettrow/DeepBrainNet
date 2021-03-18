#! /bin/bash




DATA_PATH=''
OUT_PATH=''
MODEL=''
print_usage() {
  printf "\n\nUsage:\n\n"
  printf "\tRequired Parameters:\n\n" 
  printf "\t %s\n\n "  "[-d]: Path containing aligned nifti images" "[-o]: Output directory for prediciton csv" "[-m]: Specify Model files to use (.h5)"
  printf "\nExample: ./test.sh -d /myPath/ -o ./outputPath/ -m ../myModel.h5\n\n"
  exit 1
}

while getopts 'uhd:o:m:' flag; do
  case "${flag}" in
    u) print_usage ;;
    h) print_usage ;;
    d) DATA_PATH="${OPTARG}" ;;
    o) OUT_PATH="${OPTARG}" ;;
    m) MODEL="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

rm -r ../tmp/
mkdir ../tmp/
mkdir ../tmp/Test/

module load tensorflow/1.14.0
#%module load gcc/5.2.0 openmpi keras
python Slicer.py $DATA_PATH ../tmp/

# module load python/3.7
# module load tensorflow/1.14.0
# pip install sklearn
# pip install nibabel --user
# #%module load gcc/5.2.0 openmpi keras
# python Slicer.py $DATA_PATH ../tmp/

python Model_Test.py ../tmp/ ${OUT_PATH}pred.csv $MODEL
