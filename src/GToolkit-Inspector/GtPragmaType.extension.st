Extension { #name : #GtPragmaType }

{ #category : #'*GToolkit-Inspector' }
GtPragmaType >> gtPragmasFor: aView [
	<gtView>
	^ aView list
		title: 'Pragmas';
		items: [ self pragmas ];
		itemText: #gtDisplayString
]
