Extension { #name : #ZnServerLogEvent }

{ #category : #'*GToolkit-Inspector' }
ZnServerLogEvent >> gtDetails [
	^ super gtDetails ,
		{ {#serverId
			. self serverId ifNil: [ '' ] 
			. self serverId} }
]
