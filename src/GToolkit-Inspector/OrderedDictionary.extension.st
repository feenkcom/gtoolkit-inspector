Extension { #name : #OrderedDictionary }

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtCreateViewGroupingFor: aGtViewCreator [
	<gtViewCreator>
	
	dictionary gtCreateViewGroupingFor: aGtViewCreator
]

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtCreateViewGroupingHorizontalBarChartFor: aGtViewCreator [
	<gtViewCreator>
	
	dictionary gtCreateViewGroupingHorizontalBarChartFor: aGtViewCreator
]

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
			
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView columnedList 
		title: ''{viewTitle}'';
		items: [ 
			{objectComputation} associations ];
		column: ''Key'' text: [ :each | each key gtDisplayString ];
		column: ''Value'' text: [:each | each value gtDisplayString ];
		send: [ :each | each value ]'.
		
	bindings := {
		'viewSelector' -> aGtViewCreator newSelector.
		'viewTitle' -> aGtViewCreator title.
		'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
		'objectComputation' -> (aGtViewCreator variable 
				ifNil: [ '[ ', aGtViewCreator objectSource, ' ] value' ]
				ifNotNil: [ aGtViewCreator objectSource ])
	} asDictionary.
	 
	aGtViewCreator
		source: (template format: bindings)
]

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
