Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
Set-Alias make ./make.ps1

function su()
{
    sudo powershell
}

function sudo($command) {
    Start-Process $command -Verb runAs
}

function which($command) {
    $(Get-Command $command).Source
}
