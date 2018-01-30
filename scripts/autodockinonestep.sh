#! /bin/bash 
for f in peptide_*.pdbqt; do
    b=`basename $f .pdbqt`
    vina --receptor protein.pdbqt --ligand ${b}.pdbqt --center_x 11 --center_y 90.5 --center_z 57.5 --size_x 22 --size_y 22 --size_z 28 --log ${b}log.txt --exhaustiveness 1
    echo "${b}log.txt" >> best_value.txt
    perl -i -p -e 's/\ +/\ /g' *log.txt
    cat ${b}log.txt | grep "^\s1" | cut -f 3 -d ' ' >> best_value.txt
    #cat ${b}log.txt | grep "^\s\s\s1" | cut -f 11,12,13 -d ' ' >> best.txt
done
perl -i -p -e 's/.txt\n/.txt\t/' best_value.txt
sort -n -k2 best_value.txt > best_sorted.txt
mv *out.pdbqt ~/Desktop/DataOutput
head -1 best_sorted.txt
sed -n 1p best_sorted.txt >> best_mutant.txt


#sed s/\n/\t/ best.txt >> best_tabed.txt
#######the prepare scripts ar in the scripts folder
#prepare_ligand4.py -l #~/Desktop/autodock_vina_1_1_2_linux_x86/bin/vina 
#prepare_receptor4.py -r ~/Desktop/vina_tutorial/protein.pdb 
#ligand=sequence
#new_value='grep ^1 | cut -d "/t" 2'
#if new_value >=lowest_found: 
#	print new lowest
#	lowest_found=[new_value] 
#else:
