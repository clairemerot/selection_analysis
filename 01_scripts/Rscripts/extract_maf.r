#this R script extract maf in a single file for all populations & format it for various analysis
library(dplyr)


argv <- commandArgs(T)
MIN_MAF <- argv[1]
PERCENT_IND <- argv[2]
POP<-argv[3]
ANGSD_PATH<- argv[4]

#read sites files
sites<-read.table(paste0(ANGSD_PATH,"02_info/sites_all_maf",MIN_MAF,"_pctind",PERCENT_IND), header=F)
colnames(sites)<-c("chromo", "position", "major", "minor")

#read pop file
print(POP)
pop<-read.table(POP, header=F)
npop<-dim(pop)[1]
pop_group<-unlist(strsplit(unlist(strsplit(POP,"/"))[2],".txt"))

#join by chromoome and position the sites and the frequencies in each population
MAFall<-sites
for (i in 1:npop)
  {
    pi<-pop[i,1]
    MAFi<-read.delim(paste0(ANGSD_PATH,"06_saf_maf_by_pop/",pi,"/",pi,"_maf",MIN_MAF,"_pctind",PERCENT_IND,".mafs"), header=T)
    MAFi<-MAFi[,c(1,2,6,7)]
    colnames(MAFi)<-c("chromo", "position", paste("freq", pi, sep=""),paste("n", pi, sep=""))
    head(MAFi)
    MAFall<-left_join(MAFall, MAFi, by=c("chromo", "position"))
}
head(MAFall)
nSNP<-dim(MAFall)[1]
print(paste("total nb of snp for which we ran the analysis = ", dim(MAFall)[1]))
print(paste("total nb of pop for which we ran the analysis = ", (dim(MAFall)[2]-4)/2))

which (MAFall=="NA")
#select the position which are not NA
MAFall<-MAFall[which((rowSums(MAFall[,5:dim(MAFall)[2]])>=0)),]

nSNP_no_na<-dim(MAFall)[1]
print(paste("total nb of snp kept because they were covered in all populations by the chosen % of ind = ", dim(MAFall)[1]))

write.table(MAFall, paste0("02_raw_data/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,".mafs"), quote=F, sep=" ")
#write the list of SNP infered in all populations
write.table(MAFall[,1:4], paste0("02_raw_data/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,".snps"), quote=F, sep=" ")



