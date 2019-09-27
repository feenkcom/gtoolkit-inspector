Extension { #name : #BlShortcut }

{ #category : #'*GToolkit-Inspector' }
BlShortcut >> gtViewSourceCodeFor: aView [
	<gtView>
	^ self action 
		ifNil: [ aView ]
		ifNotNil: [ self action gtSourceCodeFor: aView ]
]
