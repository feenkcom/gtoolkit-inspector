Extension { #name : #FileLocator }

{ #category : #'*GToolkit-Inspector' }
FileLocator class >> gtPredefinedOriginsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Predefined origins';
		items: [ self supportedOrigins collect: [ :sel | self perform: sel ] as: OrderedCollection ];
		column: 'Selector' translated item: [ :e | e origin ];
		column: 'Location' translated item: [ :e | e resolve ] weight: 2
]
