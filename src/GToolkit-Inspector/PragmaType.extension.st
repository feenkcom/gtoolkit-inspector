Extension { #name : #PragmaType }

{ #category : #'*GToolkit-Inspector' }
PragmaType >> gtPragmasFor: aView [
	<gtView>
	^ aView list
		title: 'Pragmas';
		items: [ self pragmas ];
		itemText: #gtDisplayString
]
