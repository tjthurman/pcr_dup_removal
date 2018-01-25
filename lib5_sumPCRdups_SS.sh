#!/bin/bash

# SBATCH --ntasks=1 # For programs that aren't running with MPI parallelization
# SBATCH --cpus-per-task=1 # the number of cores to use. If a serial job, do 1. Max is 32, and that only works if the program you're working with can handle within-computer parallelization.
#SBATCH --time=0-01:00        # time (DD-HH:MM)
#SBATCH --mem-per-cpu=4G      # Memory per CPU. Not sure if we'll need this. Base compute nodes on cedar have 4GB per CPU.
#SBATCH --account=def-barrett # Account of barrett lab project (more data and priority)
#SBATCH --output="/home/tjthurm/barrett_tim/slurm_logs/%x_%j.out" #where to send the errors and output from the console.
#SBATCH --mail-user=timothy.thurman@mail.mcgill.ca #where to send email to user
#SBATCH --mail-type=BEGIN,END,FAIL #when to email the user
#SBATCH --job-name=lib5_sumPCR_dups

# Load R module
module load r/3.4.3

# Move to the right directory
cd /home/tjthurm/barrett_tim/demulti/lib_5_01_19_2018/dedup

# Call the R script on each of the log files
# This little loop assumes a couple things:
# 1) you have the summarize_PCRdups.R script up on Cedar. You can save it wherever you like and change the path below as needed.
# 2) The  the summarize_PCRdups.R file has been made executable with
# chmod u+x summarize_PCRdups.R
# 3) the only .log files present in the directory from which you run this command are the log files created by Tim's little clone filter loop. If there are other log files, the R script won't read them properly and will throw an error.

for file in *.log
do
Rscript ~src/summarize_PCRdups.R $file  >> lib5_PCRdup_res.txt
done
