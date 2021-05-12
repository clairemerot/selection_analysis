#!/bin/bash
#SBATCH -J "lfmm2"
#SBATCH -o log_%j
#SBATCH -c 1 
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=7-00:00
#SBATCH --mem=30G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

ENV_FOLDER=04_lfmm/all_env/all_env_var


ls -1 $ENV_FOLDER | while read ENV
do
echo $ENV 
#run the Rscript lfmm
source 01_scripts/01_config.sh
MAF_FILE=04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND"_maxdepth"$MAX_DEPTH_FACTOR".lfmm
OUTPUT_FOLDER=04_lfmm/all_env/

Rscript 01_scripts/Rscripts/run_lfmm_2_new.r "$MAF_FILE" "$OUTPUT_FOLDER" "$ENV" "$ENV_FOLDER"
done
