#' @param kw string
#' @param p page, integer
args <- commandArgs(trailingOnly = TRUE)

suppressMessages({
  library(httr)
  # library(rvest)
  # library(dplyr)
  # library(xml2)
})

kw = URLencode(args[1])
p = 1
if (length(args) >= 2) p = as.integer(args[2])

offset <- (p - 1) * 32
url <- sprintf("http://localhost/?search=%s&offset=%s", kw, offset)

# print(url)
doc <- GET(url) |> content()
r <- rvest::html_table(doc)[[1]]

str_info <- r[1, 1]
n <- nrow(r)

d <- r[4:n, ] |>
  setNames(c("name", "dir", "size", "date")) |> 
  dplyr::mutate(path = paste0(dir, "\\", name) |> gsub("\\\\", "/", x = _))
# d$path
xs = d$path
lgl = grepl("#recycle|\\.lnk", d$path) # 踢除回收站的文件
xs[!lgl]
