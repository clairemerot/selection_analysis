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

#RDA run in a folder with the environmental variables that you want to test
#make a folder in 03_rda with the name given below. put inside the env.rda file with environmental variables

ENV="4var_clim_FL_tide_depth"

#run the Rscript rda
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/scriptRDA_katak.R "$MIN_MAF" "$PERCENT_IND" "$ENV" "$MAX_DEPTH_FACTOR"


ENV="7var"

#run the Rscript rda
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/scriptRDA_katak.R "$MIN_MAF" "$PERCENT_IND" "$ENV" "$MAX_DEPTH_FACTOR"

ENV="bed_var"

#run the Rscript rda
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/scriptRDA_katak.R "$MIN_MAF" "$PERCENT_IND" "$ENV" "$MAX_DEPTH_FACTOR"

ENV="clim_LF_bed"

#run the Rscript rda
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/scriptRDA_katak.R "$MIN_MAF" "$PERCENT_IND" "$ENV" "$MAX_DEPTH_FACTOR"

ENV="clim_only"

#run the Rscript rda
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/scriptRDA_katak.R "$MIN_MAF" "$PERCENT_IND" "$ENV" "$MAX_DEPTH_FACTOR"

ENV="LaminFucus"

#run the Rscript rda
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/scriptRDA_katak.R "$MIN_MAF" "$PERCENT_IND" "$ENV" "$MAX_DEPTH_FACTOR"
