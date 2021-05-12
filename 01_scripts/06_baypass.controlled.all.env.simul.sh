#!/bin/bash
#SBATCH -J "baypass_simu_allenv"
#SBATCH -o log_%j
#SBATCH -c 1 
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=7-00:00
#SBATCH --mem=500M


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR
NB_CPU=1
#
ls -1 06_baypass/all_env/all_env_var | while read ENV
do
echo $ENV 
for i in 1 2 3
do
seed=$((1000 + RANDOM % 9999)) #set random seed
echo "$i"
echo "$seed"

/home/camer78/Softwares/baypass_2.2/sources/g_baypass -npop 16 \
-gfile 06_baypass/G.simulates_pods \
-omegafile 06_baypass/by_pop_0.05_pctind0.5_maxdepth3_pruned_baypass.output_mat_omega.out \
-efile 06_baypass/all_env/all_env_var/$ENV -scalecov \
-outprefix 06_baypass/all_env/G.simulates_pods_baypass.controlled."$ENV"."$i".output -nthreads $NB_CPU -seed $seed
done
done

#
ls -1 06_baypass/all_env/all_env_var2 | while read ENV
do
echo $ENV 
for i in 1 2 3
do
seed=$((1000 + RANDOM % 9999)) #set random seed
echo "$i"
echo "$seed"

/home/camer78/Softwares/baypass_2.2/sources/g_baypass -npop 16 \
-gfile 06_baypass/G.simulates_pods \
-omegafile 06_baypass/by_pop_0.05_pctind0.5_maxdepth3_pruned_baypass.output_mat_omega.out \
-efile 06_baypass/all_env/all_env_var2/$ENV -scalecov \
-outprefix 06_baypass/all_env/G.simulates_pods_baypass.controlled."$ENV"."$i".output -nthreads $NB_CPU -seed $seed
done
done

#
ls -1 06_baypass/all_env/all_env_var3 | while read ENV
do
echo $ENV 
for i in 1 2 3
do
seed=$((1000 + RANDOM % 9999)) #set random seed
echo "$i"
echo "$seed"

/home/camer78/Softwares/baypass_2.2/sources/g_baypass -npop 16 \
-gfile 06_baypass/G.simulates_pods \
-omegafile 06_baypass/by_pop_0.05_pctind0.5_maxdepth3_pruned_baypass.output_mat_omega.out \
-efile 06_baypass/all_env/all_env_var3/$ENV -scalecov \
-outprefix 06_baypass/all_env/G.simulates_pods_baypass.controlled."$ENV"."$i".output -nthreads $NB_CPU -seed $seed
done
done

