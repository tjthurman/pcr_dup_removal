# PCR duplicate Removal

A GitHub repo for the project on PCR duplicate removal from ddRAD data using DBRs.


### Test dataset:
I took the first 80 lines (first 20 reads) from my Anolis library 1 forward and reverse reads, and saved them as DBR_test_R1.fastq and DBR_test_R2.fastq.

For the R2 reads, I've added 12 new bases at the start of each line, where the DBR would be. The first 5 bases correspond to the "N"s of the DBR region, the next 2 to the "M"s, and then 5 fixed bases: GGACG.

The first 10 reads are all unique reads. The first 5 have the same DBR region, the next 5 have unique ones. The next 5 reads are duplicates (Read A, same DBRs), made by copy/pasting the same read (in both R1 and R2). The next 3 reads are duplicates (Read B, same DBRs). The next 2 reads are duplicates (Read C, same DBRs). The "B" reads use the same DBR as the 6th read.

For simplicity sake (not sure if it matters), all DBRs are perfectly sequenced (no ambiguities, high quality scores). My guess is that, if we run these through a program, we should get out 13 reads total across all individuals.


I've posted a question on the Stacks google group, am awaiting answers. A good follow-up will be to find out which of the imperfect options to use for real data: I assume the algorithms differ slightly and might have different speeds or memory usage depending on which I pick. 
