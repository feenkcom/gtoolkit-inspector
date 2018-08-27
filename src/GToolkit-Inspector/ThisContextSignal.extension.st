Extension { #name : #ThisContextSignal }

{ #category : #'*GToolkit-Inspector' }
ThisContextSignal >> gtStackFor: aView [
	<gtView>
	^ aView explicit
		title: 'Stack';
		priority: 50;
		stencil: [ BrSimpleList new display: self stack ]
]
