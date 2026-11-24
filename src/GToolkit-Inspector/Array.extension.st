Extension { #name : #Array }

{ #category : #'*GToolkit-Inspector' }
Array >> gtLiteralArraySizeInMemory [
	^ self sizeInMemory
		+ (self sumNumbers: [ :anObject | CompiledCode gtSizeInMemoryOfLiteral: anObject ])
]

{ #category : #'*GToolkit-Inspector' }
Array >> gtLiteralArraySizeInMemoryCountingOnceIn: aSetOfLiterals [
	^ self sizeInMemory
		+ (self sumNumbers: [ :anObject | CompiledCode gtSizeInMemoryOfLiteral: anObject countingOnceIn: aSetOfLiterals ])

]

{ #category : #'*GToolkit-Inspector' }
Array >> gtSpecificSizeInMemory [
	^ self sizeInMemory
]

{ #category : #'*GToolkit-Inspector' }
Array >> gtStringLiteralsOnlySizeInMemory [
	^ (self sumNumbers: [ :anObject |
		| objectSize |
		objectSize := 0.
		anObject class = Array ifTrue: [
			objectSize := anObject gtStringLiteralsOnlySizeInMemory ].
	
		(anObject class = ByteString or: [
			anObject class = WideString ]) 
				ifTrue: [
					objectSize := anObject sizeInMemory ].
		objectSize ])
]
