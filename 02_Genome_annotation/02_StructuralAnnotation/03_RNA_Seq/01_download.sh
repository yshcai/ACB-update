# !/bin/bash

##### Collect transcriptome data on NCBI and generate SRA_Accession.txt #####

##### download #####
for i in `cat SRA_Accession.txt`;
do
    echo wget -nc https://sra-pub-run-odp.s3.amazonaws.com/sra/$i/$i | cat >> sra-download.sh
done

mkdir 00.ncbi_data/ && cd 00.ncbi_data/
mv sra-download.sh 00.ncbi_data/
bash sra-download.sh
# filter out non-transcriptome data
