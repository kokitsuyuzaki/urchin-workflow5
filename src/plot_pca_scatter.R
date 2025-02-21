source("src/Functions.R")

# Parameter
infile1 <- commandArgs(trailingOnly=TRUE)[1]
infile2 <- commandArgs(trailingOnly=TRUE)[2]
outfile <- commandArgs(trailingOnly=TRUE)[3]

# Loading
coordinates <- read.table(infile1)
explained <- unlist(read.table(infile2))

# Label
xlab <- paste0("PC1 (", round(explained[1], 4)*100, " %)")
ylab <- paste0("PC2 (", round(explained[2], 4)*100, " %)")

# Plot
png(file=outfile, width=700, height=700)
par(ps=22)
plot(coordinates[, 1:2], col=colvec, pch=16,
    cex=3, xlab=xlab, ylab=ylab)
legend("topleft",
    fill = colvec,
    legend = sorted_sample_name)
dev.off()
