 

#!/bin/bash

for sample in SRR37684294 SRR37684295 SRR37684292

do
trimmomatic SE -phred33 -threads 4 \
${sample}_noA.fastq.gz \
${sample}_trimmed.fastq.gz \
LEADING:20 TRAILING:20 SLIDINGWINDOW:5:20 MINLEN:50
done
