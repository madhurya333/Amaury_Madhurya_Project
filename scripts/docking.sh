#! /bin/bash
# Script to do docking with AutoDock Vina.
# Script accepts three arguments: Peptide filename, Residue Number, Protein filename.
# Enter coordinates of grid box in vina command in line 20. 
# USAGE: $ ./docking.sh <PeptideFilename> <Residue> <ProteinFilename>
# This generates a *log.txt and *_out.pdbqt output files.

# Defining a path to access all the data files of the current iteration.
PDBQTfiles="../data/$1_$2_mutants/*.pdbqt"
Path="../data/$1_$2_mutants"

# To access every file in the concerned directory.
for file in $PDBQTfiles
do
	# Storing the name of the mutant file as a variable
        # It can be used to name the output file.
        base=`basename $file .pdbqt`
	# Peptide ligand is docked on protein using AutoDock Vina.
	# Appropriate docking site coordinates are read from user given input.
        vina --receptor ../data/$3.pdbqt --ligand $file --center_x "${4[1]}" --center_y "${4[2]}" --center_z ${4[3]} --size_x ${4[4]} --size_y ${4[5]} --size_z ${4[6]} --log $Path/${base}log.txt --exhaustiveness 1

	# best_value.txt save the name of the log file and the minimum energy value from the log file.
        echo "${base}log.txt" >> $Path/best_value.txt
	# Replacing the extra spaces in the log file to make it space-delimited.
        perl -i -p -e 's/\ +/\ /g' $Path/*log.txt
	# Minimum energy value is extracted from log file.
	cat $Path/${base}log.txt | grep "^\s1" | cut -f 3 -d ' ' >> $Path/best_value.txt

done

exit
