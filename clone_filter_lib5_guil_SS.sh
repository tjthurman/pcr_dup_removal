#!/bin/bash
#PBS -l procs=1
#PBS -l walltime=3:00:00
#PBS -A xpa-194-aa
#PBS -l pmem=3700m
#PBS -o /sf1/project/xpa-194-aa/tim/outputfiles
#PBS -e /sf1/project/xpa-194-aa/tim/errorfiles
#PBS -m bea
#PBS -M timothy.thurman@mail.mcgill.ca
#PBS -N clone_filter_lib5

# Load the stacks module
source /software/soft.computecanada.ca.sh
module load stacks/1.46

# Move to the right directory
cd /home/tjthurm/barrett_tim/demulti/lib_5_fixTags_noRADcheck_01_26_2018/fastq

# A loop that calls clone filter on the fastq files
for R1 in *1.fq
do
name=`echo $R1 | sed 's/.1.fq\+//'`
R2=${R1%1.fq}2.fq       #define a new variable R2 which takes variable R1 and finds (%) 1.fq and replaced with 2.fq
clone_filter -1 $R1 -2 $R2 -i fastq -D --oligo_len_2 8  --index_inline >> $name.log
done
