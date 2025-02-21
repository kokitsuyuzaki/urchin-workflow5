import pandas as pd
from snakemake.utils import min_version

#################################
# Setting
#################################
min_version("6.5.3")

URCHIN_SAMPLES, = glob_wildcards('data/macrogen/{sample}_1.fastq.gz')

rule all:
    input:
        # 'data/multiqc_report.html',
        # 'data/mapping_rate.txt',
        'output/FeatureCounts.txt'

#################################
# Summary
#################################
rule multiqc:
    input:
        expand('data/{sample}_1/fastqc/{sample}_1_fastqc.html',
            sample=URCHIN_SAMPLES),
        expand('data/{sample}_2/fastqc/{sample}_2_fastqc.html',
            sample=URCHIN_SAMPLES),
        expand('data/{sample}/star/Aligned.out.sam',
            sample=URCHIN_SAMPLES)
    output:
        'data/multiqc_report.html'
    resources:
        mem_mb=1000000
    container:
        'docker://quay.io/biocontainers/multiqc:1.12--pyhdfd78af_0'
    benchmark:
        'benchmarks/multiqc.txt'
    log:
        'logs/multiqc.log'
    shell:
        'src/multiqc.sh >& {log}'

rule export_mapping_rate:
    input:
        'data/multiqc_report.html'
    output:
        'data/mapping_rate.txt'
    resources:
        mem_mb=1000000
    container:
        'docker://quay.io/biocontainers/multiqc:1.12--pyhdfd78af_0'
    benchmark:
        'benchmarks/export_mapping_rate.txt'
    log:
        'logs/export_mapping_rate.log'
    shell:
        'src/export_mapping_rate.sh >& {log}'

rule featurecounts_merge:
    input:
        expand('data/ptbio/{sample}/star/Aligned.out.sam',
            sample=URCHIN_SAMPLES)
    output:
        'output/FeatureCounts.txt'
    resources:
        mem_mb=1000000
    container:
        'docker://koki/urchin_workflow_bioconda:20240711'
    benchmark:
        'benchmarks/featurecounts_merge.txt'
    log:
        'logs/featurecounts_merge.log'
    shell:
        'src/featurecounts_merge.sh {output} >& {log}'