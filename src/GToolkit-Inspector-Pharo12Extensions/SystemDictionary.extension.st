Extension { #name : #SystemDictionary }

{ #category : #'*GToolkit-Inspector-Pharo12Extensions' }
SystemDictionary >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ cachedClassNames gtSpecificSizeInMemory 
		+ cachedNonClassNames gtSpecificSizeInMemory
		+ cachedBehaviors gtSpecificSizeInMemory
		+ self pseudoVariables gtSpecificSizeInMemory 
]
