Extension { #name : #MetaclassForTraits }

{ #category : #'*GToolkit-Inspector' }
MetaclassForTraits >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory + ((users
		ifNil: [ 0 ] 
		ifNotNil: [ users sizeInMemory ] )) 
]
