# !/bin/bash
mcmc=/share/home/nxy1hj2cys/hifi/t2t_of/5.Phylogeny/05.mcmctree/run1/mcmc2/FigTree.tre

##### activate conda environment #####
source /public/caiyuanshi/miniconda3/bin/activate evolution

##### prepare input #####
# convert the tree file into Newick format
cp $mcmc ./
grep "UTREE 1 =" FigTree.tre | sed -E -e "s/\[[^]]*\]//g" -e "s/[ \t]//g" -e "/^$/d" -e "s/UTREE1=//" > tree.txt

# parsing the output of orthofinder2 into a table recognized by cafe
awk 'OFS="\t" {$NF=""; print}' Orthogroups.GeneCount.tsv | awk '{print "(null)""\t"$0}' | sed '1s/(null)/Desc/g' | less> cafe.input.tsv
# remove gene families where one or more species had ≥ 100 gene copies
awk 'NR==1 {print; next} {valid=1; for (i=3; i<=NF; i++) {if ($i >= 100) {valid=0; break}} if (valid) print $0}' cafe.input.tsv | less > cafe.input.filter.tsv

##### cafe round1 #####
# perform analysis with different gamma rate categories to ensure convergence
# Compare Model Gamma Final Likelihood in Gamma_results.txt and select the gama rate category corresponding to the largest value
cafe5 -c 24 -i cafe.input.filter.tsv -t tree.txt -p -k 2 -o k2p
# remove gene families with large variance
grep 'OG' slurm.12019.err | cut -d ':' -f 1 | sort -u | grep -f - -v cafe.input.filter.tsv | less > cafe.input.filter2.tsv

##### cafe round2 #####
rm -r k2p
cafe5 -c 24 -i cafe.input.filter2.tsv -t tree.txt -p -k 2 -o k2p

##### extract expanded gene families #####
# gene families underwent significant expansion or contraction
cat Gamma_family_results.txt | grep "y" | cut -f 1 > Gamma_family_results.p0.05.significant
grep -f Gamma_family_results.p0.05.significant Gamma_change.tab > Gamma_change.tab.p0.05.significant
