

# To trim away the fixed bases at the start at the start of the dedup
# files.

# The first 5 bases are fixed in the R2 read. # We want to remove them
# Or they'll mess with mapping
# Can change this number in the -f flag below.

# Load the necessary modules
module load nixpkgs/16.09
module load gcc/5.4.0
module load fastx-toolkit/0.0.14


for R2 in *.2.2.fq
do
out=`echo $R2 | sed 's/.2.2.fq\+/.2.fq/'`
fastx_trimmer -f 6 -i $R2 -o $out
done

# Rename R1 files
for R1 in *.1.1.fq
do
out=`echo $R1 | sed 's/.1.1.fq\+/.1.fq/'`
cp $R1 $out
done
