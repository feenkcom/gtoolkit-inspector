Extension { #name : #RBAddMethodChange }

{ #category : #'*GToolkit-Inspector' }
RBAddMethodChange >> gtChangesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff';
		priority: 10;
		stencil: [ self gtDiff asElement ]
]

{ #category : #'*GToolkit-Inspector' }
RBAddMethodChange >> gtDiff [
	| oldSource newSource |
	oldSource := (self methodSourceFor: self selector)
		ifNil: [ '' ].
	newSource := source.
	^ PrettyTextDiffBuilder
		from: oldSource
		to: newSource
		inClass: self changeClass
]
