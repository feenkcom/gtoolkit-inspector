Extension { #name : #ZnClientIgnoringExceptionOnConnectionReuseEvent }

{ #category : #'*GToolkit-Inspector' }
ZnClientIgnoringExceptionOnConnectionReuseEvent >> gtDetails [
	^ super gtDetails ,
		{ {#exception . self exception} }
]
