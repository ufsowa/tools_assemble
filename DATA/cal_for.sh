#!/usr/bin/env bash

#SBATCH -J TD
#SBATCH -N 1 --ntasks-per-node=1
#SBATCH -A difatom
#SBATCH -p plgrid
#SBATCH --time=24:00:00
#SBATCH --error="error.err"
#SBATCH --output="output.out"


echo "start: "`date`
cd $SLURM_SUBMIT_DIR

echo "SLURM_JOB_NODELIST=$SLURM_JOB_NODELIST" > started_qsub
echo "SLURM_NNODES=$SLURM_NNODES" >> started_qsub

#echo "SLURMTMPDIR=$SLURMTMPDIR" >> started_qsub
echo $SLURM_JOBID > jobid


# variables
ID="diff"

# paths
TO=$PWD
NAME="T*"
DEST=${TO}"/data/"
SRC=$PWD/scripts

cd ${DEST}
for i in ${NAME}; do
    cd $i
    name="${ID}$i"
#    screen -dmS $name
#    screen -S $name -X screen $SRC/calculate
#    srun -J $name -p plgrid -A mcdyfuzja -N 1 -n 1 -o job%j.out time $SRC/calculate &> log &
#    srun -n 1 $SRC/calculate &> log &
    srun -n 1 $SRC/calculate "_global" &> log &
    cd ${DEST}
done

sleep 5
squeue
sinfo -o "%c %C %O %z" -n $SLURMD_NODENAME
wait
#screen -ls
echo "end: "`date`
