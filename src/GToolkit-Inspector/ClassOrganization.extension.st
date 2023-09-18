Extension { #name : #ClassOrganization }

{ #category : #'*GToolkit-Inspector' }
ClassOrganization >> gtSpecificSizeInMemory [
	^ self sizeInMemory  
		+ protocolOrganizer gtSpecificSizeInMemory
]
