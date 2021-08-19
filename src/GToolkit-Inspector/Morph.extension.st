Extension { #name : 'Morph' }

{ #category : '*GToolkit-Inspector' }
Morph >> gtMorphFor: aView [
	<gtView>
	^ aView explicit
		title: 'Morph';
		priority: 4;
		stencil: [ self imageForm asElement asPannableElement ]
]
