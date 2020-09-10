Extension { #name : #FileLocator }

{ #category : #'*GToolkit-Inspector' }
FileLocator class >> gtSupportedOriginsViewFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Supported Origins';
		items: [ self supportedOrigins collect: [ :sel | self perform: sel ] as: OrderedCollection ];
		column: 'Selector' translated item: [ :e | e origin ];
		column: 'Current Location' translated item: [ :e | e resolve ]
]
