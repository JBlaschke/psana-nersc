#!/bin/bash -l
#SBATCH --account=m2859
#SBATCH --job-name=ps2cctbx
#SBATCH --nodes=1
#SBATCH --constraint=knl,quad,cache
#SBATCH --time=00:15:00
#SBATCH --image=docker:monarin/ps2cctbx:latest
#SBATCH --exclusive
#SBATCH --qos=premium

t_start=`date +%s`

export PMI_MMAP_SYNC_WAIT_TIME=600
sbcast -p ./input/process_batch.phil /tmp/process_batch.phil
sbcast -p ./xtc_process.py /tmp/xtc_process.py
sbcast -p ./input/geom_ld91.json /tmp/geom_ld91.json
t_end_sbcast=`date +%s`

srun -n 68 -c 4 --cpu_bind=cores shifter ./index_single.sh cxid9114 2 0 debug 64 ${PWD}/output
t_end=`date +%s`

echo PSJobCompleted sbcast $((t_end_sbcast-t_start)) TotalElapsed $((t_end-t_start)) 
