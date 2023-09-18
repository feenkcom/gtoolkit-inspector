Extension { #name : #GtPragmaType }

{ #category : #'*GToolkit-Inspector' }
GtPragmaType >> gtPragmasFor: aView [
	<gtView>
	^ aView list
		title: 'Pragmas';
		items: [ self pragmas ];
		itemText: #gtDisplayString
]

{ #category : #'*GToolkit-Inspector' }
GtPragmaType >> gtSpotterPragmasFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 40;
		title: 'Pragmas';
		items: [ self pragmas ];
		itemName: [ :pragma | pragma method printString , ' ' , pragma asString ];
		filterBySubstring
]

{ #category : #'*GToolkit-Inspector' }
GtPragmaType >> gtSpotterUsersFor: aSearch [
	<gtSearch>

	^ aSearch list
		priority: 50;
		title: 'Users';
		items: [ self users ];
		filterBySubstring
]
