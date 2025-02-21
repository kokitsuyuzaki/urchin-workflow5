import pandas as pd
from snakemake.utils import min_version

#################################
# Setting
#################################
min_version("6.5.3")

container: 'docker://koki/urchin_workflow_bioconda:20240711'

URCHIN_SAMPLES = pd.read_table('data/sample_sheet.csv',
    sep=',', dtype='string', header=None)[0]
URCHIN_SAMPLES = list(set(URCHIN_SAMPLES))

rule all:
    input:
        expand('data/macrogen/{sample}_1.fastq.gz', sample=URCHIN_SAMPLES),
        expand('data/macrogen/{sample}_2.fastq.gz', sample=URCHIN_SAMPLES)

#################################
# Data download
#################################
rule download_macrogen:
    output:
        'data/macrogen/{sample}_1.fastq.gz',
        'data/macrogen/{sample}_2.fastq.gz'
    resources:
        mem_mb=1000000
    benchmark:
        'benchmarks/download_{sample}.txt'
    log:
        'logs/download_{sample}.log'
    shell:
        'src/download_macrogen.sh {wildcards.sample} >& {log}'
