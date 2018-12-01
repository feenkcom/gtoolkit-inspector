Extension { #name : #Context }

{ #category : #'*GToolkit-Inspector' }
Context >> gtSourceFor: aView [
	<gtView>
	self method ifNil: [ ^ aView empty ].
	^ self method gtSourceFor: aView
]
