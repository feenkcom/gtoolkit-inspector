Extension { #name : #ZnClientFollowingRedirectEvent }

{ #category : #'*GToolkit-Inspector' }
ZnClientFollowingRedirectEvent >> gtDetails [
	^ super gtDetails ,
		{ {#target . self target} }
]
