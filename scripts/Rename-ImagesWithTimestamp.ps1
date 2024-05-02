Write-Host -ForegroundColor yellow "Renaming the following files:"
Get-ChildItem | Where-Object { $_.Name -match '\.(jpg|arw)$' } | Select -ExpandProperty Name
Write-Host -ForegroundColor yellow "Renaming files in directory:"
Get-Location | Select -ExpandProperty Path
$confirm = Read-Host "Do you want to proceed? (Y/N)"

if ($confirm.ToLower() -eq 'y') {
  Get-ChildItem | Where-Object { $_.Name -match '\.(jpg|arw)$' } | foreach {
    $ImagePath = $_.Name
    $imgpath = Resolve-Path -Path $ImagePath

    $dateTimeOriginal = Get-ImageMetaData -ImagePath "$imgpath" -Flatten `
      | Where-Object { $_.Tag -eq 'Composite:SubSecDateTimeOriginal' } `
      | Select -ExpandProperty Value
    $dt = [datetime]::ParseExact($dateTimeOriginal, "yyyy:MM:dd HH:mm:ss.fffK", $null)
    $dt_utc = $dt.ToUniversalTime()
    $iso8601 = $dt_utc.ToString("yyyy-MM-ddTHH.mm.ss.fffZ")

    $directory = Split-Path -Path $imgpath -Parent
    $fileName = Split-Path -Path $imgpath -Leaf
    $ext = [System.IO.Path]::GetExtension($fileName).Substring(1).ToLower()
    $prefix = if ($fileName -match '(.*[a-zA-Z])[0-9]+\.[a-zA-Z]+' -or $fileName -match '(.*[a-zA-Z])_.*') { $matches[1] } else { "IMG" }

    $newFileName = "${prefix}_${iso8601}.${ext}"
    $newFilePath = Join-Path -Path $directory -ChildPath $newFileName

    if ($ImagePath -ne $newFileName) {
      echo "$ImagePath -> $newFileName"
      Rename-Item -Path "$imgpath" -NewName "$newFilePath"
    }
  }
}
