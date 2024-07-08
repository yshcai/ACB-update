# !/bin/bash
fasta=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/Of_FP283.asm.bp.p_ctg.gfa.fa
ccs=/public/caiyuanshi/hifi/of_genome/1.HiFireads/Of_FP283.ccs.fastq.gz
tmp=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/purge_haplotigs/tmp

# map hifi reads to genome
#minimap2 -t 24 -ax map-hifi $fasta $ccs --secondary=no | samtools view -bS - | samtools sort -@ 4 -m 1G -O BAM -o 01.minimap2/aligned.bam -T $tmp/tmp.ali -

# generate a coverage histogram
#purge_haplotigs hist -b 01.minimap2/aligned.bam -g $fasta

# contigs converage stats
purge_haplotigs cov -i 02.cov/aligned.bam.gencov -l 5 -m 36 -h 110

# purge
purge_haplotigs purge -g $fasta -c coverage_stats.csv -d -b 01.minimap2/aligned.bam
