# selection_analysis
### ANALYSING_MAF_SELECTION_TESTS_ETC

#### 02_extract_format_maf
To extract maf and gather all pop maf in one file

it will also output the list of snps for which maf was calculated in all populations (represented by the min % of IND given as filter. The out put is in 02_raw_data

You can also proceed straight to formatting maf for various analyses. This extracts the maf and gathers all pop maf in one file (same as above)+ format them for rda & various analysis in their respective folders. It will aslo output in the list of snps in 02_raw_data

```
ANGSD_PATH=../angsd_pipeline/
POP1_FILE=$ANGSD_PATH/02_info/pop.txt
source $ANGSD_PATH/01_scripts/01_config.sh
Rscript 01_scripts/Rscripts/extract_format_maf.r "$MIN_MAF" "$PERCENT_IND" "$POP1_FILE" "$ANGSD_PATH"
```

The next step would be to format the environment file for the different analyses. I have uploaded an example in each subfolder

