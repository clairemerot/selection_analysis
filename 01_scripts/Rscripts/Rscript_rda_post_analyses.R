setwd("/media/claire/Bis/Aout18_allsamples_pilonAA/selection_analysis/03_rda")
folder<-"clim_LF_bed"
var1<-"clim"
var2<-"LF_depth_bed"

setwd("/media/claire/Bis/Aout18_allsamples_pilonAA/selection_analysis/03_rda")
folder<-"clim_only_sd3"
var1<-"clim"
var2<-0



rda <- read.table(paste0(folder,"/rda_loading.txt"), header=T, stringsAsFactors = F)
head(rda)


snp<-read.table("../02_raw_data/by_pop_0.05_pctind0.5.snps", header=T)
head(snp)
rda<-cbind(rda, snp[,1:2])
head(rda)

regions_ordered<-read.table("../07_glm/regions_ordered_bydroso_corr.txt", header=T, stringsAsFactors = F)

rda_ordered<-matrix(ncol=dim(rda)[2]+2)
colnames(rda_ordered)=c(colnames(rda), "droso_element", "pos")
n<-dim(regions_ordered)[1]
#n=100
#1erelements
rda_contigi<-rda[which(rda$chromo==regions_ordered[1,1]),]
droso_element<-rep(regions_ordered[1,2], dim(rda_contigi)[1])
pos<-rda_contigi$position
rda_ordered<-rbind(rda_ordered,cbind(rda_contigi,droso_element, pos) )
pb <- txtProgressBar(2,n, style=3)
#n=100
for (i in 2:n)
{ 
  setTxtProgressBar(pb,i)
  if (length(which(rda$chromo==regions_ordered[i,1]))>=1)
  {
    rda_contigi<-rda[which(rda$chromo==regions_ordered[i,1]),]
    droso_element<-rep(regions_ordered[i,2], dim(rda_contigi)[1])
    pos<-as.numeric(rda_contigi$position) + sum(regions_ordered[1:(i-1),3])
    rda_contigi<-cbind(rda_contigi, droso_element, pos)
    rda_ordered<-rbind(rda_ordered, rda_contigi)
  }
}
setTxtProgressBar(pb,n)
rda_ordered<-rda_ordered[2:dim(rda_ordered)[1],]
rownames(rda_ordered)<-seq(1:dim(rda_ordered)[1])
library(scales)
cols <- rda_ordered$droso_element
cols[which(cols=="X")]<-1
cols[which(cols=="X2L")]<-4
cols[which(cols=="X2R")]<-1
cols[which(cols=="X3L")]<-4
cols[which(cols=="X3R")]<-1
cols[which(cols=="X4")]<-4
cols[which(cols=="z_hors_chr")]<-1
write.table(rda_ordered, paste0(folder, "/rda_ordered",var1,var2,".txt"), quote=F)

cols1<-cols
cols2<-cols
cols1[which(abs(rda_ordered$RDA1)>=(mean(rda_ordered$RDA1)+2.75*sd(rda_ordered$RDA1)))]<-2
cols2[which(abs(rda_ordered$RDA2)>=(mean(rda_ordered$RDA2)+2.75*sd(rda_ordered$RDA2)))]<-2


jpeg(paste0(folder,"/rda_ordered_abs", var1,".jpg"), width=1000, height=400)
plot(as.numeric(rda_ordered$pos)/1000000, abs(as.numeric(rda_ordered$RDA1)), col=alpha(cols1, 0.95), pch=20, ylab="", xlab="", main=var1)
dev.off()

if ( var2!=0)
{
jpeg(paste0(folder,"/rda_ordered_abs", var2,".jpg"), width=1000, height=400)
plot(as.numeric(rda_ordered$pos)/1000000, abs(as.numeric(rda_ordered$RDA2)), col=alpha(cols2, 0.95), pch=20, ylab="", xlab="", main=var2)
dev.off()
}
jpeg(paste0(folder,"/rda_ordered", var1,".jpg"), width=1000, height=400)
plot(as.numeric(rda_ordered$pos)/1000000, (as.numeric(rda_ordered$RDA1)), col=alpha(cols1, 0.05), pch=20, ylab="", xlab="", main=var1)
dev.off()

if ( var2!=0)
{
  jpeg(paste0(folder,"/rda_ordered", var2,".jpg"), width=1000, height=400)
  plot(as.numeric(rda_ordered$pos)/1000000, (as.numeric(rda_ordered$RDA2)), col=alpha(cols1, 0.9), pch=20, ylab="", xlab="", main=var2)
  dev.off()
}