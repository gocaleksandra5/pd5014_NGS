#Instalacja musiałam zainstalować 1.13 bo przy 1.17 pojawiał się błąd 
#conda install -c conda-forge ncurses=5 -y

#Pzeszłam do odpowiedniego folderu 
#cd Winiki/genome_index 

#SAM na BAM 
#samtools view -Sb Ecoli_rep1.sam > Ecoli_rep1.bam

#sortowanie
#samtool ort Ecoli_rep1.bam -o Ecoli_rep1_sorted.bam

#Indeks 
#samtools index Ecoli_rep1_sorted.bam

#Rozmiary 
#du -h Ecoli_rep1.sam   - odp. 582M
#du -h Ecoli_rep1.sam   - odp. 128M


#!/bin/bash

cd ~/Wyniki/genome_index

# mapowanie
bwa mem ecoli.fasta ~/SRR25629154_1_trimmed.fastq.gz ~/SRR25629154_2_trimmed.fastq.gz > rep2.sam
bwa mem ecoli.fasta ~/SRR25629153_1_trimmed.fastq.gz ~/SRR25629153_2_trimmed.fastq.gz > rep3.sam

# konwersja
samtools view -Sb rep2.sam > rep2.bam
samtools view -Sb rep3.sam > rep3.bam

# fixmate (BEZ -m!)
samtools fixmate rep2.bam rep2_fixmate.bam
samtools fixmate rep3.bam rep3_fixmate.bam

# sortowanie
samtools sort rep2_fixmate.bam -o rep2_fixmate_sorted.bam
samtools sort rep3_fixmate.bam -o rep3_fixmate_sorted.bam

# indeks
samtools index rep2_fixmate_sorted.bam
samtools index rep3_fixmate_sorted.bam

# duplikaty - tu chiałam zrobić w wersji poniżej ale mam 1.13 a nie 1.17 
#samtools markdup -r rep2_fixmate_sorted.bam rep2_dedup.bam
#samtools markdup -r rep3_fixmate_sorted.bam rep3_dedup.bam
#dlatego zamieszczam wersje, która mi dziła

samtools rmdup rep2_fixmate_sorted.bam rep2_dedup.bam
samtools rmdup rep3_fixmate_sorted.bam rep3_dedup.bam
