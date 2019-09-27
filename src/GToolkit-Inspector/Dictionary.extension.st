Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtItemsFor: aView [
	^ aView columnedTree
		title: 'Items';
		priority: 1;
		items: [ self associations ];
		children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
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
