### config file to edit for seleciton analysis to choose on which data we want to work

#the path to the whole angsd pipeline, from inside the selection_analysis folder (from which all analysis will be run)
ANGSD_PATH=../angsd_pipeline_region_subset

#which populations work with
POP1_FILE=$ANGSD_PATH/02_info/pop2.txt

#parameter used as filter in angsd
MIN_MAF=0.05
PERCENT_IND=0.5
