Extension { #name : #ZnClientLogEvent }

{ #category : #'*GToolkit-Inspector' }
ZnClientLogEvent >> gtDetails [
	^ super gtDetails ,
		{ {#clientId
			. self clientId ifNil: [ '' ] 
			. self clientId} }
]
