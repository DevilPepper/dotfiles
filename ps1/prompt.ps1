function Invoke-Starship-PreCommand {
  $fg = "Black"
  # Doesn't work
  if (!$?) {
    $fg = "Red"
  }

  $hr = "_" * $Host.UI.RawUI.WindowSize.Width
  Write-Host "$hr" -NoNewLine -ForegroundColor $fg
	Write-Host `a -NoNewLine -ForegroundColor White
}

Invoke-Expression (&starship init powershell)
