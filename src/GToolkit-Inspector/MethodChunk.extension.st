Extension { #name : #MethodChunk }

{ #category : #'*GToolkit-Inspector' }
MethodChunk >> gtDisplayOn: stream [
	stream nextPutAll: self description
]
