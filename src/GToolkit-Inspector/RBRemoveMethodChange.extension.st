Extension { #name : #RBRemoveMethodChange }

{ #category : #'*GToolkit-Inspector' }
RBRemoveMethodChange >> gtChangesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff';
		priority: 10;
		stencil: [ self gtDiffChange asElement ]
]
