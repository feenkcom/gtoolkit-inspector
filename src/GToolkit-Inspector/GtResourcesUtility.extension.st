Extension { #name : #GtResourcesUtility }

{ #category : #'*GToolkit-Inspector' }
GtResourcesUtility >> gtLocationsFor: aView [
	<gtView>
	self locations ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Locations';
		items: [ self locations ]
]
