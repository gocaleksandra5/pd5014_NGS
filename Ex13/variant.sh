#!/bin bash 

#genom referencyjny 

genome_path="/home/agoc/Ex13/GCF_000005845.2_ASM584v2_genomic.fna"

samples=(SRR25629153, SRR25629154)

#rep2 to SRR25629153
#rep3 to SRR25629154


sample=${samples[0]}

bcftools mpileup -O b -o ${sample}.bcf -f $genome_path -q 20 -Q 30 ${sample}_fixmate_sorted_dedup.bam

bcftools call --ploidy 1 -m -v -o variants_2.vcf ${sample}.bcf

sample=${samples[1]}

bcftools mpileup -O b -o ${sample}.bcf -f $genome_path -q 20 -Q 30 ${sample}_fixmate_sorted_dedup.bam

bcftools call --ploidy 1 -m -v -o variants_3.vcf ${sample}.bcf


