# $root = "$PSScriptRoot/../src"
$files = $args[0..($args.Length - 2)]
$outfile = $args[-1]

# pdftk.exe $root/e.R $args
pdftk $files cat output $outfile
