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
GtPragmaType >> gtSpotterPragmasFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 40;
		title: 'Pragmas';
		allCandidates: [ self pragmas ];
		itemName: [ :pragma | pragma method printString , ' ' , pragma asString ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Inspector' }
GtPragmaType >> gtSpotterUsersFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 50;
		title: 'Users';
		filter: GtFilterSubstring
			item:
				[ :filter :context | self users do: [ :sender | filter value: sender ] ]
]
