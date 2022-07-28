#!/bin/sh
## Uses the files in ("SELECT * FROM syn31546989")
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