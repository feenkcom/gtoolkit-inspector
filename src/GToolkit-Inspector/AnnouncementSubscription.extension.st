Extension { #name : #AnnouncementSubscription }

{ #category : #'*GToolkit-Inspector' }
AnnouncementSubscription >> gtSourceCodeFor: aView [ 
	<gtView>
	^ aView forward
		title: 'Source';
		object: [ self action ];
		view: #gtSourceCodeFor:
]
