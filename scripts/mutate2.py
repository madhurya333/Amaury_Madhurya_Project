#! /bin/bash

from pymol import cmd
import sys

pdb = sys.argv[1]
name = sys.argv[2]
selection = sys.argv[3]
mutant = sys.argv[4]

print "pdb: " + pdb
print "name: " + name
print "selection: " + selection
print "mutant: " + mutant

cmd.load(pdb)

cmd.wizard("mutagenesis")
cmd.refresh_wizard()
cmd.get_wizard().do_select(selection)
cmd.get_wizard().set_mode(mutant)
cmd.frame(1)
cmd.get_wizard().apply()
cmd.set_wizard()
cmd.save("%s_m.pdb" % name, name)
