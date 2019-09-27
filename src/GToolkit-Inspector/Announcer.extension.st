Extension { #name : #Announcer }

{ #category : #'*GToolkit-Inspector' }
Announcer >> gtSubscriptionsFor: aView [
	<gtView>
	self numberOfSubscriptions isZero ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Subscriptions';
		priority: 50;
		items: [ self subscriptions subscriptions asArray ];
		column: 'Subscriber' translated do: [ :aColumn | 
			aColumn 
				item: [ :aSubscription | aSubscription subscriber ]; 
				matchParent ];
		column: 'Announcement' translated do: [ :aColumn |
			aColumn 
				item: [ :aSubscription | aSubscription announcementClass ]; 
				matchParent ];
		column: 'Kind' translated do: [ :aColumn |
			aColumn 
				item: [ :aSubscription | aSubscription class ]; 
				matchParent ].
]
