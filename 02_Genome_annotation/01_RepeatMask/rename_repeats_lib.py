###############################
# Data: 2024-03-12
# Title: rename_repeats_lib
# Aim: format the TE name of repeats and output corresponding fasta file
# Source: Enosh
###############################

import sys


def reclassify(orignal_fasta, id_table, rename_fasta):
    fi = open(orignal_fasta, 'rt')
    fi_dict = open(id_table, 'rt')
    fo = open(rename_fasta, 'wt')
    dt = {}
    for line in fi_dict:
        dt[line.strip().split('\t')[0]] = line.strip().split('\t')[2]
    for line in fi:
        if line.startswith('>') and line.strip().split(" ")[0].replace(">", "") in dt.keys():
            new_name = dt[line.strip().split(" ")[0].replace(">", "")]
            fo.write(">" + new_name + "\n")
        else:
            fo.write(line)
    fi.close()
    fi_dict.close()
    fo.close()


if __name__ == "__main__":
    reclassify(orignal_fasta=sys.argv[1], id_table=sys.argv[2], rename_fasta=sys.argv[3])
