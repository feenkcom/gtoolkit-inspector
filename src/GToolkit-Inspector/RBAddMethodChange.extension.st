Extension { #name : #RBAddMethodChange }

{ #category : #'*GToolkit-Inspector' }
RBAddMethodChange >> gtChangesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff';
		priority: 10;
		stencil: [ self gtDiffChange asElement ]
]
