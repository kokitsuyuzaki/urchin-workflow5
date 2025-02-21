source("src/Functions.R")

# Parameter
infile <- commandArgs(trailingOnly=TRUE)[1]
outfile <- commandArgs(trailingOnly=TRUE)[2]

# Loading
mat <- read.table(infile, header=TRUE)
mat <- as.matrix(mat[, 7:ncol(mat)])
colnames(mat) <- full_sample_name

# Correlationship
cor_mat <- cor(mat)

# Plot
png(file=outfile, width=1000, height=1000)
par(ps=15)
heatmap(cor_mat, margins=c(10, 10))
dev.off()
