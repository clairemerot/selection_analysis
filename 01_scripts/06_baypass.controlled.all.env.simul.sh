#!/bin/bash
#SBATCH -J "baypass"
#SBATCH -o log_%j
#SBATCH -c 5 
#SBATCH -p large
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=21-00:00
#SBATCH --mem=3G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

#
ls -1 06_baypass/all_env/all_env_var | while read ENV
do
echo $ENV 
/home/camer78/Softwares/baypass_2.1/sources/g_baypass -npop 16 \
-gfile 06_baypass/G.simulates_pods \
-omegafile 06_baypass/by_pop_0.05_pctind0.5_pruned_baypass.output_mat_omega.out \
-efile 06_baypass/all_env/all_env_var/$ENV \
-outprefix 06_baypass/all_env/G.simulates_pods_baypass.controlled."$ENV".output -nthreads 5
done
