Extension { #name : 'GtPhlowElementContext' }

{ #category : '*GToolkit-Inspector' }
GtPhlowElementContext >> gtLiveFor: aView [
	<gtView>
	self element ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Element';
		priority: 1;
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : '*GToolkit-Inspector' }
GtPhlowElementContext >> gtPhlowViewFor: aView [
	<gtView>
	self entity ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Entity';
		priority: 2;
		object: [ self entity ];
		view: #gtLiveFor:
]
