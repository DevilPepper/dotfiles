function prompt {
	if($env:supports_powerline -eq $True) {
		Write-Host "$($PL.digitize) " -NoNewLine -ForegroundColor DarkBlue
	} else {
	  Write-Host "✗" -NoNewLine -ForegroundColor DarkGreen
	}
	Write-Host `a -NoNewLine -ForegroundColor White

	return " "
}
