param(
    [switch]$WhatIf = $false
)

. "$PSScriptRoot\ps1\functions.ps1"

$xdgConfig = Force-Resolve-Path -Path "~/.config"
$xdgData = Force-Resolve-Path -Path "~/.local/share"
$winConfig = Force-Resolve-Path -Path "~/AppData/Local"

$dotfilesPath = "$PSScriptRoot"
$ogDotfilesPath = Force-Resolve-Path -Path "${winConfig}/dotfiles"

$com = New-Object -ComObject Shell.Application

function main {
  # There has to be a reason this isn't a symlink...
  cp "$dotfilesPath/Microsoft.PowerShell_profile.ps1" $profile -WhatIf:$WhatIf

  Get-ChildItem -Path "${dotfilesPath}/ini/desktop" | foreach { Set-FolderInfo -ini $_.FullName }
  Fix-QuickAccess

  Git-Clone -repo "https://github.com/DevilPepper/dotfiles.git" -destination "$ogDotfilesPath"
  Git-Clone -repo "https://github.com/DevilPepper/nvim-plugins.git" -destination "${winConfig}/nvim-data/site/pack" -recurse

  Get-ChildItem -Path "${dotfilesPath}/reg" | where { ! $_.PSIsContainer } | foreach { Reg-Edit -reg $_.FullName }

  Stow -source "${dotfilesPath}/AppData" -destination "~/AppData"
  Stow -source "${dotfilesPath}/.config" -destination "${xdgConfig}"

  Stow -source "${ogDotfilesPath}/ascii/.local/share" -destination "${xdgData}"
  Stow -source "${ogDotfilesPath}/darktable/.config" -destination "${winConfig}"
  Stow -source "${ogDotfilesPath}/git/.config" -destination "${xdgConfig}"
  Stow -source "${ogDotfilesPath}/nvim/.config" -destination "${winConfig}"
  Stow -source "${ogDotfilesPath}/starship/.config" -destination "${xdgConfig}"

  # Stupid defaults give us dirty worktree.
  # Pretty destructive workaround... Shouldn't be touching this directory anyway
  Git-Restore -destination "${ogDotfilesPath}"
  Git-Restore -destination "${winConfig}/nvim-data/site/pack" -recurse
}

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
    $relativePath = $null
    if ($_.Directory.FullName.Length -ne $src.Path.Length) {
      $relativePath = $_.Directory.FullName.Substring($src.Path.Length + 1)
    }
    $destinationDir = Join-Path -Path $dest -ChildPath $relativePath
    $destinationFile = Join-Path -Path $destinationDir -ChildPath $_.Name

    if (Test-Path -Path $destinationFile) {
      Remove-Item -Force $destinationFile -WhatIf:$WhatIf
    }
    New-Item -ItemType "directory" -Path $destinationDir -ErrorAction SilentlyContinue -WhatIf:$WhatIf > $null
    New-Item -ItemType SymbolicLink -Target $_.FullName -Path $destinationFile -WhatIf:$WhatIf > $null
  }
}

function Git-Clone {
  param(
    [string]$repo,
    [string]$destination,
    [switch]$recurse = $false
  )
  $dest = Force-Resolve-Path -Path $destination

  if (Test-Path -Path $dest) {
    if ($WhatIf) {
      echo "What if: git -C ${dest} pull"
      if ($recurse) {
        echo "What if: git -C ${dest} submodule update --init --recursive"
      }
    } else {
      git -C "${dest}" pull
      if ($recurse) {
        git -C "${dest}" submodule update --init --recursive
      }
    }
  } else {
    if ($WhatIf) {
      $flags = ""
      if ($recurse) {
        $flags = "--recurse-submodules -j8"
      }
      echo "What if: git clone ${flags} ${repo} ${dest}"
    } else {
      if ($recurse) {
        git clone --recurse-submodules -j8 "${repo}" "${dest}"
      } else {
        git clone "${repo}" "${dest}"
      }
    }
  }
}

function Git-Restore {
  param(
    [string]$destination,
    [switch]$recurse = $false
  )
  $dest = Force-Resolve-Path -Path $destination
  
  git -C "${dest}" restore .
  if ($recurse) {
    git -C "${dest}" submodule foreach --recursive git restore .
  }
}

function Reg-Edit {
  param(
    [string]$reg
  )
  if ($WhatIf) {
    echo "What if: reg import ${reg}"
  } else {
    reg import "${reg}"
  }
}

function Set-FolderInfo {
  param(
    [string]$ini
  )
  $dest = (Get-Content $ini -First 1).SubString(2)
  $dest = Force-Resolve-Path -Path "${dest}"

  New-Item -ItemType "directory" -Path $dest -ErrorAction SilentlyContinue -WhatIf:$WhatIf > $null
  Remove-Item "${dest}/desktop.ini" -Force -WhatIf:$WhatIf
  Copy-Item $ini -Destination "${dest}/desktop.ini" -WhatIf:$WhatIf
  Set-ItemProperty "${dest}/desktop.ini" -Name Attributes -Value "Archive,System,Hidden" -WhatIf:$WhatIf
  Set-ItemProperty "${dest}" -Name Attributes -Value "ReadOnly" -WhatIf:$WhatIf
}

function Fix-QuickAccess {
  $folderPins = @(
    "~\home"
    "~\AppData"
    "~\Downloads"
    "~\home\Documents"
    "~\Pictures"
    "~\Music"
    "~\Videos"
    "C:\Program Files (x86)\Steam\steamapps\Steam"
  ) | foreach { (Force-Resolve-Path -Path $_).Path }

  if ($WhatIf) {
    echo "WhatIf: Pinning like this:"
    echo "📌 This PC"
    $folderPins | foreach { echo "📌 $_" }
    echo "📌 Linux"
    echo "📌 Network"
  } else {
    $com.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}").Items() | foreach { $_.InvokeVerb("unpinfromhome") }

    # "": Desktop
    # "\\wsl.localhost": Linux
    # 0x12: Network
    # For more: https://learn.microsoft.com/en-us/windows/win32/api/shldisp/ne-shldisp-shellspecialfolderconstants
    $namespaces = @("") `
      + $folderPins `
      + @(
          "\\wsl.localhost",
          0x12
        )

    $namespaces | foreach { $com.Namespace($_).Self.InvokeVerb("pintohome") }
  }
}

main
