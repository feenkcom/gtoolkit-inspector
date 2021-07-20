Extension { #name : 'SharedQueue' }

{ #category : '*GToolkit-Inspector' }
SharedQueue >> gtItemsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Items';
		items: [ monitor critical: [ items copy ] ];
		column: 'Index' item: [ :anItem :anIndex | anIndex ] width: 100;
		column: 'Item' item: [ :anItem :anIndex | anItem ]
]
