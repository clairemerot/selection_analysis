###ANALYSING_MAF_SELECTION_TESTS_ETC

###02_extract_format_maf
#to extract maf and gather all pop maf in one file
#it will also output the list of snps for which maf was calculated in all populations (represented by the min % of IND given as filter
#out put is in 02_raw_data
source 01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/extract_maf.r "$MIN_MAF" "$PERCENT_IND" "$POP1_FILE" "$ANGSD_PATH"


