#!/bin/bash
## measure concordance between immortalized and non-immortalized cells with non immortalized as "truth"
## to assess genetic integrity of immortalized cells 
## used vcfs from ("SELECT * FROM syn35591895") that were post processed with filter_vcfs.sh
## calculated pairwise concordance

for i in DeepVariant*filtered.vcf.gz
do
  for j in DeepVariant*filtered.vcf.gz
  do
    ic=${i#DeepVariant_} 
    ic=${ic%.filtered.vcf.gz} 
    
    jc=${j#DeepVariant_} 
    jc=${jc%.filtered.vcf.gz} 
    
    echo ${ic}_${jc} comparison
    
    bedtools jaccard -a $i -b $j -f 0.9 -r > ${ic}_${jc}_jaccard.tsv
    
  done
done

for i in *_jaccard.tsv; do synapse store $i --parentId syn36750359; done
