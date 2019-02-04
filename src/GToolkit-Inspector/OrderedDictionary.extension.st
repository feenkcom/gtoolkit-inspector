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
