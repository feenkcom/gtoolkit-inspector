Extension { #name : 'GtResourcesUtilityLocationResult' }

{ #category : '*GToolkit-Inspector' }
GtResourcesUtilityLocationResult >> gtPathFor: aView [
	<gtView>
	self file ifNil: [ ^ aView empty ].
	^ (self file gtPathFor: aView)
		title: 'Path'
]
