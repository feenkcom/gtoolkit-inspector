Extension { #name : #Protocol }

{ #category : #'*GToolkit-Inspector' }
Protocol >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ self methodSelectors gtSpecificSizeInMemory
]
