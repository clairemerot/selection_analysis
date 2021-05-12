#!/bin/bash
#SBATCH -J "bedtools"
#SBATCH -o log_%j
#SBATCH -c 1 
#SBATCH -p small
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=1-00:00
#SBATCH --mem=10G

# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

#A script to run bedtools on outliers list vs genome annotation
module load bedtools

transcript_db="09_go/genome_annotation_emma_corrected.bed"
go_db="09_go/annotation_emma.txt"


bedtools intersect -a 09_go/all_snps.bed -b $transcript_db -wb > 09_go/all_snps.intersect


cat 09_go/all_snps.intersect | cut -f 8 | sort -u > 09_go/all_snps.transcript
head 09_go/all_snps.transcript
cat 09_go/all_snps.transcript | wc -l
#head 09_go/"$i".intersect

ls -1 09_go/outlier_bed |
while read i
do
echo $i
#extract the intersection between snps and transcripts
bedtools intersect -a 09_go/outlier_bed/"$i" -b $transcript_db  -wb > 09_go/outlier_transcript/"$i".intersect


#reformat into transcript list
cat 09_go/outlier_transcript/"$i".intersect | cut -f 8 | sort -u > 09_go/outlier_transcript/"$i".transcript
head 09_go/outlier_transcript/"$i".transcript
cat 09_go/outlier_transcript/"$i".transcript | wc -l
#head 09_go/outlier_transcript/"$i".intersect

#run goatools
python 09_go/goatools/scripts/find_enrichment.py --obo 09_go/go-basic.obo --indent 09_go/outlier_transcript/"$i".transcript 09_go/all_snps.transcript $go_db > 09_go/outlier_go/"$i".go

#filter output of goatools for fdr0.05 and different GO levels
#script form Eric Normandeau
	for k in 2 3 4 5    
	do
	python2 01_scripts/utilities/filter_goatools.py 09_go/outlier_go/"$i".go 09_go/go-basic.obo 09_go/outlier_go/"$i".filtered_fdr10_level$k.go 0.10 $k
	done

done



