###ANALYSING_MAF_SELECTION_TESTS_ETC

###02_extract_format_maf
#or to extract maf & proceed straight to formatting maf for various analyses
#to extract maf and gather all pop maf in one file (same as above)+ format them for rda & various analysis
#it will aslo output in the list of snps for which maf was calculated in all populations (represented by the min % of IND given as filter
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/extract_format_maf_pruned.r "$MIN_MAF" "$PERCENT_IND" "$POP1_FILE" "$ANGSD_PATH" "$MAX_DEPTH_FACTOR"

