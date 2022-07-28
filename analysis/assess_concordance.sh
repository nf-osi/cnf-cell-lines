#!/bin/bash
## measure concordance between immortalized and non-immortalized cells with non immortalized as "truth"
## to assess genetic integrity of immortalized cells 
## used vcfs from ("SELECT * FROM syn31546989") that were post processed with filter_vcfs.sh
## calculated pairwise concordance
# 
# bedtools jaccard -a Strelka_28NF_variants_VEP.ann.vcf.gz.filtered.vcf.gz -b Strelka_i28NF_variants_VEP.ann.vcf.gz.filtered.vcf.gz > 28cNF_vs_i28cNF_jaccard.tsv
# bedtools jaccard -a Strelka_cNF00.10a_variants_VEP.ann.vcf.gz.filtered.vcf.gz -b Strelka_icNF00.10a_variants_VEP.ann.vcf.gz.filtered.vcf.gz > cNF00.10a_vs_icNF00.10a_jaccard.tsv
# bedtools jaccard -a Strelka_cNF04.9a_variants_VEP.ann.vcf.gz.filtered.vcf.gz  -b Strelka_icNF04.9a_variants_VEP.ann.vcf.gz.filtered.vcf.gz > cNF04.9a_vs_icNF04.9a_jaccard.tsv
# bedtools jaccard -a Strelka_cNF97.2a_variants_VEP.ann.vcf.gz.filtered.vcf.gz  -b Strelka_icNF97.2a_variants_VEP.ann.vcf.gz.filtered.vcf.gz > cNF97.2a_vs_icNF97.2a_jaccard.tsv
# bedtools jaccard -a Strelka_cNF97.2b_variants_VEP.ann.vcf.gz.filtered.vcf.gz  -b Strelka_icNF97.2b_variants_VEP.ann.vcf.gz.filtered.vcf.gz > cNF97.2b_vs_icNF97.2b_jaccard.tsv
# bedtools jaccard -a Strelka_cNF98.4c_variants_VEP.ann.vcf.gz.filtered.vcf.gz  -b Strelka_icNF98.4c_variants_VEP.ann.vcf.gz.filtered.vcf.gz > cNF98.4c_vs_icNF98.4c_jaccard.tsv
# bedtools jaccard -a Strelka_cNF98.4d_variants_VEP.ann.vcf.gz.filtered.vcf.gz  -b Strelka_icNF98.4d_variants_VEP.ann.vcf.gz.filtered.vcf.gz > cNF98.4d_vs_icNF98.4d_jaccard.tsv

for i in Strelka*filtered.vcf.gz
do
  for j in Strelka*filtered.vcf.gz
  do
    ic=${i#Strelka_} 
    ic=${ic%_variants*gz} 
    
    jc=${j#Strelka_} 
    jc=${jc%_variants*gz} 
    
    echo ${ic}_${jc} comparison
    
    bedtools jaccard -a $i -b $j > ${ic}_${jc}_jaccard.tsv
    
  done
done

for i in *_jaccard.tsv; do synapse store $i --parentId syn33620997; done






