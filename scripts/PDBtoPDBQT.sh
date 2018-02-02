#!/bin/bash
# Script to convert PDB files to PDBQT files.
# USAGE: $ ./PDBtoPDBQT.sh $Peptide $residue

# Defining a path to access all the data files of the current iteration.
PDBsPath="../data/$1_$2_mutants/*.pdb"

# Accessing every .pdb file in the above defined directory.
for file in $PDBsPath
do
	# Storing the name of the mutant file as a variable
	# It can be used to name the output file.
        c=`basename $file .pdb`
	# Python script from MGLTools to do the conversion.
	./prepare_ligand4.py -l ${file} -o ../data/$1_$2_mutants/$c.pdbqt

done 
exit
