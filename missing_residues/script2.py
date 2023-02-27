from modeller import *
from modeller.automodel import *    # Load the AutoModel class

log.verbose()
env = Environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

a = LoopModel(env, alnfile = 'alignment.ali',
              knowns = 'qpdb', sequence = 'qpdb_fill')
a.starting_model= 3
a.ending_model  = 4

a.loop.starting_model = 3
a.loop.ending_model   = 4
a.loop.md_level       = refine.fast

a.make()
