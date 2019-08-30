#!/bin/bash
#SBATCH -J "baypass"
#SBATCH -o log_%j
#SBATCH -c 5 
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=7-00:00
#SBATCH --mem=3G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

# Find stacks for each sample
/home/camer78/Softwares/baypass_2.1/sources/g_baypass -npop 16 \
-gfile 06_baypass/G.simulates_pods \
-omegafile 06_baypass/by_pop_0.05_pctind0.5_pruned_baypass.output_mat_omega.out \
-outprefix 06_baypass/G.simulates_pods_baypass.controlled.output -nthreads 5



