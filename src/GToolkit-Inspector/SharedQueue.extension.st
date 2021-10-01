Extension { #name : #SharedQueue }

{ #category : #'*GToolkit-Inspector' }
SharedQueue >> gtItemsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Items';
		items: [ monitor critical: [ items copy ] ];
		column: 'Index' text: [ :anItem :anIndex | anIndex ] width: 100;
		column: 'Item' text: [ :anItem :anIndex | anItem ]
]
