#this code runs signet on the KEGG drosophila database
#A script to run signet 
#1st argument is input, a matirx with columne 1= FLYBASE ID, and as many column as variable to score eahc gene
#2nd argument is either all (will loop on all columns of variable or one of the column name

# code R
library(signet)
library(graphite)
library(dplyr)
library(qvalue)
source("01_scripts/utilities/SearchSubnet_claire.R")
source("01_scripts/utilities/signet_function_claire.R")

#import arguments for file naming
argv <- commandArgs(T)
INPUT <- argv[1]
VAR_TO_TEST<- argv[2]
OUTPUT <- argv [3]



#read matrix of scores
score_annot<-read.table(INPUT, header=T)
head(score_annot)

k=2
while( k<= (dim(score_annot)[2]))
{

#if we ask for just one column, one variable we don't want ti to loop
if(VAR_TO_TEST!="all")
{
VAR<-VAR_TO_TEST
k<-dim(score_annot)[2]+1
print(paste("I am running signet on", VAR_TO_TEST))
}

#if we want all variable it will loop on columns
if(VAR_TO_TEST=="all")
{
VAR<-colnames(score_annot)[k]
print(paste("I am running signet on", VAR, "which is the column",k))
k=k+1
}


#prepare for signet
signet_droso <- subset(score_annot, select=c("FLYBASECG", VAR))
signet_droso[,1]<-paste0("FLYBASECG:",signet_droso[,1])
print(head(signet_droso))

#pathwayDatabases() #to check pathways and species available
paths_droso <- pathways("dmelanogaster", "kegg")
pathway_droso <- lapply(paths_droso, pathwayGraph) #apply the conversion to graph to the list of "pathways" object (graphNEL graph)
#this is to remove the empty pathways that make a bug
dim_pathway<-vector(length=length(pathway_droso))
for (i in 1:length(pathway_droso)){ dim_pathway[i]<-length(pathway_droso[[i]]@edgeL)}
pathway_droso_ok <- lapply(paths_droso[dim_pathway>0], pathwayGraph) #apply the conversion to graph to the list of "pathways" object (graphNEL graph)

length(pathway_droso_ok)


# Apply the simulated annealing algorithm on pathways of your choice
HSS_droso <- searchSubnet(pathway_droso_ok,signet_droso,iterations = 10000)

# Generate the null distribution of the subnetworks scores
null_droso <- nullDist(pathway_droso_ok,signet_droso,n = 10000)

#do the test
HSS_test_droso <- testSubnet(HSS_droso, null_droso)
print(head(HSS_test_droso))

tab_droso <- summary(HSS_test_droso)
head(tab_droso)
tab_droso$pathway_id<-as.character(row.names(tab_droso))
tab_droso$p.val<-as.numeric(as.character(tab_droso$p.val))
#tab_droso$q.val<-qvalue(tab_droso$p.val,pi0.method="bootstrap")$qvalues
print(head(tab_droso))

#save output
write.table(tab_droso, paste0(OUTPUT,"_",VAR, ".txt"), sep="\t")
#writeXGMML(HSS_test_droso, filename = paste0(OUTPUT,"_",VAR, "_HSS_kegg.xgmml"), threshold = 0.05)

##select signif pathway
#tabp0.05<-tab_droso[which(tab_droso$p.val<=0.05),]
#
##save to do figure
#for (i in 1: dim(tabp0.05)[1])
#{
#  j<-as.numeric(tabp0.05$pathway_id[i])
#   writeXGMML(HSS_test_droso[[j]] , filename = paste0("10_signet/OUTPUT,"_",VAR,"_kegg0.05_pw",tabp0.05$pathway_id[i],".xgmml"))
#  
#}
}


