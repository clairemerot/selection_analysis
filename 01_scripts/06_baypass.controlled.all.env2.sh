#!/bin/bash
#SBATCH -J "baypass_contr.allenv2"
#SBATCH -o log_%j
#SBATCH -c 5 
#SBATCH -p large
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=21-00:00
#SBATCH --mem=3G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR
NB_CPU=5

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
		-gfile 06_baypass/by_pop_0.05_pctind0.5_maxdepth3.mafs.baypass \
		-omegafile 06_baypass/by_pop_0.05_pctind0.5_maxdepth3_pruned_baypass.output_mat_omega.out \
		-efile 06_baypass/all_env/all_env_var2/$ENV -scalecov \
		-outprefix 06_baypass/all_env/by_pop_0.05_pctind0.5_maxdepth3_baypass.controlled."$ENV"."$i".output -nthreads $NB_CPU -seed $seed
	done
done

