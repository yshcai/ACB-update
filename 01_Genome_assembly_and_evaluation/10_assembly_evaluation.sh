# !/bin/bash
database=/public/caiyuanshi/bioinfo_software/busco_database
fasta=/public/caiyuanshi/hifi/t2t_of/3.Chromosome/Ostrinia_furnacalis_genome.fa
ccs=/public/caiyuanshi/hifi/of_genome/1.HiFireads/Of_FP283.ccs.fasta
genome_size=498685998

mkdir quast qv coverage

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate assembly

##### quast and BUSCO #####
python /public/caiyuanshi/miniconda3/envs/assembly/bin/quast $fasta -t 8 -o quast
busco -i $fasta -o busco -m genome --augustus --offline -l ${database}/insecta_odb10 -c 12

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate merqury

##### merqury #####
# best kmer
/public/caiyuanshi/miniconda3/envs/merqury/share/merqury/best_k.sh $genome_size
k=19

# meryl
cd qv
/public/caiyuanshi/miniconda3/envs/merqury/bin/meryl k=$k count output read.meryl $ccs
/public/caiyuanshi/miniconda3/envs/merqury/share/merqury/merqury.sh read.meryl $fasta Ostrinia
