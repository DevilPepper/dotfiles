function togglePowerline() {
    # xor doesn't work and if(!$var) isn't enough
    if($env:supports_powerline -eq $False) {
        $env:supports_powerline = $True
    } else {
        $env:supports_powerline = $False
    }
    # $env:supports_powerline = $env:supports_powerline -xor 1
    [Environment]::SetEnvironmentVariable("supports_powerline", $env:supports_powerline, [System.EnvironmentVariableTarget]::User)
}

# Enters Developer Powershell provided by Visual Studio
function dev() {
    $MSVS = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"
    Import-Module $MSVS\Common7\Tools\Microsoft.VisualStudio.DevShell.dll
    Enter-VsDevShell -SkipAutomaticLocation -SetDefaultWindowTitle -DevCmdArguments '-arch=x64' -InstallPath $MSVS
}

function dev32() {
    $MSVS = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"
    Import-Module $MSVS\Common7\Tools\Microsoft.VisualStudio.DevShell.dll
    Enter-VsDevShell -SkipAutomaticLocation -SetDefaultWindowTitle -DevCmdArguments '-arch=x86' -InstallPath $MSVS
}

function showMachineDetails() {
    [regex]$ms_pattern = "\s*Microsoft\s*"
    $win_os = $ms_pattern.replace($(Get-CimInstance Win32_OperatingSystem).Caption, "", 1)
    $win_version = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ReleaseId).ReleaseId
    $win_build = [System.Environment]::OSVersion.Version.Build

    Write-Host "$win_os | $win_version | $win_build | $env:username@$env:computername" -ForegroundColor Gray
    Write-Host "" -ForegroundColor White
}

function IsInteractive {
    $non_interactive = '-command', '-c', '-encodedcommand', '-e', '-ec', '-file', '-f', '-NonInteractive', '-noni'
    -not ([Environment]::GetCommandLineArgs() | Where-Object -FilterScript {$PSItem -in $non_interactive})
}
