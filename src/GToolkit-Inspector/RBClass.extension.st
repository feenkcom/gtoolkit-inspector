Extension { #name : #RBClass }

{ #category : #'*GToolkit-Inspector' }
RBClass >> gtDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Definition';
		priority: 2;
		styler: (BrRBTextStyler new
				   isForWorkspace: true;
				   yourself);
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self gtDefinitionString ]
]
