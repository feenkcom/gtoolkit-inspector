Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtSourceCodeFor: aView [
	<gtView>
	^ self sourceNode gtSourceCodeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtVariablesFor: aView [
	<gtView>
	self outerContext ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Variables';
		object: [ self outerContext ];
		view: #gtVariablesFor:
]
