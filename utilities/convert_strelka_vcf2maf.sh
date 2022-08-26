#!/bin/bash

##script run in vcf2maf docker container, see here https://github.com/allaway/vcf2maf-docker
##used GRCh38 and vep v107: 

## Need to have rsync and the aws-cliv2 installed.
## Get VEP 107 database. 
## rsync -avr --progress rsync://ftp.ensembl.org/ensembl/pub/release-107/variation/indexed_vep_cache/homo_sapiens_vep_107_GRCh38.tar.gz $HOME/.vep/
## tar -zxf $HOME/.vep/homo_sapiens_vep_107_GRCh38.tar.gz -C $HOME/.vep/

## Get GATK GRCh38 genome (or whatever genome you aligned to if not this one...)
## aws s3 --no-sign-request --region eu-west-1 sync s3://ngi-igenomes/igenomes/Homo_sapiens/GATK/GRCh38/ $HOME/Homo_sapiens_GATK_GRCh38/

## Get vcfs. Place in $HOME/vcfs

##then run docker container like so: 
##docker run -v $HOME/vcfs:/workdir/vcfs:rw -v $HOME/vep:/workdir/vep:ro -v $HOME/Homo_sapiens_GATK_GRCh38/Sequence/WholeGenomeFasta:/workdir/fasta:ro -it --entrypoint /bin/bash nfosi/vcf2maf

cd /mskcc-vcf2maf-*

##test
for i in /workdir/vcfs/*.gz; do
	gunzip $i 
done

for i in /workdir/vcfs/*.vcf; do
	echo $i 
	ic=$(basename ${i})
    ic=${ic%.Strelka.filtered.vcf} 

    perl vcf2maf.pl --input-vcf $i --output-maf /workdir/${ic}.vep.maf --ref-fasta /workdir/fasta/Homo_sapiens_assembly38.fasta --vep-path /root/miniconda3/envs/vcf2maf/bin --vep-data /workdir/vep --ncbi-build GRCh38
done
