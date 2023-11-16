Extension { #name : #ZnServerStoppedEvent }

{ #category : #'*GToolkit-Inspector' }
ZnServerStoppedEvent >> gtDetails [
	^ super gtDetails ,
		{ {#description . self description} }
]
