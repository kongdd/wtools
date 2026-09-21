# pdf-delete input.pdf "1,2,3,4-7" [output.pdf]
if ($args.Count -notin 2, 3) { throw 'Usage: pdf-delete input.pdf "1,2,3,4-7" [output.pdf]' }
$file, $spec, $output = $args
$pageCount = [int]((pdftk $file dump_data | Select-String '^NumberOfPages:') -replace '\D')

$remove = @(foreach ($part in $spec -split ',') {
  if ($part -notmatch '^(\d+)(?:-(\d+))?$') { throw "Invalid range: $part" }
  $first = [int]$Matches[1]
  $last = if ($Matches[2]) { [int]$Matches[2] } else { $first }
  if ($last -lt $first) { throw "Invalid range: $part" }
  $first..$last
})
if ($remove.Where({ $_ -lt 1 -or $_ -gt $pageCount })) { throw "Page out of bounds (1-$pageCount)." }

$keep = @((1..$pageCount).Where({ $_ -notin $remove }))
if (-not $keep) { throw 'Cannot delete every page.' }

if (-not $output) { $output = $file }
$temp = "$output.$([guid]::NewGuid()).tmp"
pdftk $file cat $keep output $temp
if ($LASTEXITCODE) { Remove-Item $temp -ErrorAction Ignore; exit $LASTEXITCODE }
Move-Item $temp $output -Force
