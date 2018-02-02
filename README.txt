## AUTOMATED DIRECTED-EVOLUTION ##
-------------------------------------------------------------------------------
 Created by Madhurya Lutikurti(S3242803) and Amaury Ovalle Maqueo(S3087697)
 Last Modified : 01-02-18 1515 hrs
-------------------------------------------------------------------------------
This program is intended to perform the evolution of a ligand to enhance its interaction with a protein of interest. A combination of computational molecular biology tools are used.
1) PYMOL to generate all the possible mutations for a specific residue of the ligand. 
2) These mutant ligands are docked on a target protein using the program AutoDockVina 
3) The Binding affinities are screened for by finding the system with the lowest energy confirmation. 
4) The best mutant is used as an input for the mutation of the next residue of the ligand and so on. 
As a result of this program you should generate a peptide ligand with a high affinity to the target protein.

(!!IMPORTANT STUFF!!)
REQUIREMENTS:
Tools: Python2.7 ; PyMOL; AutoDock Vina; AutoDock Tools (MGLTools)
Files: <protein>.pdb and <peptide>.pdb in data/ folder.

(!!IMPORTANT STUFF!!)
USAGE:
Place protein and peptide .pdb files in the "data/" folder.
In the scripts folder, open master.sh script to make required user input modifications.
Don't forget to enter the grid box coordinates in the ./docking.sh. (See Appendix Below)
Run $ ./master.sh

DESCRIPTION:
The master.sh shell script takes in user inputs of protein and peptide ligand .pdb files. 
The main function of the script is a loop in which each residue of the ligand is selected one at a time and is committed to the following steps. 

Step 1:
Mutagenesis is done by a mutagenesis.sh shell script. A loop is used to access an array of amino acids which are presented to a python script (mutate.py) which uses the PyMOL Mutagenesis wizard to introduce mutations in the peptide ligand and select the appropriate rotamers in the newly generated mutant peptide PDB files.

Step 2:
PDB files are converted to PDBQT files using PDBtoPDBQT.sh which uses python script from MGLTools for the conversion.

Step 3:
./docking.sh carries out docking of peptide and protein using AutoDock Vina. This program uses as an input the PDBQT file (PDB file with explicit polar hydrogens) of a protein and another of a ligand. It uses this structure to look for the conformation with the lowest energy. Vina generates as an output log file with the different conformation energies and a PDBQT file with the structure of the lowest conformations. 

Step 4:
The generated docking results are screened to find the best mutant with the lowest energy confirmation using the ./Screen_and_evolve.sh script. Here the files are sorted along with the file names and the information of the best mutant is extracted. 
The best mutant is now designated as "EvolvedPeptide"

Step 5:
The "EvolvedPeptide" is renamed with the name of the original peptide and is now the carrier of the best mutations so far. It is now used as the template for the next round of mutations.

When all the residues have been mutated with the best ranked mutations, the loop ends and the PDB file of the final evolution step is the best peptide ligand.


APPENDIX:
Get Grid box coordinates (using AutoDock Tools):
Load the pdb structure in MGLTools > Generate grid box over prefered area in the protein > Change the size of unit to 1 Angstrom > Note the coordinates from the grid box window.    

REFERENCES:
1) O. Trott, A. J. Olson, AutoDock Vina: improving the speed and accuracy of docking with a new scoring function, efficient optimization and multithreading, Journal of Computational Chemistry 31 (2010) 455-461                                                       
DOI 10.1002/jcc.21334                                         
Please see http://vina.scripps.edu for more information. 

2) The PyMOL Molecular Graphics System, Version 2.0 Schrödinger, LLC.
