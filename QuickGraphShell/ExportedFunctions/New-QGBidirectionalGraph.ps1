function New-QGBidirectionalGraph {
	param(
		[System.Type]$VertexType,
		[System.Type]$EdgeType
	)
	$TypeString = $VertexType.FullName
	$EdgeTypeString = $EdgeType.FullName
	New-Object "QuickGraph.BidirectionalGraph``2[$TypeString, $EdgeTypeString]"
}
Export-ModuleMember -Function New-QGBidirectionalGraph