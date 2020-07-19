Extension { #name : #OrderedDictionary }

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtItemsFor: aView [
	^ aView columnedList
		title: 'Items';
		items: [ self associations ];
		column: 'Key' item: #key;
		column: 'Value' item: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtKeysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Keys';
		items: [ self keys ];
		column: 'Key' item: [ :aKey | aKey ]
]
