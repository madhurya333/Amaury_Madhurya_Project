#! /bin/bash
# Script to screen current set of mutant by their binding affinities and minimum energy values to select the best mutant of them all.
# USAGE: ./Screen_and_Evolve.sh <Peptidefile> <residue>

# Defining the directory of current round of mutants.
Path="../data/$1_$2_mutants"

# Getting rid of the line endings.
perl -i -p -e 's/.txt\n/.txt /' $Path/best_value.txt
# Sorting the mutants by their min energy value.
sort -n -t' ' -k2 $Path/best_value.txt > $Path/best_sorted.txt

# After sorting, the best mutant is taken from the top of the list.
head -1 $Path/best_sorted.txt
sed -n 1p $Path/best_sorted.txt >> $Path/best_mutant.txt

# The file name of the best mutant from the best_sorted file is used to now select that respective pdb file as the template for next round of mutations.
bestfile="$(head -1 $Path/best_sorted.txt | grep -Eo '^.*_.*_[A-Z]{3}')"
# The best mutant is now renamed as EvolvedPeptide and stored in the main data folder for further rounds of mutations.
cp $Path/$bestfile.pdb ../data/EvolvedPeptide.pdb

exit

