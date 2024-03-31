using Ipaper

file_ext(f::AbstractString) = splitext(f)[2][2:end]

function build_app(f)
  apps = Dict("jl" => "julia", "R" => "Rscript")
  name = basename(f)
  ext = file_ext(f)
  app = apps[ext]

  src = """
  \$root = "\$PSScriptRoot/../src"
  $app \$root/$name \$args
  """

  pattern = Regex("\\.$ext\$")
  app = gsub("app/$name", pattern, ".ps1")

  writelines([src], app; eof="")
end

fs = dir("src/")
build_app.(fs)
