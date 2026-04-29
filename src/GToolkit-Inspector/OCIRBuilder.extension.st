Extension { #name : #OCIRBuilder }

{ #category : #'*GToolkit-Inspector' }
OCIRBuilder >> gtBytecodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Bytecode';
		priority: 1;
		object: [ self ir compiledMethod ];
		view: #gtBytecodeFor:
]

{ #category : #'*GToolkit-Inspector' }
OCIRBuilder >> gtSourceCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Source code';
		priority: 2;
		object: [ self ir compiledMethod ];
		view: #gtSourceCodeFor:
]
