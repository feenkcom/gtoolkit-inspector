Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtSourceCodeFor: aView [
	<gtView>
	^ self sourceNode gtSourceCodeFor: aView
]
