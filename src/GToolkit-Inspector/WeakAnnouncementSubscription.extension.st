Extension { #name : #WeakAnnouncementSubscription }

{ #category : #'*GToolkit-Inspector' }
WeakAnnouncementSubscription >> gtMethodSendersFor: aView [ 
	<gtView>
	^ aView forward
		title: 'Method senders';
		object: [ self action ];
		view: #gtMethodSendersFor:
]

{ #category : #'*GToolkit-Inspector' }
WeakAnnouncementSubscription >> gtSourceCodeFor: aView [ 
	<gtView>
	^ aView forward
		title: 'Called method';
		object: [ self action ];
		view: #gtMethodFor:
]
