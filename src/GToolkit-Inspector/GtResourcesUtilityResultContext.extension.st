Extension { #name : #GtResourcesUtilityResultContext }

{ #category : #'*GToolkit-Inspector' }
GtResourcesUtilityResultContext >> gtLocationFor: aView [
	<gtView>
	self location ifNil: [ ^ aView empty ].
	^ (self location gtLocationFor: aView)
		priority: 2;
		title: 'Searched Location'
]

{ #category : #'*GToolkit-Inspector' }
GtResourcesUtilityResultContext >> gtPathFor: aView [
	<gtView>
	self result ifNil: [ ^ aView empty ].
	^ (self result gtPathFor: aView)
		priority: 1
]
