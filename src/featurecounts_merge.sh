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

featureCounts -t exon \
-T 4 \
-p \
-F "GFF3" \
-g "Parent" \
-a data/ptbio/Sin.cat.hifiasm.galba.gff3 \
-o $1 \
data/ptbio/*/star/Aligned.out.sam \
--verbose
