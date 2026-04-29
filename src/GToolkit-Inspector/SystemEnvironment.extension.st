Extension { #name : #SystemEnvironment }

{ #category : #'*GToolkit-Inspector' }
SystemEnvironment >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ cachedClassNames gtSpecificSizeInMemory 
		+ cachedNonClassNames gtSpecificSizeInMemory
		+ cachedBehaviors gtSpecificSizeInMemory
		+ self pseudoVariables gtSpecificSizeInMemory
]
