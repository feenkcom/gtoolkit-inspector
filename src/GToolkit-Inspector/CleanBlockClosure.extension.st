Extension { #name : #CleanBlockClosure }

{ #category : #'*GToolkit-Inspector' }
CleanBlockClosure >> gtSizeInMemoryCountingLiteralsOnceIn: aSetOfLiterals [
	^ self sizeInMemory + (self compiledBlock gtSizeInMemoryCountingLiteralsOnceIn: aSetOfLiterals)

]

{ #category : #'*GToolkit-Inspector' }
CleanBlockClosure >> gtSpecificSizeInMemory [
	^ self sizeInMemory + self compiledBlock gtSpecificSizeInMemory
]

{ #category : #'*GToolkit-Inspector' }
CleanBlockClosure >> gtSpecificSizeInMemoryStringLiteralsOnly [
	^ self compiledBlock gtSpecificSizeInMemoryStringLiteralsOnly
]

{ #category : #'*GToolkit-Inspector' }
CleanBlockClosure >> gtStringLiteralsSizeInMemoryCountingOnceIn: aSetOfLiterals [
	^ self compiledBlock gtStringLiteralsSizeInMemoryCountingOnceIn: aSetOfLiterals

]
