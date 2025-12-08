Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Inspector' }
ClassDescription >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ self methodDict gtSpecificSizeInMemory
		+ self gtSpecificSizeInMemoryForProtocols
]

{ #category : #'*GToolkit-Inspector' }
ClassDescription >> gtSpecificSizeInMemoryForProtocols [
	^ self protocols gtSpecificSizeInMemory
				+ (self protocols sumNumbers: [ :aProtocol |
					aProtocol gtSpecificSizeInMemory ])
]
