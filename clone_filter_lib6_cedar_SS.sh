#!/bin/bash

# SBATCH --ntasks=1 # For programs that aren't running with MPI parallelization
# SBATCH --cpus-per-task=1 # the number of cores to use. If a serial job, do 1. Max is 32, and that only works if the program you're working with can handle within-computer parallelization.
#SBATCH --time=0-02:45        # time (DD-HH:MM)
#SBATCH --mem-per-cpu=8G      # Memory per CPU. Not sure if we'll need this. Base compute nodes on cedar have 4GB per CPU.
#SBATCH --account=def-barrett # Account of barrett lab project (more data and priority)
#SBATCH --output="/home/tjthurm/barrett_tim/slurm_logs/%x_%j.out" #where to send the errors and output from the console.
#SBATCH --mail-user=timothy.thurman@mail.mcgill.ca #where to send email to user
#SBATCH --mail-type=BEGIN,END,FAIL #when to email the user
#SBATCH --job-name=clone_filter_lib_6

# Load the stacks module
module load stacks/1.46

# Move to the right directory
cd /home/tjthurm/barrett_tim/demulti/lib_6_fixTags_noRADcheck_05_17_2018/fastq

# A loop that calls clone filter on the fastq files
for R1 in *1.fq
do
name=`echo $R1 | sed 's/.1.fq\+//'`
R2=${R1%1.fq}2.fq       #define a new variable R2 which takes variable R1 and finds (%) 1.fq and replaced with 2.fq
clone_filter -1 $R1 -2 $R2 -i fastq -D --oligo_len_2 7  --index_inline >> $name.log
done
