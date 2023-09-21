Extension { #name : #TaskAtQueue }

{ #category : #'*GToolkit-Inspector' }
TaskAtQueue >> gtItemsFor: aView [
	<gtView>

	queue ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Tasks';
		priority: 10;
		items: [ queue itemArray ];
		column: 'Time'
			text: [ :item | item scheduledTime ];
		column: 'Receiver'
			text: [ :item |
				item valuable isBlock
					ifTrue: [ item valuable receiver ]
					ifFalse: [ '' ] ];
		column: 'Valuable'
			text: [ :item | item valuable ]
]
