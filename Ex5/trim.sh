#!/bin/bash

set -e

samples=("SRR25629154" "SRR25629153")

ADAPTERS="/usr/share/trimmomatic/TruSeq3-PE.fa"

for sample in "${samples[@]}"
do

    java -jar /usr/share/java/trimmomatic.jar PE -threads 4 -phred33 \
    ${sample}_1.fastq.gz ${sample}_2.fastq.gz \
    ${sample}_1_trimmed.fastq.gz ${sample}_1_unpaired.fastq.gz \
    ${sample}_2_trimmed.fastq.gz ${sample}_2_unpaired.fastq.gz \
    ILLUMINACLIP:${ADAPTERS}:2:30:10 \
    LEADING:20 TRAILING:20 SLIDINGWINDOW:5:20 MINLEN:50

done

fastqc -t 4 -o ./ *_trimmed.fastq.gz

