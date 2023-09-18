Extension { #name : #BlBasicShortcut }

{ #category : #'*GToolkit-Inspector' }
BlBasicShortcut >> gtSourceCodeFor: aView [ 
	<gtView>

	^ aView forward
		title: 'Source';
		object: [ self class >> #performDueTo: ];
		view: #gtSourceFor:
]
