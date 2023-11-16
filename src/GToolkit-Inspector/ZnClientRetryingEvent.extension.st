Extension { #name : #ZnClientRetryingEvent }

{ #category : #'*GToolkit-Inspector' }
ZnClientRetryingEvent >> gtDetails [
	^ super gtDetails ,
		{ {#exception . self exception} }
]
