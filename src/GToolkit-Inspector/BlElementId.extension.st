Extension { #name : #BlElementId }

{ #category : #'*GToolkit-Inspector' }
BlElementId >> asBlocElementCode [
	<return: #String>
	^ self asSymbol printString
]
