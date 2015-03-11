function New-QGSUndirectedEdge {
	param(
		$Source,
		$Target,
		[System.Type]$VertexType
	)
	$TypeString = $VertexType.FullName
	New-Object "QuickGraph.SUndirectedEdge``1[$TypeString]" -ArgumentList $Source, $Target
}
Export-ModuleMember -Function New-QGSUndirectedEdge