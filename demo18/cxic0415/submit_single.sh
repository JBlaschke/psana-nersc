#!/bin/bash -l
#SBATCH --account=m2859
#SBATCH --job-name=ps2cctbx
#SBATCH --nodes=1
#SBATCH --constraint=knl,quad,cache
#SBATCH --time=01:00:00
#SBATCH --image=docker:monarin/ps2cctbx:test
#SBATCH --exclusive
#SBATCH --qos=premium

t_start=`date +%s`

export PMI_MMAP_SYNC_WAIT_TIME=600
MAX_EVENTS=66
sbcast -p ./input/process_batch.phil /tmp/process_batch.phil
srun -n 68 -c 4 --cpu_bind=cores shifter ./index_single.sh cxic0415 50 0 none $MAX_EVENTS ${PWD}/output
t_end=`date +%s`
echo PSJobCompleted TotalElapsed $((t_end-t_start)) $t_start $t_end
