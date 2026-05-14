args = commandArgs(trailingOnly = TRUE)
f = args[1]
fout = gsub(".xlsx", ".csv", f)

library(Ipaper)
d = read_xlsx(f)
fwrite(d, fout, bom = TRUE)
