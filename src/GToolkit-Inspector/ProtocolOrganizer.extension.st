Extension { #name : #ProtocolOrganizer }

{ #category : #'*GToolkit-Inspector' }
ProtocolOrganizer >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ allProtocol sizeInMemory 
		+ (allProtocol instVarNamed: #methodSelectors) gtSpecificSizeInMemory
		+ protocols gtSpecificSizeInMemory
		+ (protocols sum: [ :aProtocol |
			aProtocol sizeInMemory 
				+ aProtocol methodSelectors gtSpecificSizeInMemory ])
]
