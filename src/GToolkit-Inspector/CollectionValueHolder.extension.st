Extension { #name : #CollectionValueHolder }

{ #category : #'*GToolkit-Inspector' }
CollectionValueHolder >> gtBoxesFor: aView [
	<gtView>
	^ (self value gtBoxesFor: aView)
		priority: 20;
		updateWhen: ValueChanged in: [ self announcer ];
		yourself
]

{ #category : #'*GToolkit-Inspector' }
CollectionValueHolder >> gtItemsFor: aView [
	<gtView>
	^ (self value gtItemsFor: aView)
		priority: 10;
		updateWhen: ValueChanged in: [ self announcer ];
		yourself
]
