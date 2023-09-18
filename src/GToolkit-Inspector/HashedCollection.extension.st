Extension { #name : #HashedCollection }

{ #category : #'*GToolkit-Inspector' }
HashedCollection >> gtSpecificSizeInMemory [
	^ self sizeInMemory + array  sizeInMemory 
]
