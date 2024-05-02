function Load-CSharp($sourcePath)
{
	$source = (Get-Content -Path $sourcePath) -join "`n"
	Add-type -TypeDefinition $source
}
