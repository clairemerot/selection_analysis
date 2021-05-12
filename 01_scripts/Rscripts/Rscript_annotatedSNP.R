#import arguments for file naming
argv <- commandArgs(T)
SNP_FILE <- argv[1]
ANNOTATION_FILE <- argv[2]


annot<-read.table(ANNOTATION_FILE, header=TRUE, stringsAsFactors = FALSE)
print(annot)
annot_low_rec_region<-annot[annot$pb=="inv",]

print(annot_low_rec_region)


snp_list<-read.table(SNP_FILE, header =TRUE, stringsAsFactors = FALSE )[,1:2]
colnames(snp_list)<-c("LG", "pos") 


head(snp_list)
Nsnp<-dim(snp_list)[1]

snp_list$low_rec_region<-rep("collinear",length=Nsnp )
   
for (j in 1 : dim(annot_low_rec_region)[1])
{
snp_list$low_rec_region[which(snp_list$LG==annot_low_rec_region$CHR[j] & snp_list$pos>=annot_low_rec_region$start[j] & snp_list$pos <=annot_low_rec_region$stop[j])]<-as.character(annot_low_rec_region$pb2[j])
} 

head(snp_list)
write.table(snp_list, paste0 (SNP_FILE, "_annotated.txt"), row.names = FALSE, sep="\t", quote=FALSE)



