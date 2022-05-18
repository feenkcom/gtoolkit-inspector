Extension { #name : #Array }

{ #category : #'*GToolkit-Inspector' }
Array >> gtLiteralArraySizeInMemory [
	^ self sizeInMemory + (self sum: [ :anObject |
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
