import pandas as pd
from snakemake.utils import min_version

#################################
# Setting
#################################
min_version("6.5.3")

container: 'docker://koki/urchin_workflow_bioconda:20240711'

rule all:
    input:
        'data/ptbio/star_index/Log.out'

#################################
# Alignment-based Quantification
#################################
rule index_star_ptbio:
    input:
        'data/ptbio/Sin.cat.hifiasm.fa',
        'data/ptbio/Sin.cat.hifiasm.galba.gff3'
    output:
        'data/ptbio/star_index/Log.out'
    resources:
        mem_mb=1000000
    benchmark:
        'benchmarks/star_index_ptbio.txt'
    log:
        'logs/star_index_ptbio.log'
    shell:
        'src/star_index_ptbio.sh >& {log}'
