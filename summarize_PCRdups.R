#!/usr/bin/env Rscript

########
## An R script, to be called from the command line,
## which analyzes the log files I created from clone_filter
## to summarize the amount of PCR duplicates.
#######


## Check that packages are installed, suppress warnings about them.
suppressWarnings(suppressMessages(require(tidyr)))
suppressWarnings(suppressMessages(require(dplyr)))
suppressWarnings(suppressMessages(require(ggplot2)))
require(tidyr, quietly = T, warn.conflicts = F)
require(dplyr, quietly = T, warn.conflicts = F)
require(ggplot2, quietly = T, warn.conflicts = F)

# get arguments
args <- commandArgs(trailingOnly=TRUE)
print(args)
#args <- c("AA-006.log", "X")
# Load in the log file from clone_filter
info <- read.delim(file = args[1], header = T)
#info <- read.delim(file = "~/Desktop/AA-006.log", header = T)

# Get the total number of fragments
total.frag <- sum(info$Count)
retained.frag <- info$Count[1]
percDup <- (1- (retained.frag/total.frag))*100

# make and save a histogram
plot <- ggplot(data = info, aes(x = Num.Clones, y = Count)) +
  geom_line() +
  ggtitle(sub(pattern = ".log", replacement = "", x = args[1])) +
  xlab(label = "Number of copies") + ylab("# of sequences")
ggsave(plot, file = paste(sub(pattern = ".log", replacement = ".PCRDup", x = args[1]), ".pdf", sep = ""),
       width = 5.5, height = 5.5)
# get results, print them to std. output so that they can be piped if necessary

# order: filename, total frags, retained.frag, percDup
results <- c(total.frag, retained.frag, round(percDup, digits = 2))
# results <- c(sub(pattern = ".merged.depth.bed", replacement = "", x = args[1]), results)

cat(sub(pattern = ".log", replacement = "", x = args[1]), results, "\n", sep = "\t")
