#############
args = commandArgs(trailingOnly=TRUE)

#source functions from Gautier file
source("~/Softwares/baypass_2.1/utils/baypass_utils.R")

#load omega matrix
omega = as.matrix(read.table("by_pop_0.05_pctind0.5_maxdepth3_pruned_baypass.output_mat_omega.out"))

#load beta parameters
pi.beta.coef=read.table("by_pop_0.05_pctind0.5_maxdepth3_pruned_baypass.output_summary_beta_params.out", h=T)$Mean

#make geno matrix
#lobster.data <- geno2YN(args[3])

#create the POD - simulate - don't forget to change suffix name
simu.bta <- simulate.baypass(omega.mat=omega, nsnp=10000,beta.pi=pi.beta.coef, suffix="simulates_pods")
