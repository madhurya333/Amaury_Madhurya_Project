#!/bin/bash

# this is a test script for mutagenesis step of ADE.
# has a looooop to make multiple mutant files.

# peptide= "$1"
amino=( "ALA" "CYS" "ASP" ) #"GLU" "PHE" "GLY" "HIS" "ILE" "LYS" "LEU" "MET" "ASN" "PRO" "ARG" "SER" "THR" "VAL" "TRP" "TYR" )


#for element in ${amino[@]}
#do
#    echo $element
#done

#echo ""
#echo "Nbr of elements:" ${#amino[@]}

#echo ""
#echo ${amino[@]}


#number of residues in peptide ... 
#In the test run I use the protein so 
#only first six residues get mutated.

for number in {1..2}
do 
	for aminoacid in ${amino[@]}
	
	do
	echo $number
	pymol -qc mutate2.py -- $1.pdb $1 $number/ $aminoacid
	mv "$1_m.pdb" "./mutant_peptides/$1_${number}_$aminoacid.pdb"
	done
done
