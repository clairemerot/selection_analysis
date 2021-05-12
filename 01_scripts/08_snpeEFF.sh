#!/bin/bash
#SBATCH -J "snpeEff"
#SBATCH -o log_%j
#SBATCH -c 1 
#SBATCH -p small
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=1-00:00
#SBATCH --mem=10G

# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

#A script to run snpEff on the vcf produced by plink
module load java/jdk/1.8.0_102

#make sure to build the database before
#move the vcf into the folder
java -Xmx4g -jar 08_snpEff/snpEff/snpEff.jar genome_coelopa ../angsd_pipeline/11_plink/all_plink_maf0.05_pctind0.5_maxdepth3.vcf.vcf > 08_snpEff/all_plink_maf0.05_pctind0.5_maxdepth3.annotated.vcf
cat 08_snpEff/all_plink_maf0.05_pctind0.5_maxdepth3.annotated.vcf | awk -F"|" '$1=$1' OFS="\t" | cut -f 1-9 > 08_snpEff/SNP_maf0.05_pctind0.5_maxdepth3_annotated_formatted.txt
#look at the first 25 lines
head -n 250 08_snpEff/SNP_maf0.05_pctind0.5_maxdepth3_annotated_formatted.txt
#look at the last lines
tail 08_snpEff/SNP_maf0.05_pctind0.5_maxdepth3_annotated_formatted.txt

