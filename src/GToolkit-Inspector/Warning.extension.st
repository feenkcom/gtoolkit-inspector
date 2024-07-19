Extension { #name : #Warning }

{ #category : #'*GToolkit-Inspector' }
Warning >> gtMessageTextFor: aView [
	<gtView>
	<gtExceptionView>
	<gtEmbeddedDebuggerView>
	^ super gtMessageTextFor: aView
]
