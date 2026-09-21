# pdf-reorder input.pdf "4,5,6" "6,5,4" [output.pdf]
if ($args.Count -notin 3, 4) { throw 'Usage: pdf-reorder input.pdf "4,5,6" "6,5,4" [output.pdf]' }
$file, $from, $to, $output = $args
$from = [int[]]($from.Trim('[]') -split ',')
$to = [int[]]($to.Trim('[]') -split ',')

if ($from.Count -ne $to.Count -or
    @($from | Sort-Object -Unique).Count -ne $from.Count -or
    (Compare-Object $from $to)) {
  throw 'Page lists must contain the same unique pages.'
}

$pageCount = [int]((pdftk $file dump_data | Select-String '^NumberOfPages:') -replace '\D')
if ($from.Where({ $_ -lt 1 -or $_ -gt $pageCount })) { throw "Page out of bounds (1-$pageCount)." }

$order = @(1..$pageCount)
for ($i = 0; $i -lt $from.Count; $i++) { $order[$from[$i] - 1] = $to[$i] }

if (-not $output) { $output = $file }
$temp = "$output.$([guid]::NewGuid()).tmp"
pdftk $file cat $order output $temp
if ($LASTEXITCODE) { Remove-Item $temp -ErrorAction Ignore; exit $LASTEXITCODE }
Move-Item $temp $output -Force
