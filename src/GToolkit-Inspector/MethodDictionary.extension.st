Extension { #name : #MethodDictionary }

{ #category : #'*GToolkit-Inspector' }
MethodDictionary >> gtSpecificSizeInMemory [ 
	^ self sizeInMemory + array sizeInMemory 
]
