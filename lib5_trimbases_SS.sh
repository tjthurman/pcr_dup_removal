#!/bin/bash
#PBS -l procs=1
#PBS -l walltime=3:00:00
#PBS -A xpa-194-aa
#PBS -l pmem=3700m
#PBS -o /sf1/project/xpa-194-aa/tim/outputfiles
#PBS -e /sf1/project/xpa-194-aa/tim/errorfiles
#PBS -m bea
#PBS -M timothy.thurman@mail.mcgill.ca
#PBS -N lib5_trim_fixedR2

# Load the necessary modules
source /software/soft.computecanada.ca.sh
module load nixpkgs/16.09
module load gcc/5.4.0
module load fastx-toolkit/0.0.14

# Move to the proper directory
cd /home/tjthurm/barrett_tim/dedup/lib_5

for R2 in *.2.2.fq
do
out=`echo $R2 | sed 's/.2.2.fq\+/.2.fq/'`
fastx_trimmer -f 6 -i $R2 -o $out
done
