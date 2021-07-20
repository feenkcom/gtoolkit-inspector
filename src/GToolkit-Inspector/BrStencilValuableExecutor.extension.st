Extension { #name : 'BrStencilValuableExecutor' }

{ #category : '*GToolkit-Inspector' }
BrStencilValuableExecutor >> gtBlockClosureVariablesFor: aView [
	<gtView>
	(self valuable isKindOf: BlockClosure) 
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Variables';
		priority: 2;
		object: [ self valuable ];
		view: #gtVariablesFor:
]

{ #category : '*GToolkit-Inspector' }
BrStencilValuableExecutor >> gtSourceCodeFor: aView [
	<gtView>
	(self valuable isKindOf: BlockClosure) 
		ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Source code';
		priority: 1;
		object: [ self valuable ];
		view: #gtSourceCodeFor:
]
