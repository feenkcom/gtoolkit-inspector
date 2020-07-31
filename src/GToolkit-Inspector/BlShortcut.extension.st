Extension { #name : #BlShortcut }

{ #category : #'*GToolkit-Inspector' }
BlShortcut >> gtViewSourceCodeFor: aView [
	<gtView>
	^ self action 
		ifNil: [ aView empty ]
		ifNotNil: [ self action gtSourceCodeFor: aView ]
]
