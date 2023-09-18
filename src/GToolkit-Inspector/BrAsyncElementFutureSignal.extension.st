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
