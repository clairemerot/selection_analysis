#!/bin/bash
#SBATCH -J "lfmm_K3_allENV"
#SBATCH -o log_%j
#SBATCH -c 1 
#SBATCH -p large
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=21-00:00
#SBATCH --mem=3G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR
source 01_scripts/01_config.sh

ls -1 04_lfmm/lfmm_env | while read ENV
do
echo $ENV 
#lfmm run in a folder with the environmental variables that you want to test
#make a folder in 04_lfmm with the name given below. put inside the env.rda file with environmental variables
#run the Rscript lea
mkdir 04_lfmm/$ENV
cp -l 04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm 04_lfmm/$ENV/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm
cp -l 04_lfmm/lfmm_env/$ENV 04_lfmm/$ENV/env_lfmm.env
cd 04_lfmm/$ENV
Rscript ../../01_scripts/Rscripts/Rscript_LEA_K3.r "$MIN_MAF" "$PERCENT_IND" "$ENV" 
cd ../..
done
