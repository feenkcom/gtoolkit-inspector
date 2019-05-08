Extension { #name : #BrLook }

{ #category : #'*GToolkit-Inspector' }
BrLook >> gtLookChangesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Look changes';
		priority: 10;
		stencil: [ changes asElementFor: self ]
]
