library(lfmm)

#import arguments for file naming
argv <- commandArgs(T)
MAF_FILE <- argv[1]
OUTPUT_FOLDER <- argv[2]
ENV<-argv[3]
ENV_FOLDER<-argv[4]


maf<-read.table(MAF_FILE, sep=" ", header=T)
head(maf)

geno<-t(maf)

for (k in 1:5){
n_rep<-1

#loop over environments?
env<-read.table(paste0(ENV_FOLDER,"/", ENV), header=T)
env_scaled<-(env[,1] - mean (env[,1])) / sd (env[,1])

print(paste ("run lfmm on env", ENV , "with k=", k, "and", n_rep, "replicates"))


z_matrix<-matrix(nrow=dim(geno)[2], ncol=n_rep)
colnames(z_matrix)<-paste(rep(colnames(env)[1], n_rep), seq(1:n_rep), sep="_")
rownames (z_matrix)<-rownames(maf)
p_matrix<-matrix(nrow=dim(geno)[2], ncol=n_rep)
colnames(p_matrix)<-paste(rep(colnames(env)[1], n_rep), seq(1:n_rep), sep="_")
rownames (p_matrix)<-rownames(maf)

jpeg(paste0(OUTPUT_FOLDER,ENV,"_k",k,".jpeg"), width=1000, height=(250*k))
par(mfrow=c(n_rep, 2))

for (i in 1 : n_rep)
{
print(i)
 ## Fit an LFMM, i.e, compute B, U, V estimates
 mod.lfmm <- lfmm_ridge(Y = geno,X = env_scaled, K = k)
 
 ## performs association testing using the fitted model:
 pv <- lfmm_test(Y = geno,X = env_scaled, lfmm = mod.lfmm, calibrate = "gif")
 pvalues <- pv$calibrated.pvalue
 
 p_matrix[,i]<-pvalues
 z_matrix[,i]<-pv$score
  
 qqplot(rexp(length(pvalues), rate = log(10)),-log10(pvalues), xlab = "Expected quantile", pch = 19, cex = .4)
 abline(0,1)
 plot(-log10(pvalues),pch = 19,cex = .2,xlab = "SNP", ylab = "-Log P")
 
}
dev.off ()

write.table(z_matrix, paste0(OUTPUT_FOLDER,ENV,"_k",k,".zcores"), quote=F)
write.table(p_matrix, paste0(OUTPUT_FOLDER,ENV,"_k",k,".pvalcalib"), quote=F)
}