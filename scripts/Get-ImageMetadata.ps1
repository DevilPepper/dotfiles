# Add-Type -AssemblyName System.Drawing

param(
    [Parameter(Position=0)]
    [string]$ImagePath,

    [switch]$Flatten = $false
)

$imgpath = Resolve-Path -Path $ImagePath
# $image = [System.Drawing.Image]::FromFile($imgpath)
$props = @{}

# Run exiftool with the -S flag for very short output format
$output = & exiftool -G -S "$imgpath"

$metadata = @{}

foreach ($line in $output) {
    if ($line -match '^\[(.*?)\] (.*?): (.*)') {
        $group = $matches[1]
        $tag = $matches[2]
        $value = $matches[3]

        if ($Flatten) {
          $metadata["${group}:${tag}"] = $value
        } else {
          if (-not $metadata.ContainsKey($group)) {
              $metadata[$group] = @{}
          }
          $metadata[$group][$tag] = $value
        }
    }
}

$metadataObject = New-Object PSCustomObject
$metadataList = New-Object System.Collections.Generic.List[object]
foreach ($group in $metadata.Keys) {
  if ($Flatten) {
    $metadataList.Add([PSCustomObject]@{
      Tag = $group
      Value = $metadata[$group]
    })
    Add-Member -InputObject $metadataObject -MemberType NoteProperty -Name $group -Value $metadata[$group]
  } else {
    $groupList = New-Object System.Collections.Generic.List[object]
    $groupObject = New-Object PSCustomObject
    foreach ($tag in $metadata[$group].Keys) {
        $groupList.Add([PSCustomObject]@{
          Tag = $tag
          Value = $metadata[$group][$tag]
        })
        Add-Member -InputObject $groupObject -MemberType NoteProperty -Name $tag -Value $metadata[$group][$tag]
    }
    $metadataList.Add([PSCustomObject]@{
      TagGroup = $group
      Value = $groupList
    })
    Add-Member -InputObject $metadataObject -MemberType NoteProperty -Name $group -Value $groupObject
  }
}

# Return a PSObject with the properties
# return $metadataObject
return $metadataList
# New-Object PSObject -Property $props

# Example usage:
# $metadata = Get-ImageMetadata -ImagePath "C:\path\to\your\image.jpg"
# $metadata | Select-Object "PropertyID36867"
