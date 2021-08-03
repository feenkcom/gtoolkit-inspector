Extension { #name : 'WeakMessageSend' }

{ #category : '*GToolkit-Inspector' }
WeakMessageSend >> gtMethodFor: aView [ 
	<gtView>
	self isValid ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Called Method';
		priority: 1;
		object: [ self asMessageSend ];
		view: #gtMethodFor:
]

{ #category : '*GToolkit-Inspector' }
WeakMessageSend >> gtMethodSendersFor: aView [ 
	<gtView>
	self isValid ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Method Senders';
		priority: 2;
		stencil: [ 
			self receiver class name gtClassMatches &
			self selector gtSenders ]
]
