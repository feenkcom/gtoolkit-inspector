Extension { #name : #RBAddClassChange }

{ #category : #'*GToolkit-Inspector' }
RBAddClassChange >> gtViewDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		priority: 50;
		title: 'Definition';
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self definition asRopedText ]
]
