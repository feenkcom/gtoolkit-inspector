Extension { #name : #ZnServerErrorEvent }

{ #category : #'*GToolkit-Inspector' }
ZnServerErrorEvent >> gtDetails [
	^ super gtDetails ,
		{ {#exception . self exception} }
]
