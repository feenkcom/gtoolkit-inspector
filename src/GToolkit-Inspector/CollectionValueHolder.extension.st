Extension { #name : 'CollectionValueHolder' }

{ #category : '*GToolkit-Inspector' }
CollectionValueHolder >> gtBoxesFor: aView [
	<gtView>
	^ (self value gtBoxesFor: aView)
		updateWhen: ValueChanged in: [ self announcer ];
		yourself
]
