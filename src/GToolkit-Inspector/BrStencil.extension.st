Extension { #name : #BrStencil }

{ #category : #'*GToolkit-Inspector' }
BrStencil class >> gtLiveFor: aView [
	<gtView>
	self isAbstract ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: -5;
		stencil: [ self new ]
]

{ #category : #'*GToolkit-Inspector' }
BrStencil >> gtPreviewFor: aView [
	<gtView>

	^ aView forward
		title: 'Preview';
		priority: 0;
		object: [ self create ];
		view: #gtLiveFor:
]
