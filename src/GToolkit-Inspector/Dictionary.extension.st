Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Items';
		priority: 1;
		items: [ self associations sort: (#key collatedBy: #asString) ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations sort: (#key collatedBy: #asString) ]
				ifFalse: [ 
					(each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ] weight: 3;
		contextItemLabel: 'Inspect key' action: [ :anElement :aTreeNode | 
			anElement phlow spawnObject: aTreeNode value key ];
		contextItemLabel: 'Inspect association' action: [ :anElement :aTreeNode | 
			anElement phlow spawnObject: aTreeNode value ];
		send: [ :assoc | assoc value  ]
		
	"Implementation note: association sorting uses #collatedBy: to avoid a 'Symbol DNU value: value: error'"
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtKeysFor: aView [
	<gtView>
	^ aView list
		title: 'Keys';
		priority: 5;
		items: [ self keys ]
]

{ #category : #'*GToolkit-Inspector' }
Dictionary >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ (self associations sum: [ :assoc | 
			assoc sizeInMemory ])
]
