Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtSourceCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Source code';
		priority: 1;
		object: [ self sourceNode ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtVariablesFor: aView [
	<gtView>
	self outerContext ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Variables';
		priority: 2;
		object: [ self outerContext ];
		view: #gtVariablesFor:
]
