# superClassDepth({})
suppressMessages({
  library(httr)
  library(rvest)
  library(dplyr)
  # library(glue)
  # library(xml2)
  # library(magrittr)
  # library(Ipaper)
})

#' @param kw string
#' @param p page, integer
args <- commandArgs(trailingOnly = TRUE)

# Print all arguments
kw = args[1]
p = 1
if (length(args) >= 2) p = as.integer(args[2])
# print(args)

offset <- (p - 1) * 32
url <- sprintf("http://localhost/?search=%s&offset=%s", kw, offset)

doc <- GET(url) |> content()
r <- html_table(doc)[[1]]

str_info <- r[1, 1]
n <- nrow(r)

d <- r[4:n, ] |>
  setNames(c("name", "dir", "size", "date")) |> 
  mutate(path = paste0(dir, "\\", name) |> gsub("\\\\", "/", x = _))
d$path
# print("hello world")
