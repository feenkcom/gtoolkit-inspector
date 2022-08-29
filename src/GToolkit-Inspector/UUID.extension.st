Extension { #name : #UUID }

{ #category : #'*GToolkit-Inspector' }
UUID >> gtByteAssociationsFor: aDisplayedBytes [
	^ ((super gtByteAssociationsFor: aDisplayedBytes)
		copyWith: 'string' -> self asString) 
		copyWith: 'string36' -> self asString36
]
