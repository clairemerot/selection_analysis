###ANALYSING_MAF_SELECTION_TESTS_ETC

###02_extract_format_maf
#to extract maf and gather all pop maf in one file
#it will also output the list of snps for which maf was calculated in all populations (represented by the min % of IND given as filter
#out put is in 02_raw_data


ANGSD_PATH=../angsd_pipeline/
POP1_FILE=$ANGSD_PATH/02_info/pop.txt
source $ANGSD_PATH/01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/extract_maf.r "$MIN_MAF" "$PERCENT_IND" "$POP1_FILE" "$ANGSD_PATH"

#or to proceed straight to formatting maf for various analyses
#to extract maf and gather all pop maf in one file (same as above)+ format them for rda & various analysis
#it will aslo output in the list of snps for which maf was calculated in all populations (represented by the min % of IND given as filter

ANGSD_PATH=../angsd_pipeline/
POP1_FILE=$ANGSD_PATH/02_info/pop.txt
source $ANGSD_PATH/01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/extract_format_maf.r "$MIN_MAF" "$PERCENT_IND" "$POP1_FILE" "$ANGSD_PATH"

#next steps
#add environment file in 10_maf_analysis/02_raw_data env.txt
#format the env file for the different analyses

#add scripts for rda, lfmm (lea), baypass, flk in 10_maf_analysis/01_scripts
#maybe outflank but works on gneotype...
