param(
    [switch]$WhatIf = $false
)

$dotfilesPath = "~/home/code/dotfiles"

function Stow {
    param(
        [string]$source,
        [string]$destination
    )
    $src = Resolve-Path -Path $source
    $dest = Resolve-Path -Path $destination

    Get-ChildItem -Path "${src}" -Recurse `
      | where { ! $_.PSIsContainer } `
      | foreach {
        $relativePath = $_.Directory.FullName.Substring($src.Path.Length + 1)
        $destinationDir = Join-Path -Path $dest -ChildPath $relativePath
        $destinationFile = Join-Path -Path $destinationDir -ChildPath $_.Name

        if (Test-Path -Path $destinationFile) {
          Remove-Item -Force $destinationFile -WhatIf:$WhatIf
        }
        New-Item -ItemType "directory" -Path $destinationDir -Force > $null
        New-Item -ItemType SymbolicLink -Target $_.FullName -Path $destinationFile -WhatIf:$WhatIf > $null
      }
}

# There has to be a reason this isn't a symlink...
cp "$dotfilesPath/Microsoft.PowerShell_profile.ps1" $profile -WhatIf:$WhatIf

Stow -source "${dotfilesPath}/AppData" -destination "~/AppData"
