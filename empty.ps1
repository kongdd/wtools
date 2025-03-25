$recycleBin = (New-Object -ComObject Shell.Application).NameSpace(0xA)
$items = $recycleBin.Items()
$totalItems = $items.Count
Write-Host "Found $totalItems items in the Recycle Bin."

if ($totalItems -gt 0) {
    $count = 0
    foreach ($item in $items) {
        $count++
        Write-Host "Deleting item $count of $totalItems: $($item.Name)"
        $recycleBin.InvokeVerb("Delete")
    }
    Write-Host "Recycle Bin emptied successfully."
} else {
    Write-Host "Recycle Bin is already empty."
}
