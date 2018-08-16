*GToolkit-Inspector
gtSubscriptionsFor: aView
	<gtView: 30>
	self numberOfSubscriptions isZero ifTrue: [ ^ aView empty ].
	^ aView explicit
		title: 'Subscriptions';
		stencil: [
			| list |
			list := BrColumnedList new display: self subscriptions glmSubscriptions asArray.
			
			list column
				title: 'Subscriber';
				stencil: [ :each | BrListLabelStencil fitContent: each subscriber printString ].
				
			list column
				title: 'Announcement';
				stencil: [ :each | BrListLabelStencil fitContent: each announcementClass printString ].
				
			list column
				title: 'Kind';
				stencil: [ :each | BrListLabelStencil matchParent: each class name ].
			list constraintsDo: [ :c | c padding: (BlInsets top: 10)  ].
			list ]