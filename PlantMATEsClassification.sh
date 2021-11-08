#!/bin/bash

## 2021-11-15

## Classification of MATEs in a new plant species based on RefPlantMATEs.fa dataset

## See https://github.com/pselva7/PlantMATEsClassification for detailed information on its usage

## ❗️for any queries contact: Dr. Panneerselvam Krishnamurthy (pselva7@gmail.com)

############################
# Step_0: Create Variables #
############################
# Comman Variables
donot_delete_intermediate_files="true"	# ❗️If you want to remove the intermediate files then replace the term "true" with "false"
input_ProteinSequence_file=$"TaMATEs.fa"	# ❗️Change the file name TaMATEs.fa with your file name

# BLASTP Variables
max_target_seqs=$"5"	 # This will return only the top 5 best hits
threads=$"10"		 # ❗️Change the number as per your system
outfmt=$"6"		 # Blastp output will be in outformat 6
evalue=$"1E-05"		 # One of parameter invovled in the assignment of subgroups to the query sequences (stage 1: strict)
protein_identity1=$"60"	 # One of parameter invovled in the assignment of subgroups to the query sequences (stage 1: strict)
query_coverage1=$"60"	 # One of parameter invovled in the assignment of subgroups to the query sequences (stage 1: strict)
alignment_length1=$"150" # One of parameter invovled in the assignment of subgroups to the query sequences (stage 1: strict)
SubPer=$"80"		 # One of parameter invovled in the assignment of subgroups to the query sequences (stage 1: strict)
protein_identity2=$"40"	 # One of parameter invovled in the assignment of groups to the still unlcassified query sequences (stage 2: relaxed)
query_coverage2=$"40"	 # One of parameter invovled in the assignment of groups to the still unlcassified query sequences (stage 2: relaxed)
alignment_length2=$"100" # One of parameter invovled in the assignment of groups to the still unlcassified query sequences (stage 2: relaxed)

######################################################
# Create directory, copy files and do classification #
######################################################
# to determine the run time
SECONDS=0

# Create a directory in the name of Classification
mkdir Classification

# Copy/ rename the files into Classification directory
cp $input_ProteinSequence_file Classification/
cp RefPlantMATEs.fa Classification/RefPlantMATEs

# go to Classification directory
cd Classification

# Step_1: get the input sequence ids
awk -F '[ ]' '/^>/ { print substr($1,2)| "sort -u"}' $input_ProteinSequence_file > 1.${input_ProteinSequence_file%.*}"GeneIDs"

# Step_2: determine the protein length of input sequences
seqkit fx2tab --length $input_ProteinSequence_file | cut -f 1,4 | sort > 2.${input_ProteinSequence_file%.*}"Length"

## exit if seqkit is not in the script running environment
if ! [ -s 2.${input_ProteinSequence_file%.*}"Length" ]; then
   echo -e "\nseqkit is not in the script running environment. Aborting\n
Note1: If you installed seqkit under conda, first activate conda in the terminal using the command conda activate and run ./PlantMATEsClassification.sh
Note2: If you installed seqkit outside conda environment, make sure you export the seqkit path to ~/.bashrc\n then run ./PlantMATEsClassification.sh.\n"
    cd ..    
    rm -r Classification
    exit
fi

# Step_3: add the length info to the fasta headers of input sequences
seqkit replace -p '(.+)$' -r '${1}|{kv}' $input_ProteinSequence_file -k 2.${input_ProteinSequence_file%.*}"Length" -o 3.${input_ProteinSequence_file%.*}".fa1"

# Step_4: make a protein database using RefPlantMATEs
makeblastdb -in RefPlantMATEs -dbtype prot

## exit if ncbi-blast+ is not set properly
if ! [ -s *.phr ]; then
   echo -e "\nncbi-blat+ is not in the script running environment. Aborting\n
Note1: If you installed ncbi-blat+ under conda, first activate conda in the terminal using the command conda activate and run ./PlantMATEsClassification.sh
Note2: If you installed ncbi-blat+ outside conda environment, make sure you configure ncbi-blast+ correctly and export the seqkit path to ~/.bashrc\n then run ./PlantMATEsClassification.sh.\n"
    exit
fi

## echo if ncbi-blast+ is working properly
if [ -s *.phr ]; then
echo -e "\n\nA protein database of RefPlantMATEs has been created successfully"
fi

# Step_5: query the input sequences against the RefPlantMATEs database via blastp  search
blastp -query 3.${input_ProteinSequence_file%.*}".fa1" -db RefPlantMATEs -max_target_seqs $max_target_seqs -num_threads $threads -outfmt $outfmt -out 4.${input_ProteinSequence_file%.*}".blastout"

# Step_6: parse the blast output file to retain rows having user-defined e-value threshold
sed 's/|/\t/g' 4.${input_ProteinSequence_file%.*}".blastout" | awk -v OFS='\t' '{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $16}' | awk -v OFS='\t' '{$11 = $9 / $2 * 100}1' | awk -v evalue=$evalue '{if ($10 <= evalue) print $0}' > 5.${input_ProteinSequence_file%.*}".blastout1"

# Step_7: print rows which fulfil either one of two conditions and prepare a pivotal table
awk -v protein_identity1=$protein_identity1 -v query_coverage1=$query_coverage1 -v alignment_length1=$alignment_length1 '{if( ($8 >= protein_identity1 && $11 >= query_coverage1) || ($8 >= protein_identity1 && $11 < query_coverage1 && $9 >= alignment_length1)) { print } }' OFS="\t" 5.${input_ProteinSequence_file%.*}".blastout1" | awk '{print $1"\t"$5}' | sort | datamash -s crosstab 1,2 > 6.${input_ProteinSequence_file%.*}".blastout2"

## exit if datamash is not in the script running environment
if ! [ -s 6.${input_ProteinSequence_file%.*}".blastout2" ]; then
   echo -e "\ndatamash is not installed. Aborting\n
Note: For Linux operating system, install datamash using the command sudo apt install datamash and run ./PlantMATEsClassification.sh\n"
    cd ..    
    rm -r Classification
    exit
fi

# Step_8: sum the row values | calculate the percentage (i.e. field value/sum*100) | assign the maximum value of column index in a row to id's
awk 'FNR > 1 { sum = 0; for (i = 1; i <= NF; i++) sum += $i; $(NF + 1) = sum } 1' OFS="\t" 6.${input_ProteinSequence_file%.*}".blastout2" | awk 'FNR > 1{for(i=2;i<=NF;i++) $i=sprintf("%.1f",$i/$NF*100)} 1' OFS="\t" | awk -F "\t" 'NR==1{split($0,a);next} NR>1 {m=0;for(i=2;i<=NF-1;i++)if($i>m){m=$i;n=i}print $1,a[n],m}' OFS="\t" > 7.${input_ProteinSequence_file%.*}".blastout3"

# Step_9: assign subgroups to genes based on user-defined threshold
awk -v SubPer=$SubPer '$3 >= SubPer {print $1"\t"$2}' 7.${input_ProteinSequence_file%.*}".blastout3" OFS="\t" | awk -F'\t' -vOFS='\t' '{ gsub("MATE-", "", $2) ; print $1, $2, $3=substr($2, 1, length($2)-1), $4="MATE"}' | awk -F'\t' -vOFS='\t' '{ print $1, $4, $3, $2 }' > 8.${input_ProteinSequence_file%.*}"ClassifiedSum1"

# Step_10: list the classified gene ids
awk '{ print $1 }' 8.${input_ProteinSequence_file%.*}"ClassifiedSum1" | sort > 9.${input_ProteinSequence_file%.*}"ClassifiedGeneIDs"

# Step_11: list the unclassified gene ids
awk -F, 'FNR==NR {f2[$1];next} !($0 in f2)' 9.${input_ProteinSequence_file%.*}"ClassifiedGeneIDs" 1.${input_ProteinSequence_file%.*}"GeneIDs" > 10.${input_ProteinSequence_file%.*}"UnclassifiedGeneIDs"

# Step_12: get the attributes of unclassified gene ids from the blastout1 file
grep -Fwf 10.${input_ProteinSequence_file%.*}"UnclassifiedGeneIDs" 5.${input_ProteinSequence_file%.*}".blastout1" > 11.${input_ProteinSequence_file%.*}"UnC1"

# Step_13: print rows which fulfil either one of two conditions and prepare a pivotal table
awk -v protein_identity2=$protein_identity2 -v query_coverage2=$query_coverage2 -v alignment_length2=$alignment_length2 '{if( ($8 >= protein_identity2 && $11 >= query_coverage2) || ($8 >= protein_identity2 && $11 < query_coverage2 && $9 >= alignment_length2)) { print } }' OFS="\t" 11.${input_ProteinSequence_file%.*}"UnC1" | awk -F'\t' -vOFS='\t' '{ gsub("MATE-", "", $5) ; print $1, $2=substr($5, 1, length($5)-1)}' | sort | datamash -s crosstab 1,2 > 12.${input_ProteinSequence_file%.*}"UnC2"

# Step_14: sum the row values | calculate the percentage (i.e. field value/sum*100) | assign the maximum value of column index in a row to id's
awk 'FNR > 1 { sum = 0; for (i = 1; i <= NF; i++) sum += $i; $(NF + 1) = sum } 1' OFS="\t" 12.${input_ProteinSequence_file%.*}"UnC2" | awk 'FNR > 1{for(i=2;i<=NF;i++) $i=sprintf("%.1f",$i/$NF*100)} 1' OFS="\t" | awk -F "\t" 'NR==1{split($0,a);next} NR>1 {m=0;for(i=2;i<=NF-1;i++)if($i>m){m=$i;n=i}print $1,a[n],m}' OFS="\t" > 13.${input_ProteinSequence_file%.*}"UnC3"

# Step_15: list the classified gene ids
awk '{ print $1 }' 13.${input_ProteinSequence_file%.*}"UnC3" | sort > 14.${input_ProteinSequence_file%.*}"ClassifiedGeneIDs1"

# Step_16: add attributes to the classified gene ids1
awk -v SubPer=$SubPer '$3 >= SubPer {print $1"\t"$2}' 13.${input_ProteinSequence_file%.*}"UnC3" OFS="\t" | awk -F'\t' -vOFS='\t' '{print $1, $2, $3="MATE", $4="UnC"}' | awk -F'\t' -vOFS='\t' '{ print $1, $3, $2, $4 }' > 15.${input_ProteinSequence_file%.*}"ClassifiedSum2"

# Step_17: concatante the classified gene ids
cat 9.${input_ProteinSequence_file%.*}"ClassifiedGeneIDs" 14.${input_ProteinSequence_file%.*}"ClassifiedGeneIDs1" | sort > 16.${input_ProteinSequence_file%.*}"ClassifiedGeneIDsSum"

# Step_18: list the unclassified gene ids with attributes
awk -F, 'FNR==NR {f2[$1];next} !($0 in f2)' 16.${input_ProteinSequence_file%.*}"ClassifiedGeneIDsSum" 1.${input_ProteinSequence_file%.*}"GeneIDs" | awk -F'\t' -vOFS='\t' '{print $1, $2="Non-MATE", $3="UnC", $4="UnC"}' > 17.${input_ProteinSequence_file%.*}"UnclassifiedSum"

# Step_19: list the GSF unclassified gene ids
cat 8.${input_ProteinSequence_file%.*}"ClassifiedSum1" 15.${input_ProteinSequence_file%.*}"ClassifiedSum2" 17.${input_ProteinSequence_file%.*}"UnclassifiedSum" | sort > 18.${input_ProteinSequence_file%.*}"SubgroupInfo"

# Step_20: Prepare the final summary and notes
# to save the final stats/notes in a log file
{
dt=$(date '+%Y-%m-%d %H:%M:%S');
echo -e "$dt"

## check weather the the number of genes match between the start and end point.
start_input=`wc -lwc -l 1.${input_ProteinSequence_file%.*}"GeneIDs" | awk '{print $1}'`;
end_input=`wc -l 18.${input_ProteinSequence_file%.*}"SubgroupInfo" | awk '{print $1}'`;
if test $start_input = $end_input; then
    echo -e "\n### Classification completed successfully ###\n
You can use the ${input_ProteinSequence_file%.*}"ClassificationSummary" file for further downstreatm process.\n
Following are some quick stats:"
else
    echo -e "\n### Classification failed. Something went wrong. Check the intermediate files to trace the bug(s) ###\n"
    exit
fi

# Prepare the final summary
awk -vOFS='\t' 'NR==FNR { a[$1]=$0; next } $1 in a { print a[$1], $2, $3, $4, $5 }' 18.${input_ProteinSequence_file%.*}"SubgroupInfo" 2.${input_ProteinSequence_file%.*}"Length" | sort | awk -F'\t' -vOFS='\t' '{ print $1, $5, $2, $3, $4 }' | awk 'BEGIN {OFS= "\t"; print "Gene_Identifier", "Protein_length", "Gene_family", "Group", "SubGroup"}1' > ../${input_ProteinSequence_file%.*}"ClassificationSummary"


## to get some stats
stat1=`awk 'END {print NR}' 18.${input_ProteinSequence_file%.*}"SubgroupInfo"`
stat2=`awk '{A[$2]++}END{for(i in A)print A[i],i}' 18.${input_ProteinSequence_file%.*}"SubgroupInfo" | sort -k2 | awk 'FNR == 1 {print $1}'`
stat3=`awk '{A[$2]++}END{for(i in A)print A[i],i}' 18.${input_ProteinSequence_file%.*}"SubgroupInfo" | sort -k2 | awk 'FNR == 2 {print $1}'`
stat4=`sed '/Non-MATE/d' 18.${input_ProteinSequence_file%.*}"SubgroupInfo" | awk '{A[$3]++}END{for(i in A)print i,A[i]}' | sort | awk '{sum+=$2;}END{print sum;}'`
stat5=`sed '/Non-MATE/d' 18.${input_ProteinSequence_file%.*}"SubgroupInfo" | awk '{A[$3]++}END{for(i in A)print i,A[i]}' | sort | awk 'BEGIN {RS=""}{gsub(/\n/,"; ",$0); print $0}'`
stat6=`sed '/UnC/d' 18.${input_ProteinSequence_file%.*}"SubgroupInfo" | awk '{A[$4]++}END{for(i in A)print i,A[i]}' | sort | awk '{sum+=$2;}END{print sum;}'`
stat7=`sed '/UnC/d' 18.${input_ProteinSequence_file%.*}"SubgroupInfo" | awk '{A[$4]++}END{for(i in A)print i,A[i]}' | sort | awk 'BEGIN {RS=""}{gsub(/\n/,"; ",$0); print $0}'`
((stat8 = $stat2 - $stat6))

# to know the composition of input sequences
if [ -z "$stat3" ]; then
    echo -e "There were $stat1 seqeunces in the input query file. No Non-MATEs were detected.\n"
else
    echo -e "There were $stat1 seqeunces in the input query file that includes $stat2 MATEs and $stat3 Non-MATE(s).\n"
fi

# to know the composition of groups assigned to input sequences
if test $stat2 = $stat4; then
    echo -e "Group was assigned for all MATE sequences present in the input query file: $stat5.\n"
else
    echo -e "Group was assigned for $stat4 of $stat2 MATE sequences present in the input query file: $stat5.\n"
fi

# to know the composition of subgroups assigned to input sequences
if test $stat2 = $stat6; then
    echo -e "Subgroup was assigned for all MATE sequences present in the input query file: $stat7.\n"
else
    echo -e "Subgroup was assigned for $stat6 of $stat2 MATE sequences present in the input query file: $stat7.\n
You can keep the subgroup unclassified MATE(s) (n = $stat8) as such or assign them subgroup based on further validation using any other logical criteria (e.g. synteny, phylogeny or relaxed homology condition)."
fi

# what to do next
if [ ! -z "$stat3" ]; then
    echo -e "\nVerify whether the Non-MATEs (n = $stat3) have MATE domain by any means (e.g. verify them in Pfam database: http://pfam.xfam.org/). If they do have MATE domain(s), consider them as group UnC MATEs (i.e. group Unclassified MATEs). You can assign group to the group UnC MATE(s) based on further validation using any other logical criteria (e.g. synteny, phylogeny or relaxed homology condition). After domain check, you can exclude all the Non-MATEs (which would have no MATE domain, no group information and no subgroup information) for all further downstream processess as per your experiment design.\n"
else
    echo -e ""
fi

# print whether the intermediate files are removed or not, based on user-defined input
if test $donot_delete_intermediate_files = "true" ; then
    cd ..
    echo -e "By following the user-defined variable, intermediate files are kept in the Classification directory.\n"
else
    cd ..    
    rm -r Classification
    echo -e "By following the user-defined variable, the Classification directory having all the intermediate files was removed.\n"
fi

# to determine the run time
duration=$SECONDS
echo -e "Classification elapsed for $(($duration / 3600)) hours, $(($duration / 60)) minutes and $(($duration % 60)) seconds\n"

# Classification completed
echo -e "### END ###\n\n"
} > ../${input_ProteinSequence_file%.*}ClassificationLog

# to show the message in terminal
echo -e "\n\n### Classification completed. It is elapsed for $(($duration / 3600)) h, $(($duration / 60)) m and $(($duration % 60)) s ###"
echo -e "\n### Check the ${input_ProteinSequence_file%.*}ClassificationLog and ${input_ProteinSequence_file%.*}ClassificationSummary files ###\n"

# the END
