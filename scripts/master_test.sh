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


