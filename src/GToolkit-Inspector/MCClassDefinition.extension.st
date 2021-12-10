Extension { #name : #MCClassDefinition }

{ #category : #'*GToolkit-Inspector' }
MCClassDefinition >> gtViewClassDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Class Definition';
		text: [ self definitionString ]
]
