Extension { #name : #SymbolicBytecode }

{ #category : #'*GToolkit-Inspector' }
SymbolicBytecode >> gtSourceFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Source';
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: (BrRBTextStyler new classOrMetaClass: self method methodClass);
		priority: 10;
		text: [ | text |
			text := self method sourceCode asRopedText.
			(text from: self sourceInterval first to: self sourceInterval last)
				attributes:
					{(BlTextUnderlineAttribute new
						color: BrGlamorousColors textHighlightColor;
						thickness: 3;
						beNotOverwritableByStyler)}.
			text ]
]
