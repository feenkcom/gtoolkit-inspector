Extension { #name : #MCMethodDefinition }

{ #category : #'*GToolkit-Inspector' }
MCMethodDefinition >> gtViewDefinitionSourceFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Source Code';
		text: [ self source ]
]
