Extension { #name : #IRBuilder }

{ #category : #'*GToolkit-Inspector' }
IRBuilder >> gtBytecodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Bytecode';
		priority: 1;
		object: [ self ir compiledMethod ];
		view: #gtBytecodeFor:
]

{ #category : #'*Gtoolkit-Inspector' }
IRBuilder >> gtSourceCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Source code';
		priority: 2;
		object: [ self ir compiledMethod ];
		view: #gtSourceCodeFor:
]
