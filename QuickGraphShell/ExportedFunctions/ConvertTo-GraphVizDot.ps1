<#

.PARAMETER VertexFormatDelegate
	A script block to execute for each vertex to set custom formatting properties.
	
	
.EXAMPLE
	$VertexFormatDelegate = {
		$VertexFormatter.Label = $Vertex.Name
		$VertexFormatter.Shape = "Rectangle"
	}
	
	ConvertTo-GraphVizDot -Graph $g -VertexFormatDelegate $VertexFormatDelegate
#>
function ConvertTo-GraphVizDot {
	param(
		[Parameter(ValueFromPipeline=$true)]
		$Graph,
		[System.Management.Automation.ScriptBlock]$VertexFormatDelegate,
		[System.Management.Automation.ScriptBlock]$EdgeFormatDelegate
	)
	process {
		$VertexTypeString = $Graph.GetType().GenericTypeArguments[0].Fullname
		$EdgeTypeString = $Graph.GetType().GenericTypeArguments[1].Fullname
		$GVA = New-Object "QuickGraph.Graphviz.GraphvizAlgorithm``2[$VertexTypeString, $EdgeTypeString]" -ArgumentList $Graph
		$Delegates = @()
		if($VertexFormatDelegate) {
			$VertexFormatHandler = $VertexFormatDelegate -as "QuickGraph.Graphviz.FormatVertexEventHandler[$VertexTypeString]"
			if($VertexFormatHandler) {
				$GVA.add_FormatVertex($VertexFormatHandler)
			}
			#$Delegates += Register-ObjectEvent -InputObject $GVA -Action $VertexFormatDelegate -EventName FormatVertex
		}
		if($EdgeFormatDelegate) {
			$Delegates += Register-ObjectEvent -InputObject $GVA -Action $EdgeFormatDelegate -EventName FormatEdge
		}
		$GVA.Generate()
		$Delegates | %{
			Unregister-Event -SubscriptionId $_.Id
		}
	}
}
Export-ModuleMember -Function ConvertTo-GraphVizDot