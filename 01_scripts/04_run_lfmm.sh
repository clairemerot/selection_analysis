#!/bin/bash
#SBATCH -J "lfmm"
#SBATCH -o log_%j
#SBATCH -c 2 
#SBATCH -p large
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=21-00:00
#SBATCH --mem=3G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

#RDA run in a folder with the environmental variables that you want to test
#make a folder in 03_rda with the name given below. put inside the env.rda file with environmental variables

ENV="4var_clim_FL_tide_depth"

#run the Rscript lea
source 01_scripts/01_config.sh
cp -l 04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm 04_lfmm/$ENV/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm
cd 04_lfmm/$ENV
Rscript ../../01_scripts/Rscripts/Rscript_LEA.r "$MIN_MAF" "$PERCENT_IND" "$ENV"
cd ../..

ENV="7var"

#run the Rscript lea
source 01_scripts/01_config.sh
cp -l 04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm 04_lfmm/$ENV/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm
cd 04_lfmm/$ENV
Rscript ../../01_scripts/Rscripts/Rscript_LEA.r "$MIN_MAF" "$PERCENT_IND" "$ENV"
cd ../..

ENV="bed_var"

#run the Rscript lea
source 01_scripts/01_config.sh
cp -l 04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm 04_lfmm/$ENV/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm
cd 04_lfmm/$ENV
Rscript ../../01_scripts/Rscripts/Rscript_LEA.r "$MIN_MAF" "$PERCENT_IND" "$ENV"
cd ../..

ENV="clim_LF_bed"

#run the Rscript lea
source 01_scripts/01_config.sh
cp -l 04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm 04_lfmm/$ENV/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm
cd 04_lfmm/$ENV
Rscript ../../01_scripts/Rscripts/Rscript_LEA.r "$MIN_MAF" "$PERCENT_IND" "$ENV"
cd ../..

ENV="clim_only"

#run the Rscript lea
source 01_scripts/01_config.sh
cp -l 04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm 04_lfmm/$ENV/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm
cd 04_lfmm/$ENV
Rscript ../../01_scripts/Rscripts/Rscript_LEA.r "$MIN_MAF" "$PERCENT_IND" "$ENV"
cd ../..

ENV="LaminFucus"

#run the Rscript lea
source 01_scripts/01_config.sh
cp -l 04_lfmm/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm 04_lfmm/$ENV/by_pop_"$MIN_MAF"_pctind"$PERCENT_IND".lfmm
cd 04_lfmm/$ENV
Rscript ../../01_scripts/Rscripts/Rscript_LEA.r "$MIN_MAF" "$PERCENT_IND" "$ENV"
cd ../..
