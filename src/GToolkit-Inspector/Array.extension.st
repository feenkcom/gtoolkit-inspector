Extension { #name : #Array }

{ #category : #'*GToolkit-Inspector' }
Array >> gtLiteralArraySizeInMemory [
	^ self sizeInMemory + (self sumNumbers: [ :anObject |
		| objectSize |
		objectSize := 0.
		anObject class = Array ifTrue: [
			objectSize := anObject gtLiteralArraySizeInMemory ].
			
		(anObject class = ByteString or: [
			anObject class = WideString ]) 
				ifTrue: [
					objectSize := anObject sizeInMemory ].
		objectSize ])
]

{ #category : #'*GToolkit-Inspector' }
Array >> gtSpecificSizeInMemory [
	^ self sizeInMemory
]
