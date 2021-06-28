Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Inspector' }
BlockClosure >> gtSourceCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Source code';
		priority: 1;
		object: [ self sourceNode ];
		view: #gtSourceCodeFor:;
		actionButtonIcon: BrGlamorousIcons inspect 
			tooltip: 'Inspect Block' 
			action: [ :aButton | 
				aButton phlow spawnObject: self ]
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
