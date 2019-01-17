Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtItemsFor: aView [
	^ aView columnedList
		title: 'Items';
		priority: 1;
		items: [ self associations ];
		column: 'Key' do: [ :column |
			column item: [ :assoc | assoc key ]; matchParent ];
		column: 'Value' do: [ :column |
			column item: [:assoc | assoc value ]; matchParent ];
		send: [ :assoc | assoc value ]
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtKeysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Keys';
		priority: 5;
		items: [ self keys ];
		column: 'Key' do: [ :column |
			column item: [ :aKey | aKey ]; matchParent ]
]
