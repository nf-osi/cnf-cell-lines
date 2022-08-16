#!/bin/sh
## Uses the files from `synapse get -q "SELECT * FROM syn31864875.1" `
## Filters out mutations not labeled as PASS by Strelka2 and mutations with a quality score <20

for i in *.vcf.gz;
do
    bcftools filter $i -i 'FILTER="PASS" && %QUAL>20' -o $i.filtered.vcf.gz 
    bcftools filter $i -i 'FILTER="PASS" && %QUAL>20 && CHR=="chr17" && POS>31094927 && POS<31382116' -o $i.NF1.vcf.gz
done

for i in *.filtered.vcf.gz
do
    bcftools sort $i -o $i
    bcftools index $i
done

##V1 had a messed up source files, I had to re-retrieve them, so the latest versions of the output files on synapse are the correct ones

for i in *.filtered.vcf.gz
do
    synapse store $i --parentId syn34193635
done

for i in *.NF1.vcf.gz
do
    synapse store $i --parentId syn33016669
done