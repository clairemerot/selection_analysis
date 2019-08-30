#!/bin/bash
#SBATCH -J "baypass"
#SBATCH -o log_%j
#SBATCH -c 5 
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=7-00:00
#SBATCH --mem=30G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

# Find stacks for each sample
/home/camer78/Softwares/baypass_2.1/sources/g_baypass -npop 16 -gfile 06_baypass/by_pop_0.05_pctind0.5.mafs.baypass -outprefix 06_baypass/by_pop_0.05_pctind0.5_baypass.output -nthreads 5



