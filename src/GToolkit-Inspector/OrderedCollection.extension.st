Extension { #name : #OrderedCollection }

{ #category : #'*GToolkit-Inspector' }
OrderedCollection >> gtSpecificSizeInMemory [
	^ self sizeInMemory + array sizeInMemory
]
