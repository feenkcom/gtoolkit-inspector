Extension { #name : #OrderedDictionary }

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtItemsFor: aView [
	^ aView columnedList
		title: 'Items';
		items: [ self associations ];
		column: 'Key' do: [:aColumn | aColumn item: [:each | each key ] ];
		column: 'Value' do: [:aColumn | aColumn item: [:each | each value ] ];
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtKeysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Keys';
		items: [ self keys ];
		column: 'Key' do: [ :column |
			column item: [ :aKey | aKey ]; matchParent ]
]
