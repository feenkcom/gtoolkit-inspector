Extension { #name : #ProtocolOrganizer }

{ #category : #'*GToolkit-Inspector' }
ProtocolOrganizer >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ allProtocol sizeInMemory 
		+ protocols gtSpecificSizeInMemory
		+ (protocols sumNumbers: [ :aProtocol |
			aProtocol sizeInMemory 
				+ aProtocol methodSelectors gtSpecificSizeInMemory ])
]
