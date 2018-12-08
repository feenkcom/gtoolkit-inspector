Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtItemsFor: aView [
	^ aView columnedList
		title: 'Items';
		items: [ self associations ];
		column: 'Key' do: [ :column |
			column item: [ :assoc | assoc key ]; matchParent ];
		column: 'Value' do: [ :column |
			column item: [:assoc | assoc value ]; matchParent ];
		send: [ :assoc | assoc value ]
]
