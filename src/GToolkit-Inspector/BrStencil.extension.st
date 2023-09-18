Extension { #name : #BrStencil }

{ #category : #'*GToolkit-Inspector' }
BrStencil >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 0;
		object: [ self asElement ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect action: [ :aBrButton | 
			aBrButton phlow spawnObject: self asElement ]
]

{ #category : #'*GToolkit-Inspector' }
BrStencil class >> gtLiveFor: aView [
	<gtView>
	<gtClassView>
	self isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self new ];
		view: #gtLiveFor:
]
