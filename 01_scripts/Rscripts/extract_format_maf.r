#this R script extract maf in a single file for all populations
library(dplyr)


argv <- commandArgs(T)
MIN_MAF <- argv[1]
PERCENT_IND <- argv[2]
POP<-argv[3]
ANGSD_PATH<- argv[4]
MAX_DEPTH_FACTOR<-argv[5]

#read sites files
sites<-read.table(paste0(ANGSD_PATH,"/02_info/sites_all_maf",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR), header=F)
colnames(sites)<-c("chromo", "position", "major", "minor")

#read pop file
print(POP)
pop<-read.table(POP, header=F)
npop<-dim(pop)[1]
pop_group<-"pop" #unlist(strsplit(unlist(strsplit(POP,"/"))[2],".txt"))


#join by chromoome and position the sites and the frequencies in each population
print("join by chromoome and position the sites and the frequencies in each population")
MAFall<-sites
for (i in 1:npop)
  {
    pi<-pop[i,1]
    MAFi<-read.delim(paste0(ANGSD_PATH,"/06_saf_maf_by_pop/",pi,"/",pi,"_maf",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".mafs"), header=T)
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

write.table(MAFall, paste0("02_raw_data/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".mafs"), quote=F, sep=" ")
#write the list of SNP infered in all populations
write.table(MAFall[,1:4], paste0("02_raw_data/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".snps"), quote=F, sep=" ")



#format for RDA & lfmm & FLK
#row are snp
#col are pop
print("format for rda/lfmm/flk")
freq_col<-seq(5,(3+npop*2), by=2)
maf_matrix<-(MAFall[,freq_col])
colnames(maf_matrix)<-pop[,1]
rownames(maf_matrix)<-paste(MAFall$chromo, MAFall$position, sep="_")
head(maf_matrix)

#for lfmm
#write.table(t(maf_matrix), paste0("04_lfmm/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".lfmm"), quote=F, row.names = F, col.names = F)

#for FLK add colnames
write.table(maf_matrix, paste0("05_flk/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".mafs.flkT"), quote=F, row.names = F)
#we would need also a matrix of reynolds distances? see ld-pruned methods, removing outliers,e tc

#for rda add rownames - works for lfmm2 now!
write.table(maf_matrix, paste0("03_rda/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".mafs.rda"), quote=F)
write.table(maf_matrix, paste0("04_lfmm/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".mafs.rda"), quote=F)


#for Baypass
#row are snp
#col are pop (2 col per pop separated by a space, with nAllele M, nAllele m)
print("format for baypass")
BayPass_matrix<-matrix(ncol=(npop*2), nrow=nSNP_no_na)
for (i in 1:npop)
	{
	BayPass_matrix[,(2*i-1)]<- round(MAFall[,4+(2*i-1)]*2*MAFall[,5+(2*i-1)],0)
	BayPass_matrix[,(2*i)]<- round((1-MAFall[,4+(2*i-1)])*2*MAFall[,5+(2*i-1)],0)
	}
head(BayPass_matrix)
write.table(BayPass_matrix, paste0("06_baypass/by_",pop_group,"_",MIN_MAF,"_pctind",PERCENT_IND,"_maxdepth",MAX_DEPTH_FACTOR,".mafs.baypass"), quote=F, row.names = F, col.names = F)

##I have somewhere a script to prepare the maf matrix for bayescan but bayescan is just too long to run on so many snps.













