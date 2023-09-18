Extension { #name : #ChangeRecord }

{ #category : #'*GToolkit-Inspector' }
ChangeRecord >> gtSourceFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Source';
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [self sourceCode]
]
