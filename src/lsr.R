#! /usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)

p = args[1]
indir <- dirname(p)

# if (length(args) >= 2) indir = args[2]
fs = dir(indir, p, full.names = TRUE)

for (f in fs) {
  cat(sprintf("%s\n", f))
}

# library(argparse)

# # 创建参数解析对象
# parser <- ArgumentParser()

# parser$add_argument("integers",
#   metavar = "N", type = "integer", nargs = "+",
#   help = "an integer for the accumulator"
# )
