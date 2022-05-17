Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Inspector' }
ClassDescription >> gtSpecificSizeInMemory [
	^ self sizeInMemory + self methodDict gtSpecificSizeInMemory
]
