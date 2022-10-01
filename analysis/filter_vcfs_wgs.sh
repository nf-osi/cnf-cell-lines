#!/bin/sh

## bcftools 1.15.1

## WGS
## STRELKA2
## Uses the files from `synapse get -q "SELECT * FROM syn35838572.1"`
## Filters out mutations not labeled as PASS by Strelka2 and mutations with a quality score <20

for i in *.vcf.gz;
do
    ic=${i#Strelka_} 
    ic=${ic%_variants*gz}  
    
    echo $ic
    bcftools filter $i -i 'FILTER="PASS" && %QUAL>20' -o Strelka2_$ic.filtered.vcf 
done

for i in *.filtered.vcf
do
    gzip $i
    synapse store $i.gz --parentId syn35863215
done



## DEEPVARIANT
## Uses the files from `synapse get -q "SELECT * FROM syn35838508.1"`
## Filters out mutations not labeled as PASS by DeepVariant and mutations with a quality score <20

for i in *.vcf.gz;
do
    ic=${i%.vcf.gz} 
    
    echo $ic
    bcftools filter $i -i 'FILTER="PASS" && %QUAL>20' -o DeepVariant_$ic.filtered.vcf 
done

for i in DeepVariant_*.filtered.vcf
do
    gzip $i
    synapse store $i.gz --parentId syn35864229
done
