###############################
# Data: 2024-03-12
# Title: reclassify_RepLib_based_SO
# Aim: format the TE name of repeats libraries based on the TE_Sequence_Ontology.txt
# Source: Enosh
###############################

import sys


def reclassify(replib_id, id_table):
    fi = open(replib_id, 'rt')
    fo = open(id_table, 'wt')
    for line in fi:
        raw = line.strip().split(' ')[0]
        prefix = raw.split('#')[0]
        line = raw.split('#')[1]
        if line == "DNA" or line == "DNA/Academ-1" or line == "DNA/Novosib":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Unknown', b=line))
        elif line == "DNA/CMC" or line == "DNA/CMC?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/DTC', b=line))
        elif line == "DNA/CMC-Chapaev":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/CMC-Chapaever', b=line))
        elif line == "DNA/CMC-EnSpm?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/CMC-EnSpm', b=line))
        elif line == "DNA/Crypton-F":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/CryptonF', b=line))
        elif line == "DNA/Crypton-I":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/CryptonI', b=line))
        elif line == "DNA/Ginger-2":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Ginger', b=line))
        elif line == "DNA/Ginger-1":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Ginger1', b=line))
        elif line == "DNA/hAT-hAT19" or line == "DNA?/hAT?" or line == "DNA/hAT?" or line == "DNA/hAT-hAT19?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/hAT', b=line))
        elif line == "DNA/hAT-hATm?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/hAT-hATm', b=line))
        elif line == "DNA/Kolobok-E":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Kolobok', b=line))
        elif line == "DNA/Kolobok-T2?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Kolobok-T2', b=line))
        elif line == "DNA/MULE-Ricksha":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/MULE', b=line))
        elif line == "DNA/MULE-MuDR?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/MULE-MuDR', b=line))
        elif line == "DNA/PIF-Spy":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/PIF', b=line))
        elif line == "DNA/PIF-Harbinger?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/PIF-Harbinger', b=line))
        elif line == "DNA/PIF-ISL2EU?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/PIF-ISL2EU', b=line))
        elif line == "DNA/PiggyBac?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/PiggyBac', b=line))
        elif line == "DNA/TcMar?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/TcMar', b=line))
        elif line == "DNA/TcMar-m44?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/TcMar-m44', b=line))
        elif line == "DNA/TcMar-Tc1?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/TcMar-Tc1', b=line))
        elif line == "DNA/TcMar-Tc4?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/TcMar-Tc4', b=line))
        elif line == "LINE/I?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/I', b=line))
        elif line == "LINE/I-Jockey?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/I-Jockey', b=line))
        elif line == "LINE/L2?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/L2', b=line))
        elif line == "LINE/RTE-ORTE":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/RTE', b=line))
        elif line == "LINE/RTE-RTE?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/RTE-RTE', b=line))
        elif line == "LINE" or line == "LINE/CRE":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LINE/Unknown', b=line))
        elif line == "LTR" or line == "LTR/Unknown":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LTR/unknown', b=line))
        elif line == "RC/Helitron?" or line == "RC/Helitron":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#DNA/Helitron', b=line))
        elif line == "Satellite" or line == "Satellite?":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#Satellite/Satellite', b=line))
        elif line == "Simple_repeat":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#Simple_repeat/NA', b=line))
        elif line == "SINE/5S-Deu":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#SINE/5S', b=line))
        elif line == "SINE/tRNA-Meta" or line == "tRNA" or line == "SINE/tRNA-Deu" or line == "SINE/tRNA-Deu-I" or line == "SINE/tRNA-Deu-L2" or line == "SINE/tRNA-Deu-RTE" or line == "SINE/tRNA-I":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#SINE/tRNA', b=line))
        elif line == "SINE" or line == "SINE?" or line == "SINE/U" or line == "SINE/R1":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#SINE/Unknown', b=line))
        elif line == "unknown" or line == "Unknown" or line == "ARTEFACT":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#repeat/Unknown', b=line))
        elif line == "Retroposon" or line == "Retroposon?" or line == "Retroposon/I-derived":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#Retroposon', b=line))
        elif line == "LTR/Pao":
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#LTR/Bel-Pao', b=line))
        else:
            fo.write('{a}\t{b}\t{c}\n'.format(a=raw, c=prefix + '#' + line, b=line))
    fi.close()
    fo.close()


if __name__ == "__main__":
    reclassify(replib_id=sys.argv[1], id_table=sys.argv[2])
