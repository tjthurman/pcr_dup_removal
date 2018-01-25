# Run clone filter on all the fastq files in a folder

for R1 in *1.fq
do
name=`echo $R1 | sed 's/.1.fq\+//'`
R2=${R1%1.fq}2.fq       #define a new variable R2 which takes variable R1 and finds (%) 1.fq and replaced with 2.fq
clone_filter -1 $R1 -2 $R2 -i fastq -D --oligo_len_2 7  --index_inline >> $name.log
done
