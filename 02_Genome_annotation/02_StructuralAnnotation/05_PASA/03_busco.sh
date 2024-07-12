# !/bin/bash
database=/share/home/nxy1hj2cys/bioinfo/busco_database

busco -i Ostrinia_furnacalis.pep.no_alt.fa -o busco -m prot --augustus --offline -l ${database}/insecta_odb10 -c 32
