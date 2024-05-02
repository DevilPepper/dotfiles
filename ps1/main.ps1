$dotfilesPath = "~/home/code/dotfiles"
. "$dotfilesPath/ps1/csharp-loader.ps1"

. "$dotfilesPath/ps1/env.ps1"
. "$dotfilesPath/ps1/prompt.ps1"
. "$dotfilesPath/ps1/cd.ps1"
# . "$dotfilesPath/ps1/wfh.ps1"
. "$dotfilesPath/ps1/alias.ps1"
. "$dotfilesPath/ps1/functions.ps1"

# . "$dotfilesPath/ps1/docker.ps1"

if (IsInteractive) {
    showMachineDetails
}
