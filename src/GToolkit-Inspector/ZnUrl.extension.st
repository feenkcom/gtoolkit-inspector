Extension { #name : 'ZnUrl' }

{ #category : '*GToolkit-Inspector' }
ZnUrl >> gtUrlFor: aView [
	<gtView>
	^ aView textEditor
		title: 'URL';
		priority: 1;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self printString asRopedText ]
]
