Extension { #name : #TraitedMetaclass }

{ #category : #'*GToolkit-Inspector' }
TraitedMetaclass >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ self baseLocalMethods gtSpecificSizeInMemory 
		+ self localMethodDict gtSpecificSizeInMemory
]
