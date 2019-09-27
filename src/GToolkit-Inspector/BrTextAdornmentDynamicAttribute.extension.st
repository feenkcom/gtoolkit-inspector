Extension { #name : #BrTextAdornmentDynamicAttribute }

{ #category : #'*GToolkit-Inspector' }
BrTextAdornmentDynamicAttribute >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: stencilBuilder
]
