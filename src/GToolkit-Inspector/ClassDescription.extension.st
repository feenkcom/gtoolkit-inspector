Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Inspector' }
ClassDescription >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ self methodDict gtSpecificSizeInMemory
		+ ((organization ifNil: [ 0 ] ifNotNil: [ organization gtSpecificSizeInMemory ]))
]
