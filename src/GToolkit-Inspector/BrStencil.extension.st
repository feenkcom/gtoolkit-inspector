Extension { #name : #BrStencil }

{ #category : #'*GToolkit-Inspector' }
BrStencil classSide >> gtLiveFor: aView [
	<gtView>
	self isAbstract ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: -5;
		stencil: [ self new ]
]
