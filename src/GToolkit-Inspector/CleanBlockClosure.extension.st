Extension { #name : #CleanBlockClosure }

{ #category : #'*GToolkit-Inspector' }
CleanBlockClosure >> gtSpecificSizeInMemory [
	^ self sizeInMemory + self compiledBlock gtSpecificSizeInMemory
]

{ #category : #'*GToolkit-Inspector' }
CleanBlockClosure >> gtSpecificSizeInMemoryStringLiteralsOnly [
	^ self compiledBlock gtSpecificSizeInMemoryStringLiteralsOnly
]
