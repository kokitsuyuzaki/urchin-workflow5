library("tximport")
library("edgeR")
library("DESeq2")
library("openxlsx")
library("ggplot2")
library("VennDiagram")
library("tagcloud")

# Sample Name Vector
full_sample_name <- c("Blastula", "Cleavage", "Gastrula", "Pluteus", "Prism")
sample_name <- full_sample_name
sorted_sample_name <- full_sample_name

# Color Vector
color_scheme <- c(
    "#1B9E77", "#D95F02",
    "#7570B3", "#E7298A",
    "#66A61E")

colvec <- color_scheme
names(colvec) <- sample_name
