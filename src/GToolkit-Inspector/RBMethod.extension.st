Extension { #name : #RBMethod }

{ #category : #'*GToolkit-Inspector' }
RBMethod >> gtSourceFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Source';
		priority: 1;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: BrRBTextStyler new;
		text: [ self source ]
]
