source("src/Functions.R")

# Parameter
infile <- commandArgs(trailingOnly=TRUE)[1]
outfile <- commandArgs(trailingOnly=TRUE)[2]

# Loading
explained <- unlist(read.table(infile))

# Plot
png(file=outfile, width=800, height=750)
par(ps=24)
plot(explained, type="b",
    xlab="Dimension", ylab="Explained variance",
    pch=16, cex=2)
dev.off()
