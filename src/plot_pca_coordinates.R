source("src/Functions.R")

# Parameter
infile <- commandArgs(trailingOnly=TRUE)[1]
outfile <- commandArgs(trailingOnly=TRUE)[2]

# Loading
coordinates <- read.table(infile)

# Plot
png(file=outfile, width=750, height=700)
pairs(coordinates[,1:4], col=colvec,
    pch=16, cex=3, oma=c(3,3,3,15))
par(xpd = TRUE)
legend("bottomright",
    fill = colvec,
    legend = sorted_sample_name)
dev.off()
