# !/bin/bash

##### activate conda environment #####
source /share/home/nxy1hj2cys/miniconda3/bin/activate maker

##### run maker #####
cp -r /share/home/nxy1hj2cys/hifi/t2t_of/4.Annotation/02_StructuralAnnotation/01.braker/out/species/* /share/home/nxy1hj2cys/miniconda3/envs/maker/config/species/
export LIBDIR=/share/home/nxy1hj2cys/miniconda3/envs/maker/share/RepeatMasker/Matrices
export LIBDIR=/share/home/nxy1hj2cys/miniconda3/envs/maker/share/RepeatMasker/Libraries
mpiexec -n 48 maker -base Ofur2_masked -fix_nucleotides maker_bopts.ctl maker_exe.ctl maker_opts.ctl > maker_Ofur2_masked.log 2>&1

##### extract gff3 and fasta #####
cd Ofur2_masked.maker.output/
gff3_merge -d ./Ofur2_masked_master_datastore_index.log -o Ofur.maker.all.gff3
fasta_merge -d ./Ofur2_masked_master_datastore_index.log -o Ofur
awk '$2 == "maker"' Ofur.maker.all.gff3 > Ofur.maker.only.gff3
cp Ofur.maker.all.gff3 Ofur.maker.all.renamed.gff3
cp Ofur.maker.only.gff3 Ofur.maker.only.renamed.gff3
cp Ofur.all.maker.proteins.fasta Ofur.all.maker.proteins.renamed.fasta
cp Ofur.all.maker.transcripts.fasta Ofur.all.maker.transcripts.renamed.fasta

##### create naming table (there are additional options for naming beyond defaults) #####
maker_map_ids --prefix OFUR --justify 6 Ofur.maker.all.gff3 > Ofur.maker.all.name.map
##### replace names in GFF files #####
map_gff_ids Ofur.maker.all.name.map Ofur.maker.all.renamed.gff3
map_gff_ids Ofur.maker.all.name.map Ofur.maker.only.renamed.gff3
##### replace names in FASTA headers #####
map_fasta_ids Ofur.maker.all.name.map Ofur.all.maker.proteins.renamed.fasta
map_fasta_ids Ofur.maker.all.name.map Ofur.all.maker.transcripts.renamed.fasta
