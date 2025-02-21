import pandas as pd
from snakemake.utils import min_version

#################################
# Setting
#################################
min_version("6.5.3")

container: 'docker://koki/urchin_workflow_bioconda:20240711'

URCHIN_SAMPLES, = glob_wildcards('data/macrogen/{sample}_1.fastq.gz')

rule all:
    input:
        expand('data/ptbio/{sample}/featurecounts/featurecounts.summary',
            sample=URCHIN_SAMPLES)

#################################
# Alignment-based Quantification
#################################
rule star:
    input:
        'data/ptbio/star_index',
        'data/macrogen/{sample}_1.fastq.gz',
        'data/macrogen/{sample}_2.fastq.gz'
    output:
        'data/ptbio/{sample}/star/Aligned.out.sam'
    resources:
        mem_mb=1000000
    benchmark:
        'benchmarks/star_ptbio_{sample}.txt'
    log:
        'logs/star_ptbio_{sample}.log'
    shell:
        'src/star.sh {input} {output} >& {log}'

rule featurecounts:
    input:
        'data/ptbio/{sample}/star/Aligned.out.sam'
    output:
        'data/ptbio/{sample}/featurecounts/featurecounts.summary'
    resources:
        mem_mb=1000000
    benchmark:
        'benchmarks/featurecounts_ptbio_{sample}.txt'
    log:
        'logs/featurecounts_ptbio_{sample}.log'
    shell:
        'src/featurecounts.sh {input} {output} >& {log}'