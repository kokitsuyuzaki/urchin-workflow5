source("src/Functions.R")

# Parameter
infile <- commandArgs(trailingOnly=TRUE)[1]
outfile1 <- commandArgs(trailingOnly=TRUE)[2]
outfile2 <- commandArgs(trailingOnly=TRUE)[3]

# Loading
mat <- read.delim(infile, skip=1)

# Preprocessing
row_names <- mat[,1]
mat <- as.matrix(mat[, 7:ncol(mat)])
rownames(mat) <- row_names

# PCA
res_pca <- prcomp(t(log10(mat + 1)), center=TRUE)
exprained <- res_pca$sdev^2
exprained <- exprained / sum(exprained)

# Save
write.table(res_pca$x, outfile1)
write.table(exprained, outfile2)
