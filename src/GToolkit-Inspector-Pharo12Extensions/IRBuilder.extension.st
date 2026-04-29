Extension { #name : #IRBuilder }

{ #category : #'*GToolkit-Inspector-Pharo12Extensions' }
IRBuilder >> gtBytecodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Bytecode';
		priority: 1;
		object: [ self ir compiledMethod ];
		view: #gtBytecodeFor:
]

{ #category : #'*GToolkit-Inspector-Pharo12Extensions' }
IRBuilder >> gtSourceCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Source code';
		priority: 2;
		object: [ self ir compiledMethod ];
		view: #gtSourceCodeFor:
]
