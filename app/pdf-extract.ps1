# $root = "$PSScriptRoot/../src"
$infile = $args[0]
$pages = $args[1]
$outfile = $args[-1]

# pdftk.exe $root/e.R $args
pdftk $infile cat $pages output $outfile
