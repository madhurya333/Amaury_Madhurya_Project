#! /bin/bash
# Created by Madhurya and Amuary (for PBfB2018 Project)
# Mutagenesis script.
# Takes a Peptide and a residue number as arguments.
# Carries out mutagenesis for the ligand peptide using pymol (see mutate.py)
# Creates PDB files of mutant peptides and stores them in the following folder
# PATH:" ../data/<Peptide>_<Residue>_mutants/<Peptide>_<Residue>_<AminoAcidMutation>.pdb "

# USAGE: $ ./mutagenesis <Peptide> <Residue>

# Create a directory to store the mutants of this particular peptide and residue.
mkdir ../data/$1_$2_mutants

# Defining an array of amino acids 
# 3-Letter codes have been used for the pymol script.
amino=( "ALA") # "CYS" "ASP" "PHE" "GLY" "HIS" "ILE" "LYS" "LEU" "MET" "ASN" "PRO" "ARG" "SER" "THR" "VAL" "TRP" "TYR" )

# The residue in the peptide will be mutated with all possible mutations.
for aminoacid in ${amino[@]}
do
	# PyMol Mutagenesis Wizard is used to generate mutant file (<Peptide>_m.pdb)
	pymol -qc mutate.py -- ../data/$1.pdb $1 $2/ $aminoacid
	# Rename the generated output file and store in the right folder.
	mv "$1_m.pdb" "../data/$1_$2_mutants/$1_$2_$aminoacid.pdb"
done
exit
