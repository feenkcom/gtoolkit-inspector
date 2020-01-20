Extension { #name : #BrProgress }

{ #category : #'*GToolkit-Inspector' }
BrProgress >> decreaseByTenPercent [
	| anAmount anIncrease |
	anIncrease := self total * (10 / self total).
	anAmount := (self amount - anIncrease) max: 0. 
	self amount: anAmount total: self total.
]

{ #category : #'*GToolkit-Inspector' }
BrProgress >> gtLiveFor: aView [
	^ (super gtLiveFor: aView)
		actionButtonLabel: 'Minus' action: [
			self decreaseByTenPercent ];
		actionButtonLabel: 'Plus' action: [
			self increatesByTenPercent ]
]

{ #category : #'*GToolkit-Inspector' }
BrProgress >> increatesByTenPercent [
	| anAmount anIncrease |
	anIncrease := self total * (10 / self total).
	anAmount := (self amount + anIncrease) min: self total. 
	self amount: anAmount total: self total.
]
