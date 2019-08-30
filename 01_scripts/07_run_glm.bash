#!/bin/bash
#SBATCH -J "glm"
#SBATCH -o log_%j
#SBATCH -c 1 
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=7-00:00
#SBATCH --mem=30G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

ls -1 07_glm/all_env_var | while read ENV
do
echo $ENV 

source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/Rscript_GLM.r "$MIN_MAF" "$PERCENT_IND" "$ENV"
done
