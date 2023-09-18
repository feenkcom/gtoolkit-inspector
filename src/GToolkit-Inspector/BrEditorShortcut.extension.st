Extension { #name : #BrEditorShortcut }

{ #category : #'*GToolkit-Inspector' }
BrEditorShortcut >> gtSourceCodeFor: aView [ 
	<gtView>

	^ aView forward
		title: 'Source code';
		priority: 1;
		object: [ performBlock ifNil: [ self class >> #performOnEditor:element:dueTo: ] ];
		view: #gtSourceCodeFor:
]
