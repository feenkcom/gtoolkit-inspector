Extension { #name : 'BlAsyncDelayedPreviewStrategy' }

{ #category : '*GToolkit-Inspector' }
BlAsyncDelayedPreviewStrategy >> gtLiveFor: aView [
	<gtView>
	self previewStencil ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Preview';
		object: [ self previewElement ];
		view: #gtLiveFor:
]
