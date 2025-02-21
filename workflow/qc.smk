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
        expand('data/{sample}_1/fastqc/{sample}_1_fastqc.html', sample=URCHIN_SAMPLES),
        expand('data/{sample}_2/fastqc/{sample}_2_fastqc.html', sample=URCHIN_SAMPLES)

#################################
# QC
#################################
rule fastqc_1:
    input:
        'data/macrogen/{sample}_1.fastq.gz'
    output:
        'data/{sample}_1/fastqc/{sample}_1_fastqc.html'
    resources:
        mem_mb=10000000
    benchmark:
        'benchmarks/fastqc_{sample}.txt'
    log:
        'logs/fastqc_{sample}.log'
    shell:
        'src/fastqc.sh {input} {wildcards.sample} 1 >& {log}'

rule fastqc_2:
    input:
        'data/macrogen/{sample}_2.fastq.gz'
    output:
        'data/{sample}_2/fastqc/{sample}_2_fastqc.html'
    resources:
        mem_mb=10000000
    benchmark:
        'benchmarks/fastqc_{sample}.txt'
    log:
        'logs/fastqc_{sample}.log'
    shell:
        'src/fastqc.sh {input} {wildcards.sample} 2 >& {log}'
