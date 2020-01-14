Extension { #name : #BeaconSignal }

{ #category : #'*GToolkit-Inspector' }
BeaconSignal >> gtOneLineFor: aView [
	<gtView>
	self timestamp ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'One line';
		look: BrGlamorousCodeEditorLook new;
		text: [ self printOneLineString asRopedText ]
]

{ #category : #'*GToolkit-Inspector' }
BeaconSignal >> gtReferencesFor: aView [
	<gtView>
	^ aView forward
		title: 'References';
		object: [ self class gtReferences ];
		view: #gtItemsFor:
]
