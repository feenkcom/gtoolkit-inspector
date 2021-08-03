Extension { #name : 'BlShortcutWithAction' }

{ #category : '*GToolkit-Inspector' }
BlShortcutWithAction >> gtSourceCodeFor: aView [
	<gtView>

	^ self action 
		ifNil: [ aView empty ]
		ifNotNil: [ self action gtSourceCodeFor: aView ]
]
