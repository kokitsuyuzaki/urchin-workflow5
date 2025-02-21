import pandas as pd
from snakemake.utils import min_version

#################################
# Setting
#################################
min_version("6.5.3")

container: 'docker://koki/urchin_workflow_r:20250116'

rule all:
    input:
        'output/pca/FeatureCounts_ptbio_coordinates.csv',
        'output/pca/FeatureCounts_ptbio_variance.csv'

#################################
# Dimension Reduction
#################################
rule pca_featurecounts:
    input:
        "output/FeatureCounts.txt"
    output:
        'output/pca/FeatureCounts_ptbio_coordinates.csv',
        'output/pca/FeatureCounts_ptbio_variance.csv'
    resources:
        mem_mb=1000000
    benchmark:
        'benchmarks/pca_featurecounts_ptbio.txt'
    log:
        'logs/pca_featurecounts_ptbio.log'
    shell:
        'src/pca_featurecounts.sh {input} {output} >& {log}'
