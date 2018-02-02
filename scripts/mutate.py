#! /bin/bash
# DESCRIPTION: This script uses PyMOL mutagenesis wizard to carry out mutagenesis in a given residue number in the peptide.
# USAGE: $ pymol -qc mutate.py -- <file.pdb> <file> <selection>/ <mutant>
#Example: To introduce a CYS in 6th residue of peptide.pdb,
# $ pymol -qc mutate.py -- peptide.pdb peptide 6/ CYS

from pymol import cmd
import sys

# Arguments passed to the script
pdb = sys.argv[1]
name = sys.argv[2]
selection = sys.argv[3]
mutant = sys.argv[4]

# Print to screen for the user's info.
print "pdb: " + pdb
print "name: " + name
print "selection: " + selection
print "mutant: " + mutant

# Load the pdb file from the arguments.
cmd.load(pdb)

# PyMOL mutagenesis wizard is loaded.
cmd.wizard("mutagenesis")
cmd.refresh_wizard()
cmd.get_wizard().do_select(selection)
cmd.get_wizard().set_mode(mutant)
cmd.frame(1)
cmd.get_wizard().apply()
cmd.set_wizard()
cmd.save("%s_m.pdb" % name, name)
