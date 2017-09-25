#!/bin/bash -l
#SBATCH --partition=regular
#SBATCH --account=lcls
#SBATCH --qos=normal
#SBATCH --job-name=psauto
#SBATCH --nodes=1
#SBATCH --constraint=knl
#SBATCH --time=00:15:00
#SBATCH --image=docker:monarin/psanatest:latest
t_start=`date +%s`
srun -n 68 -c 4 --cpu_bind=cores shifter ./index.sh cxic0415 98 0 lustre 
t_end=`date +%s`
n_cpus=68
echo N_Cpus $n_cpus
echo PSJobCompleted TotalElapsed $((t_end-t_start)) $t_start $t_end
