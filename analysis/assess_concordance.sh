#!/bin/bash
## measure concordance between immortalized and non-immortalized cells with non immortalized as "truth"
## to assess genetic integrity of immortalized cells 
## used vcfs from ("SELECT * FROM syn34593005") that were post processed with filter_vcfs.sh
## calculated pairwise concordance

## revised analysis with stringent -r filter, version 1 of files in syn34227782
for i in Strelka*filtered.vcf.gz
do
  for j in Strelka*filtered.vcf.gz
  do
    ic=${i#Strelka_} 
    ic=${ic%_variants*gz} 
    
    jc=${j#Strelka_} 
    jc=${jc%_variants*gz} 
    
    echo ${ic}_${jc} comparison
    
    bedtools jaccard -a $i -b $j -f 0.9 -r > ${ic}_${jc}_jaccard.tsv
    
  done
done

for i in *_jaccard.tsv; do synapse store $i --parentId syn34227782; done


for i in Strelka*NF1.vcf.gz
do
  for j in Strelka*NF1.vcf.gz
  do
    ic=${i#Strelka_} 
    ic=${ic%_variants*gz} 
    
    jc=${j#Strelka_} 
    jc=${jc%_variants*gz} 
    
    echo ${ic}_${jc} comparison
    
    bedtools jaccard -a $i -b $j > ${ic}_${jc}_NF1_jaccard.tsv -r 
    
  done
done

for i in *_NF1_jaccard.tsv; do synapse store $i --parentId syn33702533; done


