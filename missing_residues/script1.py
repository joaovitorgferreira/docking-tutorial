from modeller import *
# Get the sequence of the 1qg8 PDB file, and write to an alignment file
code = 'qpdb'

e = Environ()
m = Model(e, file=code)
aln = Alignment(e)
aln.append_model(m, align_codes=code)
aln.write(file=code+'.seq')