# library(Ipaper)
# library(data.table)
# library(stringr)
#' @param pattern string
#' @param fout string
#' @param indir string
args <- commandArgs(trailingOnly = TRUE)

pattern <- args[1]
indir <- dirname(pattern)

fout <- NULL
if (length(args) >= 2) fout = args[2]


file_ext <- function(file) {
  ext <- stringr::str_extract(basename(file), "(?<=\\.).{1,4}$")
  if (grepl(" ", ext)) ext <- ""
  ext
}

read_file <- function(f) {
  fun <- switch(file_ext(f),
    csv = data.table::fread,
    xls = readxl::read_xls,
    xlsx = Ipaper::read_xlsx
  )
  d <- fun(f)
  d
}

# ! not used
read_files <- function(fs) {
  lapply(fs, read_file)
}

# merge_files <- function(fs, fout) {
#   lst <- lapply(fs, read_file)
#   df <- lapply(lst, \(d) d) |> data.table::rbindlist()
#   data.table::fwrite(df, fout, bom = TRUE) # convert into csv
# }
write_dir <- function(fs, fout) {
  df <- lapply(fs, read_file) |>
    data.table::rbindlist() |>
    unique()
  print(head(df))
  data.table::fwrite(df, fout, bom = TRUE)
}

fs <- dir(indir, pattern, full.names = TRUE)

if (is.null(fout)) {
  for (f in fs) {
    cat(sprintf("%s\n", f))
  }
} else {
  write_dir(fs, fout)
  # read_files(fs) |> merge_files(fout)
}

# if (is.null(outdir)) outdir <- dirname(fs[1])
# years <- str_extract(basename(fs), "\\d{4}")
# year_min <- min(years)
# year_max <- max(years)

# name <- str_replace_all(prefix, c(
#   "热带" = "_热带",
#   "落叶阔叶林" = "_DBF",
#   "统计数据" = "",
#   "分钟数据" = "min",
#   "气象" = "_Met_",
#   "通量" = "_Flux_"
# ))
# fout <- glue("{outdir}/{name}_{year_min}_{year_max}.csv")
