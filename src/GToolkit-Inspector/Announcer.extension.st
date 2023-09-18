Extension { #name : #Announcer }

{ #category : #'*GToolkit-Inspector' }
Announcer >> gtSubscriptionsFor: aView [
	<gtView>
	self subscriptions ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Subscriptions';
		priority: 50;
		items: [ self subscriptions subscriptions asArray ];
		actionUpdateButtonTooltip: 'Update subscription list';
		column: 'Subscriber' text: [ :aSubscription | aSubscription subscriber ];
		column: 'Announcement' text: [ :aSubscription | aSubscription announcementClass ];
		column: 'Kind' text: [ :aSubscription | aSubscription class ]
]
