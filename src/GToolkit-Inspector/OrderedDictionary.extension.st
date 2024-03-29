Extension { #name : #OrderedDictionary }

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Items';
		items: [ self associations ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: #key;
		column: 'Value' text: #value weight: 3;
		contextItemLabel: 'Inspect key' action: [ :anElement :assoc | anElement phlow spawnObject: assoc value key ];
		contextItemLabel: 'Inspect association' action: [ :anElement :assoc | anElement phlow spawnObject: assoc value ];
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtKeysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Keys';
		items: [ self keys ];
		column: 'Key' text: [ :aKey | aKey ]
]
