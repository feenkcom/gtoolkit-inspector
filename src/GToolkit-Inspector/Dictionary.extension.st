Extension { #name : 'Dictionary' }

{ #category : '*GToolkit-Inspector' }
Dictionary >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Items';
		priority: 1;
		items: [ self associations ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ]
]

{ #category : '*GToolkit-Inspector' }
Dictionary >> gtKeysFor: aView [
	<gtView>
	^ aView list
		title: 'Keys';
		priority: 5;
		items: [ self keys ]
]
