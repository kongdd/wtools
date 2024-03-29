@time using Ipaper

function replace_over(x::AbstractString)
  s = "[^{}]*"
  p = Regex("{($s)[ ]*\\\\over[ ]*($s)}")
  # p = r"{([^{}]*)[ ]*\\over[ ]*([^{}]*)}" # r是为了保护\\
  replace(x,
    Regex(p) => s"\\frac{\1}{\2}")
end

function replace_over(xs::Vector{String})
  map(replace_over, xs)
end

function rm_image(lines)
  filter(l -> !contains(l, "images"), lines)
end

@show ARGS
fin = ARGS[1]
fout = @pipe fin |> gsub(_, ".md", "_fixed.md")
length(ARGS) >= 2 && (fout = ARGS[2])

lines = readlines(fin)
@pipe lines |> replace_over |> rm_image |> writelines(fout)

# for i in eachindex(lines)
#   x = lines[i]
#   if grepl(x, r"\\over")
#     x2 = replace_over(x)
#     # println(x2)
#     lines[i] = x2
#   end
# end
# writelines(lines, "ch4_01_out.md")

# function replace_part_over(x::AbstractString)
#   replace(x,
#     r"{\\partial (.*?)[ ]*\\over[ ]*\\partial (.*?)}" =>
#       s"\\frac{\\partial \1}{\\partial \2}")
# end
