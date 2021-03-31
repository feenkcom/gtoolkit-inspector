Extension { #name : #BeaconSignal }

{ #category : #'*GToolkit-Inspector' }
BeaconSignal >> gtOneLineFor: aView [
	<gtView>
	self timestamp ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'One line';
		priority: 1;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self printOneLineString asRopedText ]
]

{ #category : #'*GToolkit-Inspector' }
BeaconSignal >> gtReferencesFor: aView [
	<gtView>
	^ aView forward
		title: 'References';
		priority: 2;
		object: [ self class gtReferences ];
		view: #gtItemsFor:
]
