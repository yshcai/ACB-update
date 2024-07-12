# !/bin/bash

##### swissprot #####
blastp -query Ostrinia_furnacalis.pep.no_alt.fa -db /share/home/nxy1hj2cys/bioinfo/database/uniprot/uniprot_sprot.fasta \
        -max_target_seqs 1 -max_hsps 1 -outfmt "6 qseqid qlen sseqid slen pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle" \
        -evalue 1e-5 -num_threads 64 > OfOGS_blastp_swissprot.outfmt6

##### nr #####
blastp -query Ostrinia_furnacalis.pep.no_alt.fa -db /share/home/nxy1hj2cys/bioinfo/database/diamond/nr \
        -max_target_seqs 1 -max_hsps 1 -outfmt "6 qseqid qlen sseqid slen pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle" \
        -evalue 1e-5 -num_threads 96 > OfOGS_blastp_swissprot.outfmt6

##### interpro #####
/interproscan.sh \
-cpu 12 -dp \
-appl CDD,Pfam \
-i Ostrinia_furnacalis.pep.no_alt.fa -f tsv \
-b OfOGS.interpro \
-goterms -pa

##### eggnog #####
http://eggnog-mapper.embl.de/
