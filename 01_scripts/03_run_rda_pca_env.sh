#!/bin/bash
#SBATCH -J "rda"
#SBATCH -o log_%j
#SBATCH -c 4 
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=7-00:00
#SBATCH --mem=30G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

ENV_FOLDER=03_rda/pca_env/pca_env_var

ls -1 $ENV_FOLDER | while read ENV
do
echo $ENV 
#run the Rscript rda
source 01_scripts/01_config.sh
MAF_FILE=03_rda/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND"_maxdepth"$MAX_DEPTH_FACTOR".mafs.rda
OUTPUT_FOLDER=03_rda/pca_env/
Rscript 01_scripts/Rscripts/scriptRDA.r "$MAF_FILE" "$OUTPUT_FOLDER" "$ENV" "$ENV_FOLDER"
done
