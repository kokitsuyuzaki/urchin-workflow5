#!/bin/bash
#$ -l nc=4
#$ -p -50
#$ -r yes
#$ -q node.q

#SBATCH -n 4
#SBATCH --nice=50
#SBATCH --requeue
#SBATCH -p node03-06
SLURM_RESTART_COUNT=2

STAR --runMode genomeGenerate \
--runThreadN 4 \
--genomeDir data/ptbio/star_index/ \
--genomeFastaFiles data/ptbio/Sin.cat.hifiasm.fa \
--sjdbGTFfile data/ptbio/Sin.cat.hifiasm.galba.gff3 \
--limitGenomeGenerateRAM 34000000000
