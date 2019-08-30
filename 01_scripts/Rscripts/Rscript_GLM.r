argv <- commandArgs(T)
MIN_MAF <- argv[1]
PERCENT_IND <- argv[2]
ENV <- argv[3]

print(ENV)

mafs<-read.table(paste0("02_raw_data/by_pop_",MIN_MAF,"_pctind",PERCENT_IND,".mafs"), header=T, stringsAsFactors = F)
head (mafs)

env<-read.table(paste0("07_glm/all_env_var/", ENV), header=T)

y<-env[,1]
var<-names(env)[1]

glm_freq<-matrix(ncol=7, nrow=dim(mafs)[1])
colnames(glm_freq)<-c("Chromosome","Position", "estimate", "Std.Error", "z", "pval", "log10p")
n<-dim(mafs)[1]
#n=2


for (i in 1: n)
{
  print (i)
  x<-as.numeric(mafs[i,c(5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35)])
  w<-as.numeric(mafs[i, c(6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36)])
  summary_glm<-summary(glm(cbind(round(x*w,0), round((1-x)*w,0))~y, weights=w, family="binomial"))
  glm_freq[i,3:6]<-summary_glm$coefficients[2,]
  glm_freq[i,1]<-as.character(mafs[i,1])
  glm_freq[i,2]<-(mafs[i,2])
  glm_freq[i,7]<- -log10(summary_glm$coefficients[2,4])
}


head(glm_freq)

#save results form
write.table (glm_freq, paste0("07_glm/glm_allsnps_16pop_", var, ".txt"), quote=F, row.names=F)

