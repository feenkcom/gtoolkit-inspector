Extension { #name : #ChangeRecord }

{ #category : #'*GToolkit-Inspector' }
ChangeRecord >> gtSourceFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Source';
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: (BrRBTextStyler new
			 classOrMetaClass: self methodClass);
		text: [self sourceCode]
]
