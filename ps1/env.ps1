$dotfilesPath = "$home\home\code\dotfiles"

$shell = $Host.UI.RawUI

$shell.BackgroundColor = "Black"
$shell.ForegroundColor = "White"

#fix git log and possibly other stuff
$env:term = "xterm"

$env:PSModulePath += ";$dotfilesPath\modules"

Import-Module PSReadLine

Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -MaximumHistoryCount 4000
Set-PSReadlineOption -BellStyle None
# history substring search
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab completion
Set-PSReadlineKeyHandler -Chord 'Shift+Tab' -Function MenuComplete
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key 'ctrl+d' -Function ViExit

Set-PSReadLineOption -Colors @{
  Command=[ConsoleColor]::Blue
  Comment="`e[32;3m"
  ContinuationPrompt=[ConsoleColor]::White
  Default=[ConsoleColor]::White
  Emphasis="`e[96;1m"
  Error=[ConsoleColor]::Red
  InlinePrediction="`e[97;3m"
  Keyword=[ConsoleColor]::Green
  ListPrediction=[ConsoleColor]::DarkYellow
  # https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
  ListPredictionSelected="`e[48;5;238m"
  # https://devblogs.microsoft.com/powershell/psreadline-2-3-1-beta1-release/
  ListPredictionTooltip="`e[97;3m"
  Member=[ConsoleColor]::Gray
  Number=[ConsoleColor]::White
  Operator=[ConsoleColor]::Yellow
  Parameter=[ConsoleColor]::Yellow
  Selection="`e[30;1;4;104m"
  String=[ConsoleColor]::DarkCyan
  Type=[ConsoleColor]::Gray
  Variable=[ConsoleColor]::Green
}

$PL = @{
  fire=[char]0xe0c0;
  lego=[char]0xe0ce;
  graph=[char]0xe0c8;
  digitize=[char]0xe0c6;
  triangle=[char]0xe0b0;
  round=[char]0xe0b4;
  hex=[char]0xe0cc;
  floating_ghost=[char]0xe007;
  git_char = [char]0xe0a0;
}

$env:Path+=";C:\Program Files (x86)\Steam"
foreach ($d in $(dir ~/bin)) {
    $env:Path+=";$d"
}

# vcpkg
$env:Path+=";C:\dev\bin\vcpkg"
$env:VCPKG_DEFAULT_TRIPLET="x64-windows"
$env:VCPKG_FEATURE_FLAGS="manifests,versions"
$env:VCPKG_DISABLE_METRICS=$True

# flutter
$env:Path+=";C:\dev\bin\flutter\bin"

# scripts
$env:Path+=";$dotfilesPath\scripts"

$env:VCPKG_ROOT="C:/dev/bin/vcpkg"

$env:CMAKE_PREFIX_PATH="$(Join-String -Separator ';' -InputObject $(dir C:/dev/lib))";
