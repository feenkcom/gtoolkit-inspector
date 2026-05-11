Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtActionCompareObjectsFor: anAction [
	<gtAction>
	(self size < 2 or: [ self size > 5 ]) ifTrue: [ ^ anAction empty ].
	^ anAction button
		priority: 100;
		target: GtPhlowObjectContextMenuTarget;
		id: GtInspectorCompareObjectsId;
		tooltip: 'Compare the objects';
		icon: BrGlamorousVectorIcons empty;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: self gtDisplayText;
		action: [ :aButton | aButton phlow spawnObject: (GtObjectComparer compareAll: self) ]
]

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
		withMultipleSelection;
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' 
			text: [ :eachItem | eachItem gtDisplayText ];
		dynamicContextItems: [ :anElement :aCollection | 
			aCollection size = 1
				ifTrue: [ GtPhlowObjectContextMenuTarget
						menuItemsForObject: aCollection first
						hostElement: anElement ]
				ifFalse: [ GtPhlowObjectContextMenuTarget
						menuItemsForObject: aCollection
						hostElement: anElement ] ]
]
