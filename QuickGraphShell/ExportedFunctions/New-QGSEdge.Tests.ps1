$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

Describe "New-QGSEdge" {
	Mock "Export-ModuleMember" -ParameterFilter { $Function -eq "New-QGSEdge" } -Verifiable
	Add-Type -Path (Join-Path (Split-Path $here -Parent) "QuickGraph\QuickGraph.dll")
  . "$here\$sut"
	
	context "when imported" {
		It "calls Export-ModuleMember" {
			Assert-VerifiableMocks
		}
	}
	
	context "Source and Target are specified" {
		It "Throws when the types don't match" {
			{
				New-QGSEdge -Source 15 -Target "string"
			} | Should Throw
		}
		
		It "Creates a SEdge" {
			$Edge = New-QGSEdge -Source "S" -Target "T"
			$Edge | Should Not Be $null
			$Edge.Source | Should Be "S"
			$Edge.Target | Should Be "T"
		}
	}
}