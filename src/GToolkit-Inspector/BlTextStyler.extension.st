Extension { #name : #BlTextStyler }

{ #category : #'*GToolkit-Inspector' }
BlTextStyler >> gtViewTextFor: aView [
	<gtView>
	text  ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Last styled text';
		priority: 105;
		text: [ text ]
]
