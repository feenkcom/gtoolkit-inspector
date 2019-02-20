Extension { #name : #BlChildrenArray }

{ #category : #'*GToolkit-Inspector' }
BlChildrenArray >> gtChildrenFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Children';
		items: [ array ];
		column: 'Child' item: [ :aChild | aChild ]
]
