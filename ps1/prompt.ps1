function Invoke-Starship-PreCommand {
  $fg = "Black"
  # Doesn't work
  if (!$?) {
    $fg = "Red"
  }

  $hr = "_" * $Host.UI.RawUI.WindowSize.Width
  Write-Host "$hr" -ForegroundColor $fg
}

Invoke-Expression (&starship init powershell)
