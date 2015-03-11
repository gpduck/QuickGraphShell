$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

Describe "ConvertTo-GraphML" {
	Mock "Export-ModuleMember" -ParameterFilter { $Function -eq "ConvertTo-GraphML" } -Verifiable
	Add-Type -Path (Join-Path (Split-Path $here -Parent) "QuickGraph\QuickGraph.dll")
  . "$here\$sut"
	
	context "when imported" {
		It "calls Export-ModuleMember" {
			Assert-VerifiableMocks
		}
	}
}
