# !/bin/bash
fa=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/01.OrthoFinder2/01.pro/
out=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/01.OrthoFinder2/02.output/
tmp=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/01.OrthoFinder2/tmp/

for i in "$fa" "$out" "$tmp"
do
        if [ ! -d  $i ];then
                mkdir -p $i
        else
                echo "Directory $i exists."
        fi
done

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate evolution

##### Obtain the protein sequence corresponding to the longest transcript of the target species, such as Anopheles gambiae #####
python3 get_longest_seq_from_ncbi_gff3.py GCF_943734735.2_idAnoGambNW_F1_1_protein.faa GCF_943734735.2_idAnoGambNW_F1_1_genomic.gff Anopheles_gambiae.pep.no_alt.fa
cp Anopheles_gambiae.pep.no_alt.fa $fa/Anopheles_gambiae.fa
sed -i 's/>/>Agam/g' $fa/Anopheles_gambiae.fa # Add the abbreviated species name before each protein
# Run the above command to obtain the longest protein sequence for different species.

##### orthofinder2 #####
orthofinder -t 16 -X -f $fa -o $out -p $tmp
