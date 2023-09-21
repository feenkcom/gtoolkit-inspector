Extension { #name : #SystemDictionary }

{ #category : #'*GToolkit-Inspector' }
SystemDictionary >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ cachedClassNames gtSpecificSizeInMemory 
		+ cachedNonClassNames gtSpecificSizeInMemory
		+ cachedBehaviors gtSpecificSizeInMemory
		+ reservedVariables gtSpecificSizeInMemory
]
