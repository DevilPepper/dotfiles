param(
    [switch]$WhatIf = $false
)

. "$PSScriptRoot\ps1\functions.ps1"

$dotfilesPath = "$PSScriptRoot"
$ogDotfilesPath = Force-Resolve-Path -Path "~/AppData/LocalLow/dotfiles"
$xdgConfig = Force-Resolve-Path -Path "~/.config"

function Stow {
    param(
        [string]$source,
        [string]$destination
    )
    $src = Force-Resolve-Path -Path $source
    $dest = Force-Resolve-Path -Path $destination

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

if (Test-Path -Path $ogDotfilesPath) {
  if ($WhatIf) {
    echo "What if: git -C $ogDotfilesPath pull"
  } else {
    git -C "$ogDotfilesPath" pull
  }
} else {
  if ($WhatIf) {
    echo "What if: git clone https://github.com/DevilPepper/dotfiles.git ${ogDotfilesPath}"
  } else {
    git clone https://github.com/DevilPepper/dotfiles.git "$ogDotfilesPath"
  }
}

Get-ChildItem -Path "${dotfilesPath}/reg" | foreach {
  $reg = $_.FullName
  if ($WhatIf) {
    echo "What if: reg import ${reg}"
  } else {
    reg import "${reg}"
  }
}

Stow -source "${dotfilesPath}/AppData" -destination "~/AppData"
Stow -source "${dotfilesPath}/.config" -destination "$xdgConfig"

Stow -source "${ogDotfilesPath}/git/.config" -destination "$xdgConfig"

# Stupid defaults give us dirty worktree.
# Pretty destructive workaround... Shouldn't be touching this directory anyway
git -C "$ogDotfilesPath" restore .
