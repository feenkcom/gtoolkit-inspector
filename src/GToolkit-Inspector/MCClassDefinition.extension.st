Extension { #name : #MCClassDefinition }

{ #category : #'*GToolkit-Inspector' }
MCClassDefinition >> gtViewClassDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Class definition';
		text: [ self definitionString ]
]
