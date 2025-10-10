Extension { #name : #SystemDictionary }

{ #category : #'*GToolkit-Inspector' }
SystemDictionary >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ cachedClassNames gtSpecificSizeInMemory 
		+ cachedNonClassNames gtSpecificSizeInMemory
		+ cachedBehaviors gtSpecificSizeInMemory
		+ (self 
			forPharo12AndNewer: [
				self pseudoVariables gtSpecificSizeInMemory ] 
			forPharo11: [
				self reservedVariables gtSpecificSizeInMemory])
]
