Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtCreateDetailsViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	(self notEmpty and: [ self first isAssociation ])
		ifFalse: [ ^ aGtViewCreator empty ].
	
	aGtViewCreator
		title: 'Details'.
		
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView columnedList 
		title: ''{viewTitle}'';
		items: [ {objectSource} ];
		column: ''Property'' text: [ :each | each key ];
		column: ''Value'' text: [:each | each value ];
		send: [ :each | each value ]'.
		
	bindings := {
		'viewSelector' -> aGtViewCreator newSelector.
		'viewTitle' -> aGtViewCreator title.
		'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
		'objectSource' -> aGtViewCreator objectSource
	} asDictionary.
	
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	 
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView columnedList
		title: ''{viewTitle}'';
		items: [ {objectSource} ];
		column: ''Value'' text: [ :each | each gtDisplayString ]' .
	
	bindings := {
			'viewSelector' -> aGtViewCreator newSelector.
			'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
			'viewTitle' -> aGtViewCreator title.
			'objectSource' -> aGtViewCreator objectSource
		} asDictionary.
		
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items';
		priority: 50;
		items: [ self ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' 
			text: [ :eachItem | eachItem gtDisplayText ].
]
