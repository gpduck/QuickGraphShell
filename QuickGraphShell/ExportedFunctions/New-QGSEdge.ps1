

function New-QGSEdge {
	param(
		$Source,
		$Target
	)
	if($Source.GetType().FullName -ne $Target.GetType().FullName) {
		throw (New-Object System.ArgumentException("Source and Target types must match"))
	}
	$TypeString = $Source.GetType().FullName
	New-Object "QuickGraph.SEdge``1[$TypeString]" -ArgumentList $Source, $Target
}
Export-ModuleMember -Function New-QGSEdge