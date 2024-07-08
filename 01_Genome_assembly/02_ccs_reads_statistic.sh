# !/bin/bash
hifireads=/public/caiyuanshi/hifi/of_genome/1.HiFireads/Of_FP283.ccs.fastq.gz

##### simple statistics of FASTA/Q files #####
#seqkit stats -a -j 2 $hifireads > hifireads_stats.txt

##### convert FASTA/Q to tabular format (and length, GC content, average quality...) #####
seqkit fx2tab --length --gc --only-id --name -j 2 $hifireads -o Of_FB283.ccs.fastq.Length_GC.txt
