#!/bin/sh
## STRELKA2
## Uses the files from `synapse get -q "SELECT * FROM syn31864875.1" `
## Filters out mutations not labeled as PASS by Strelka2 and mutations with a quality score <20

for i in *.vcf.gz;
do
    ic=${i#Strelka_} 
    ic=${ic%_variants*gz}  
    
    echo $ic
    
    bcftools filter $i -i 'FILTER="PASS" && %QUAL>20' -o Strelka2_$ic.filtered.vcf
    bcftools filter $i -i 'FILTER="PASS" && %QUAL>20 && CHR=="chr17" && POS>31094927 && POS<31382116' -o Strelka2_$ic.NF1.vcf
done

##V1 had a messed up source files, I had to re-retrieve them, so the latest versions of the output files on synapse are the correct ones

for i in *.filtered.vcf
do
    gzip $i
    synapse store $i.gz --parentId syn34193635
done

for i in *.NF1.vcf.gz
do
    synapse store $i --parentId syn33016669
done

## DEEPVARIANT
## Uses the files from `synapse get -q "SELECT * FROM syn31546989.1"`
## Filters out mutations not labeled as PASS by Strelka2 and mutations with a quality score <20


for i in *.vcf.gz;
do
    ic=${i%.vcf.gz} 
    
    echo $ic
    bcftools filter $i -i 'FILTER="PASS" && %QUAL>20' -o DeepVariant_$ic.filtered.vcf 
done

for i in DeepVariant_*.filtered.vcf
do
    gzip $i
    synapse store $i.gz --parentId syn35591895
done
