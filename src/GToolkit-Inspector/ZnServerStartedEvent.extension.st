Extension { #name : #ZnServerStartedEvent }

{ #category : #'*GToolkit-Inspector' }
ZnServerStartedEvent >> gtDetails [
	^ super gtDetails ,
		{ {#description . self description} }
]
