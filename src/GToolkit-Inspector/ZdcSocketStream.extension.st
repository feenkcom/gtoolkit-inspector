Extension { #name : #ZdcSocketStream }

{ #category : #'*GToolkit-Inspector' }
ZdcSocketStream >> gtLiveTranscriptFor: aView [
	<gtView>
	^ aView forward
		title: 'Live';
		priority: 150;
		object: [self liveTranscript];
		view: #gtLiveFor:
]
