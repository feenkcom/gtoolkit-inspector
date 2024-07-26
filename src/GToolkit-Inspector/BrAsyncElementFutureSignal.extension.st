Extension { #name : #BrAsyncElementFutureSignal }

{ #category : #'*GToolkit-Inspector' }
BrAsyncElementFutureSignal >> gtElementPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Element';
		priority: 0;
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : #'*GToolkit-Inspector' }
BrAsyncElementFutureSignal >> gtFutureCompositionFor: aView [
	<gtView>
	self future ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Future';
		priority: 0;
		object: [ self future ];
		view: #gtCompositionFor:
]
