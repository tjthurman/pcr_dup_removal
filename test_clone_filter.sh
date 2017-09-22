# Testing to see if clone_filter from STACKs removes DBRs
# in the way we want it to

# Load the module which contains STACKS
module load stacks/1.46

# go to the right directory
cd /home/tjthurm/dup_test

# For all tests, put duplicate read in a new file (-D),
# length of oligo on R2 = 7

# Successful removal should leave 13 reads and discard 7.

# inline_null (shouldn't work)
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 7  --inline_null
# Keeps 13 reads.
# Keeps R1 barcodes,
# but does not trim the DBR off of the R2 read.

# null_index (shouldn't work)
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 7  --null_index
# Keeps 13 reads
# keeps the R1 barcodes
# does not trim the DBR off the R2

# index_null (shouldn't work)
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 7  --index_null
# Keeps 13 reads
# keeps the R1 barcodes
# does not trim the DBR off the R2

# inline_inline
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 7  --inline_inline
# Keeps 13 reads
# keeps the R1 barcodes
# trims the DBR off the R2 (but leaves the 5 fixed bases before the cutsite).
# presumably, would go up to the cutsite if I said oligo_len_7 = 12

# index_index
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 7  --index_index
# Keeps 13 reads
# keeps the R1 barcodes
# does not trim the DBR off the R2

#inline_index
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 7  --inline_index
# Keeps 13 reads
# keeps the R1 barcodes
# does not trim the DBR off the R2

#index_inline
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 7  --index_inline
# Keeps 13 reads
# trims the DBR off the R2 (but leaves the 5 fixed bases before the cutsite).
# presumably, would go up to the cutsite if I said oligo_len_7 = 12



# So, unexpectedly, all of these options correctly identified the PCR duplicates and only kept 13 reads (and only kept the first instance of each duplicate). They only differ in whether they keep the DBR region or not.

# The best options seemed to be either index_inline or inline_inline, which both trimmed the DBRs off at the R2s. Let's try it with --oligo_len_2 = 12 to see if that gets rid of the fixed sites in the DBR as well.


#index_inline
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 12  --index_inline
# That did it (results not saved on Github). First 4 bases on the R2 are now the cut site.

# inline_inline
clone_filter -1 DBR_test_R1.fastq  -2 DBR_test_R2.fastq -i fastq  -D --oligo_len_2 12  --inline_inline
# this also worked, first 4 bases on the R2 are now the cut site.
