#! /bin/bash
# This is a test master shell script
# Would eventually run all shell commands to carry out
# "Automated Directed Evolution"!!!
# Or atleast that's what we hope....

## 1. Reading PDB files of target protein and ligand peptide


## 2. Make any necessary  clean-up modifications to the input files

## 3. 
## 	a. Mutagenesis of ligand peptide
##	b. One residue of ligand is mutated and stored in /data/mutants/.
##	c. Convert PDB files to PDBQT files.
##	d. Every set of mutants is docked on AutoDock Vina.
##	e. Affinity log files are compared to screen for best mutant.
##	f. Loop through to step 3a. with best mutant as template.
##	g. End loop when all residues in ligand are mutated and screened.


#---------------USER INPUT-------------------#
### Read protein file
### without extension
#echo " Enter Protein name" 
Protein="protein"
echo $Protein

### Read ligand file
### Without extension
Peptide="peptide"
echo $Peptide

#Number of residues in Peptide
PeptideLength=1


#Define grid box for site of docking on protein
#Center_X, Center_Y, Center_Z, Size_x, Size_y, Size_z
#must be entered in docking.sh script.

#------------END OF USER INPUT-------------#

#Convert protein PDB file to PDBQT file
./prepare_receptor4.py -r ../data/$Protein.pdb -o ../data/$Protein.pdbqt

PeptideOriginal=$Peptide

# For every residue in ligand
#for residue in {1..$PeptideLength}
for ((i=1; i<=$PeptideLength; i++))
do

residue=$i

#Generate mutants using PyMol 
./mutagenesis.sh $Peptide $residue

#Convert all the generated PDB files to PDBQT files
#Store pdbqt files in /data/$Peptide_$residue_mutants/filename.pdbqt
./PDBtoPDBQT.sh $Peptide $residue

#Do Docking and generate affinity log files.
# Store log files in /data/logfiles  
./docking.sh $Peptide $residue $Protein

#Screen all the log files for affinities
#Find the best mutant
./Screen_and_Evolve.sh $Peptide $residue

#Convert best mutant into newest template for next round of evolution.
mv ../data/EvolvedPeptide.pdb ../data/Evolved$PeptideOriginal.pdb
Peptide="Evolved$PeptideOriginal"

done

exit
