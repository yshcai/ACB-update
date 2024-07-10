###############################
# Data: 2024-03-12
# Title: reclassify_based_DeepTE
# Aim: to extract the new family name of TE classified by DeepTE
# Source: Enosh
###############################

import sys


def reclassify(opt_DeepTE, id_table):
    fi = open(opt_DeepTE, 'rt')
    fo = open(id_table, 'wt')
    for line in fi:
        raw = line.strip().split('\t')[0]
        prefix = raw.split('#')[0]
        line = line.strip().split('\t')[1]
        if line == "ClassI":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#Retroposon', b=line))
        elif line == "ClassII":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Unknown', b=line))
        elif line == "unknown":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#repeat/Unknown', b=line))
        elif line == "ClassIII_Helitron":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Helitron', b=line))
        elif line == "ClassII_MITE":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#MITE/Unknown', b=line))
        elif line == "ClassII_nMITE":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Unknown', b=line))
        elif line.split('_')[1] == "LTR":
            if len(line.split('_')) == 2:
                fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LTR/unknown', b=line))
            else:
                if "BEL" in line:
                    fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LTR/Bel-Pao', b=line))
                else:
                    suffix = '/'.join(line.split('_')[1:3])
                    fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#' + suffix, b=line))
        elif line.split('_')[1] == "DNA":
            if "Harbinger" in line:
                fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/PIF-Harbinger', b=line))
            else:
                suffix = '/'.join(line.split('_')[1:3])
                fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#' + suffix, b=line))
        elif line.split('_')[1] == "nLTR":
            i = line.split('_')[2:]
            if len(i) == 1:
                if i[0] == "LINE":
                    fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/Unknown', b=line))
                elif i[0] == "PLE":
                    fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/Penelope', b=line))
                elif i[0] == "SINE":
                    fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#SINE/Unknown', b=line))
                else:
                    print('check result')
            elif len(i) == 2:
                if i[1] == "Jockey":
                    fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/I-Jockey', b=line))
                else:
                    suffix = '/'.join(i)
                    fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#' + suffix, b=line))
            else:
                print('check result')
        else:
            print('check result')
    fi.close()
    fo.close()


if __name__ == "__main__":
    reclassify(opt_DeepTE=sys.argv[1], id_table=sys.argv[2])


# ClassI
# ClassII
# ClassII_DNA_CACTA_MITE
# ClassII_DNA_CACTA_nMITE
# ClassII_DNA_Harbinger_MITE
# ClassII_DNA_Harbinger_nMITE
# ClassII_DNA_hAT_MITE
# ClassII_DNA_hAT_nMITE
# ClassII_DNA_hAT_unknown
# ClassII_DNA_Mutator_MITE
# ClassII_DNA_Mutator_nMITE
# ClassII_DNA_PiggyBac_MITE
# ClassII_DNA_TcMar_MITE
# ClassII_DNA_TcMar_nMITE
# ClassII_DNA_TcMar_unknown
# ClassIII_Helitron
# ClassII_MITE
# ClassII_nMITE
# ClassI_LTR
# ClassI_LTR_BEL
# ClassI_LTR_Copia
# ClassI_LTR_ERV
# ClassI_LTR_Gypsy
# ClassI_nLTR_LINE
# ClassI_nLTR_LINE_RTE
# ClassI_nLTR_PLE
# ClassI_nLTR_SINE_tRNA
# unknown
