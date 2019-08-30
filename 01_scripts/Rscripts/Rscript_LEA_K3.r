library(LEA)
library(dplyr)

argv <- commandArgs(T)
MIN_MAF <- argv[1]
PERCENT_IND <- argv[2]
ENV<-argv[3]



project = NULL
project = lfmm(paste0("by_pop_",MIN_MAF,"_pctind",PERCENT_IND,".lfmm"),
               "env_lfmm.env",
               K = 3 ,
               repetitions = 5,
               CPU=4,
                project = "new")
#K=nb of latent factors should match pop structure

## The project is saved into :s

##  6pop_maf_lfmm_10000_6pop_env_lfmm.lfmmProject 
## 
## To load the project, use:
project = load.lfmmProject(paste0("by_pop_",MIN_MAF,"_pctind0.lfmmProject"))


# compute adjusted p-values
p = lfmm.pvalues(project, K = 3, d=1)
pvalues = p$pvalues



alpha<-0.05
  # expected FDR
  print(paste("Expected FDR:", alpha))
  L = length(pvalues)
  # return a list of candidates with expected FDR alpha.
  # Benjamini-Hochberg's algorithm:
  w = which(sort(pvalues) < alpha * (1:L) / L)
  candidates = order(pvalues)[w]

  head(candidates) 
  length(candidates)
  
  # GWAS significance test
jpeg(paste0("lfmm_pval",ENV,"K",3,".jpg"))
par(mfrow = c(2,1))
hist(pvalues, col = "lightblue")
plot(-log10(pvalues), pch = 19, col = "blue", cex = .7, main=paste("pval", ENV, "Benjamini-Hochberg limit 0.05 =", -log(sort(pvalues)[length(w)])))
abline (h=-log(sort(pvalues)[length(w)]))
dev.off()

snp<-read.table("../../02_raw_data/by_pop_0.05_pctind0.5.snps", header=T)
snp$id<-seq(1:dim(snp)[1])
snp_p_val<-cbind(snp, pvalues)

write.table(snp_p_val, paste0("pvalues_snp",ENV,"K",3,".txt"))

snp_candidate<-as.matrix(candidates)
colnames(snp_candidate)<-c("id")
snp_candidate_info<-left_join(as.data.frame(snp_candidate), snp_p_val)
write.table(snp_candidate_info, paste0("outliers_snp",ENV,"K",3,".txt"))

