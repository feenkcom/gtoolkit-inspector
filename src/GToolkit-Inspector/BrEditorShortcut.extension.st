Extension { #name : 'BrEditorShortcut' }

{ #category : '*GToolkit-Inspector' }
BrEditorShortcut >> gtSourceCodeFor: aView [ 
	<gtView>

	^ aView forward
		title: 'Source';
		object: [ self class >> #performOnEditor:element:dueTo: ];
		view: #gtSourceFor:
]
