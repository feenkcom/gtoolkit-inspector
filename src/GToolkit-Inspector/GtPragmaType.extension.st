Extension { #name : #GtPragmaType }

{ #category : #'*GToolkit-Inspector' }
GtPragmaType >> gtPragmasFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pragmas';
		priority: 1;
		items: [ self pragmas sorted: [:a :b | a gtDisplayString < b gtDisplayString] ];
		column: 'Class' text: [:each | each methodClass name ];
		column: 'Selector' text: [:each | each method selector ]
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
