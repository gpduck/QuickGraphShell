$Script:ModuleRoot = $PSScriptRoot

dir $Script:ModuleRoot\ExportedFunctions\*.ps1 -Exclude "*.Tests.ps1" | %{
	. $_.fullname
}
