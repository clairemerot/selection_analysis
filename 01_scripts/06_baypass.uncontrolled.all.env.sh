#!/bin/bash
#SBATCH -J "uncontrolled_baypass"
#SBATCH -o log_%j
#SBATCH -c 3 
#SBATCH -p large
#SBATCH --mail-type=ALL
#SBATCH --mail-user=claire.merot@gmail.com
#SBATCH --time=21-00:00
#SBATCH --mem=3G


# Important: Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

#
#ls -1 06_baypass/all_env/all_env_var | while read ENV
#do
ENV="Mean_AirTemp.txt"
echo $ENV 
/home/camer78/Softwares/baypass_2.1/sources/g_baypass -npop 16 \
-gfile 06_baypass/by_pop_0.05_pctind0.5.mafs.baypass \
-efile 06_baypass/all_env/all_env_var/$ENV -scalecov \
-outprefix 06_baypass/all_env/by_pop_0.05_pctind0.5_baypass.uncontrolled."$ENV".output -nthreads 3
done
