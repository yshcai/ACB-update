import sys


if len(sys.argv) != 3:
    print('\nuseage:\npython3 ko_background.py <ko00001.keg> <background.result> \n')
    exit()


def ko_background(file, result):

    file = open(file, 'rt')
    result = open(result, 'wt')
    while True:
        line = file.readline().strip()
        if not line:
            break
        elif line[0] == 'A' and len(line) > 1:
            a_id = line[1:6]
            a_name = line[7:len(line)]
        elif line[0] == 'B' and len(line) > 1:
            b_id = line[3:8]
            b_name = line[9:len(line)]
        elif line[0] == 'C' and len(line) > 1:
            pathway_id = line[5:10]
            pathway_name = line[11:len(line)]
            if ' [' in pathway_name:
                pathway_name = pathway_name.split(' [')[0]
        elif line[0] == 'D' and len(line) > 1:
            knum = line[7:len(line)].split('  ')
            if len(knum) > 1:
                k_number = knum[0]
                k_name = knum[1]
                print(k_number + '\t' + k_name + '\t' +
                      'ko' + pathway_id + '\t' + pathway_name + '\t' +
                      b_id + '\t' + b_name + '\t' +
                      a_id + '\t' + a_name, file=result)
    file.close()
    result.close()


if __name__ == '__main__':
    ko_background(file=sys.argv[1], result=sys.argv[2])
