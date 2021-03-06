function ConvertTo-GraphML {
	param(
		[Parameter(ValueFromPipeline=$true)]
		$Graph
	)
	process {
		$XmlWriter = [System.Xml.XmlWriter]::Create("c:\temp30\vmware.graphml")
		try {
			$VertexTypeString = $Graph.GetType().GenericTypeArguments[0].Fullname
			$EdgeTypeString = $Graph.GetType().GenericTypeArguments[1].Fullname
			$GraphTypeString = $Graph.GetType().Fullname
			$SerializeMethodDefintion = [QuickGraph.Serialization.GraphMLExtensions].GetMethods() | ?{$_.Name -eq "SerializeToGraphML" -and $_.GetParameters().Count -eq 2}
			$SerializeMethod = $SerializeMethodDefintion.MakeGenericMethod( $VertexTypeString, $EdgeTypeString, $GraphTypeString )
			$SerializeMethod.Invoke([QuickGraph.Serialization.GraphMLExtensions], @($Graph.PSObject.BaseObject, $XmlWriter))
		} finally {
			if($XmlWriter) {
				$XmlWriter.Dispose()
			}
		}
	}
}
Export-ModuleMember -Function ConvertTo-GraphML