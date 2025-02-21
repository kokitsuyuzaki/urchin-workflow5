import pandas as pd
from snakemake.utils import min_version

#################################
# Setting
#################################
min_version("6.5.3")

container: 'docker://koki/urchin_workflow_r:20250116'

rule all:
    input:
        'plot/heatmap/FeatureCounts.png',
        'plot/pca/FeatureCounts_ptbio_coordinates.png',
        'plot/pca/FeatureCounts_ptbio_scatter.png',
        # 'plot/pca/FeatureCounts_scatter_no_exp_genes.png',
        # 'plot/pca_scatter_mapping_rate.png',
        'plot/pca/FeatureCounts_ptbio_variance.png'

#################################
# Plot
#################################
rule heatmap_featurecounts:
    input:
        "output/FeatureCounts.txt"
    output:
        'plot/heatmap/FeatureCounts.png'
    resources:
        mem_mb=10000000
    benchmark:
        'benchmarks/heatmap_FeatureCounts.txt'
    log:
        'logs/heatmap_FeatureCounts.log'
    shell:
        'src/heatmap.sh {input} {output} >& {log}'

rule plot_pca_coordinates_featurecounts:
    input:
        'output/pca/FeatureCounts_ptbio_coordinates.csv'
    output:
        'plot/pca/FeatureCounts_ptbio_coordinates.png'
    resources:
        mem_mb=10000000
    benchmark:
        'benchmarks/plot_pca_coordinates_FeatureCounts_ptbio.txt'
    log:
        'logs/plot_pca_coordinates_FeatureCounts_ptbio.log'
    shell:
        'src/plot_pca_coordinates.sh {input} {output} >& {log}'

rule plot_pca_scatter_featurecounts:
    input:
        'output/pca/FeatureCounts_ptbio_coordinates.csv',
        'output/pca/FeatureCounts_ptbio_variance.csv'
    output:
        'plot/pca/FeatureCounts_ptbio_scatter.png'
    resources:
        mem_mb=10000000
    benchmark:
        'benchmarks/plot_pca_scatter_FeatureCounts_ptbio.txt'
    log:
        'logs/plot_pca_scatter_FeatureCounts_ptbio.log'
    shell:
        'src/plot_pca_scatter.sh {input} {output} >& {log}'

# rule plot_pca_scatter_no_exp_genes_featurecounts:
#     input:
#         expand('output/pca/FeatureCounts_{db1}_{type}_coordinates.csv',
#             db1=DBS1, type=TYPES),
#         expand('output/pca/FeatureCounts_{db1}_{type}_variance.csv',
#             db1=DBS1, type=TYPES),
#         expand('output/pca/FeatureCounts_{db1}_{type}_coordinates_wo_2cells.csv',
#             db1=DBS1, type=TYPES),
#         expand('output/pca/FeatureCounts_{db1}_{type}_variance_wo_2cells.csv',
#             db1=DBS1, type=TYPES)
#     output:
#         'plot/pca/FeatureCounts_{db1}_{type}_scatter_no_exp_genes.png',
#         'plot/pca/FeatureCounts_{db1}_{type}_scatter_wo_2cells_no_exp_genes.png'
#     resources:
#         mem_mb=10000000
#     benchmark:
#         'benchmarks/plot_pca_scatter_no_exp_genes_FeatureCounts_{db1}_{type}.txt'
#     log:
#         'logs/plot_pca_scatter_no_exp_genes_FeatureCounts_{db1}_{type}.log'
#     shell:
#         'src/plot_pca_scatter_no_exp_genes.sh FeatureCounts {wildcards.db1} {wildcards.type} {output} >& {log}'

# rule plot_pca_scatter_mapping_rate:
#     input:
#         expand('data/{db1}/{type}/mapping_rate.txt',
#             db1=DBS1, type=TYPES),
#         expand('output/pca/{counts}_{db1}_{type}_coordinates.csv',
#             counts=COUNTS, db1=DBS1, type=TYPES),
#         expand('output/pca/{counts}_{db1}_{type}_variance.csv',
#             counts=COUNTS, db1=DBS1, type=TYPES),
#         expand('output/pca/{counts}_{db1}_{type}_coordinates_wo_2cells.csv',
#             counts=COUNTS, db1=DBS1, type=TYPES),
#         expand('output/pca/{counts}_{db1}_{type}_variance_wo_2cells.csv',
#             counts=COUNTS, db1=DBS1, type=TYPES)
#     output:
#         'plot/pca/{counts}_{db1}_{type}_scatter_mapping_rate.png',
#         'plot/pca/{counts}_{db1}_{type}_scatter_wo_2cells_mapping_rate.png'
#     resources:
#         mem_mb=10000000
#     benchmark:
#         'benchmarks/plot_pca_scatter_mapping_rate_{counts}_{db1}_{type}.txt'
#     log:
#         'logs/plot_pca_scatter_mapping_rate_{counts}_{db1}_{type}.log'
#     shell:
#         'src/plot_pca_scatter_mapping_rate.sh {wildcards.counts} {wildcards.db1} {wildcards.type} {output} >& {log}'

rule plot_pca_variance_featurecounts:
    input:
        'output/pca/FeatureCounts_ptbio_variance.csv'
    output:
        'plot/pca/FeatureCounts_ptbio_variance.png'
    resources:
        mem_mb=10000000
    benchmark:
        'benchmarks/plot_pca_variance_FeatureCounts_ptbio.txt'
    log:
        'logs/plot_pca_variance_FeatureCounts_ptbio.log'
    shell:
        'src/plot_pca_variance.sh {input} {output} >& {log}'
