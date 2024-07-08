# !/bin/bash
purged=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/purge_haplotigs/03.purge/curated.fasta
telo=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/Of_FP283.asm.bp.p_ctg.gfa.fa.telo.bed
fasta=/public/caiyuanshi/hifi/t2t_of/2.Assembly/contig_fasta/hifi_only_s0.25/Of_FP283.asm.bp.p_ctg.gfa.fa

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate seqkit

##### get the sequence id from purged fasta #####
grep '>' $purged > curated.fasta.id

##### get the sequence id from the result of seqtk #####
cut -f 1 $telo > Of_FP283.asm.bp.p_ctg.gfa.fa.telo.id

##### combine sequence list #####
cat curated.fasta.id Of_FP283.asm.bp.p_ctg.gfa.fa.telo.id | sort -u | less > Of_FP283.asm.bp.p_ctg.final.id

##### get fasta #####
seqkit grep -n -f Of_FP283.asm.bp.p_ctg.final.id -w 80 -o Of_FP283.asm.bp.p_ctg.final.w80.fa $fasta
