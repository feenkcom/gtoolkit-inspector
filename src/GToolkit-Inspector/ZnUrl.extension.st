Extension { #name : #ZnUrl }

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtUrlFor: aView [
	<gtView>
	^ aView textEditor
		title: 'URL';
		priority: 1;
		look: BrGlamorousCodeEditorLook new;
		text: [ self printString asRopedText ]
]
