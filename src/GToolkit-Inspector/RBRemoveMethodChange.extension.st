Extension { #name : #RBRemoveMethodChange }

{ #category : #'*GToolkit-Inspector' }
RBRemoveMethodChange >> gtChangesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff';
		priority: 10;
		stencil: [ self gtDiff asElement ]
]

{ #category : #'*GToolkit-Inspector' }
RBRemoveMethodChange >> gtDiff [
	| oldSource |
	oldSource := (self methodSourceFor: self selector) ifNil: [ '' ].
	^ PrettyTextDiffBuilder
		from: oldSource
		to: ''
		inClass: self changeClass
]
