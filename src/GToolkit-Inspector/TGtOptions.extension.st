Extension { #name : #TGtOptions }

{ #category : #'*GToolkit-Inspector' }
TGtOptions >> gtOptionsFor: aView [
	<gtView>
	self hasOptions ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Options';
		object: [ options ];
		view: #gtItemsFor:
]
