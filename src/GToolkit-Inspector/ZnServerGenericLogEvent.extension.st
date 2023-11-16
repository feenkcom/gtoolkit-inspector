Extension { #name : #ZnServerGenericLogEvent }

{ #category : #'*GToolkit-Inspector' }
ZnServerGenericLogEvent >> gtDetails [
	^ super gtDetails ,
		{ {#subject . self subject} }
]
