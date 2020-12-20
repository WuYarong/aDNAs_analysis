#!/usr/bin/python

"""
Select SNPs at a  certain percent rate, such as 95% percent
"""

import re
import sys
import collections


def dupregion(file):
	dup_dict = dict()
	with open(file) as f:
		for line in f.readlines():
			tmp = line.replace('\n', '').split('\t')
			dup_dict[tmp[1]] = tmp[2]
	return dup_dict


def main(file, dup_dict, percent=0.95):
	out = open('snp.stat', 'w')
	out.write('\tA\tG\tC\tT\tN\t-\t0\t2\ttotal\n')
	with open(file) as f:
		for line in f.readlines():
			line = line.replace('\n', '')
			if re.match('\t', line):
				print line
				continue
			snp_dict = collections.defaultdict(lambda: 0)

			tmp = line.split('\t')

			# rm snps located in dup region
			loc = int(tmp[0].split('_')[-1])
			flag_dup = 0
			for key, value in dup_dict.items():
				if loc >= int(key) and loc <= int(value):
					flag_dup = 1
					break
			if flag_dup == 1:
				continue

			# substitue 0/2/N with -, and - reamins as -
			for i in range(1, len(tmp)):
				snp_dict[tmp[i].upper()] += 1
				tmp[i] = re.sub('0', '-', tmp[i]);
				tmp[i] = re.sub('2', '-', tmp[i]);
				tmp[i] = re.sub('N', '-', tmp[i]);

			nt_count = snp_dict['A'] + snp_dict['C'] + snp_dict['G'] + snp_dict['T']

			flag = 0
			# rm snps have only one status except for 0/-/2/N
			for item in ['A', 'G', 'C', 'T']:
				if nt_count == snp_dict[item]:
					flag = 1
			# print flag
			# rm snps exists more than certain percent strains
			if flag == 0:
				if float(nt_count) / (len(tmp) - 1) >= percent:
					print '\t'.join(tmp)

			total = snp_dict['A']+snp_dict['G']+snp_dict['C']+snp_dict['T']+snp_dict['-']+snp_dict['0']+snp_dict['2']+snp_dict['N']
			out.write('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n'.format(tmp[0], snp_dict['A'], snp_dict['G'], snp_dict['C'], snp_dict['T'], snp_dict['N'], snp_dict['-'], snp_dict['0'], snp_dict['2'], total))


if __name__ == '__main__':
	if len(sys.argv) < 4:
		print 'Usage: python {} <snp.matrix> <percent[float]> <dupregion.file> > <out.matrix>'.format(sys.argv[0])
		sys.exit(-1)
	dup_dict = dupregion(sys.argv[3])
	main(sys.argv[1], dup_dict, float(sys.argv[2]))
