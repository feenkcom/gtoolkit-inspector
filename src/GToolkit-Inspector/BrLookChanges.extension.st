Extension { #name : 'BrLookChanges' }

{ #category : '*GToolkit-Inspector' }
BrLookChanges >> gtChangesFor: aView [
	<gtView>
	self changes ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Changes';
		object: [ self changes ];
		view: #gtItemsFor:
]
