Extension { #name : 'UUID' }

{ #category : '*GToolkit-Inspector' }
UUID >> gtByteAssociationsFor: aDisplayedBytes [
	^ (super gtByteAssociationsFor: aDisplayedBytes)
		copyWith: ('string36' -> self asString36)
]
