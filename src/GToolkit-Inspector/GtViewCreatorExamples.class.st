Class {
	#name : #GtViewCreatorExamples,
	#superclass : #GtViewCreator,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #examples }
GtViewCreatorExamples >> collectionObject_itemsView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewSourceFor:
		forSlot: #listOfAssociations
		inObject: self targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_collectionObject_itemsView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> dictionaryObject_editorView_slotData_sourceCodeGeneration [
	<gtExample>
	| targetObject viewCreator  |
	
	targetObject := self targetObject.
	targetObject dictionaryOfCollections: (Dictionary 
		withAll: self targetObject 
			dictionaryOfCollections).
	self 
		assert: targetObject dictionaryOfCollections class 
		equals: Dictionary.
				
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewSourceFor:
		forSlot: #dictionaryOfCollections
		inObject: targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_dictionaryObject_associationsView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> dictionaryObject_groupingView_slotData_sourceCodeGeneration [
	<gtExample>
	| targetObject viewCreator  |
	
	targetObject := self targetObject.
	targetObject dictionaryOfCollections: (Dictionary 
		withAll: self targetObject 
			dictionaryOfCollections).
	self 
		assert: targetObject dictionaryOfCollections class 
		equals: Dictionary.
				
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewGroupingFor:
		forSlot: #dictionaryOfCollections
		inObject: targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_dictionaryObject_groupingView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> elementObject_explicitView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewSourceFor:
		forSlot: #pluggableValue
		inObject: (self targetObject
			pluggableValue: BlElement new).
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_elementObject_explicitView_slotData.
		
	^ viewCreator
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_associationsDetailsView_detailsView_slotData [
	^  'gtListOfAssociationsFor: aView
	<gtView>
	listOfAssociations ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''Details'';
		items: [ listOfAssociations ];
		column: ''Property'' text: [ :each | each key ];
		column: ''Value'' text: [ :each | each value ];
		send: [ :each | each value ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_collectionObject_itemsView_slotData [
	^  'gtListOfAssociationsFor: aView
	<gtView>
	listOfAssociations ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''ListOfAssociations'';
		items: [ listOfAssociations ];
		column: ''Value'' text: [ :each | each gtDisplayString ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_dictionaryObject_associationsView_slotData [
	^  'gtDictionaryOfCollectionsFor: aView
	<gtView>
	dictionaryOfCollections ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''DictionaryOfCollections'';
		items: [ dictionaryOfCollections associations ];
		column: ''Key'' text: [ :each | each key gtDisplayString ];
		column: ''Value'' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_dictionaryObject_groupingView_slotData [
	^  'gtDictionaryOfCollectionsFor: aView
	<gtView>
	dictionaryOfCollections ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''Grouping'';
		items: [ dictionaryOfCollections associations
				sorted: [ :anAssoc :annotherAssoc | anAssoc value size < annotherAssoc value size ] ];
		column: ''Name'' text: [ :assoc | assoc key ];
		column: ''Count'' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_elementObject_explicitView_slotData [
	^  'gtPluggableValueFor: aView
	<gtView>
	pluggableValue ifNil: [ ^ aView empty ].
	^ aView explicit
		title: ''PluggableValue'';
		stencil: [ pluggableValue ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_setObject_itemsView_slotData [
	^  'gtPluggableValueFor: aView
	<gtView>
	pluggableValue ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''PluggableValue'';
		items: [ pluggableValue asOrderedCollection ];
		column: ''Value'' text: [ :each | each gtDisplayString ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_stringObject_editorView_slotData [
	^  'gtStringValueFor: aView
	<gtView>
	stringValue ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: ''StringValue'';
		text: [ stringValue ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_stringObject_webViewView_slotData [
	^  'gtPluggableValueFor: aView
	<gtView>
	pluggableValue ifNil: [ ^ aView empty ].
	^ aView explicit
		title: ''PluggableValue'';
		stencil: [ GtWebViewElement new url: pluggableValue ]'
]

{ #category : #examples }
GtViewCreatorExamples >> orderedDictionaryObject_editorView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	self 
		assert: self targetObject dictionaryOfCollections class 
		equals: OrderedDictionary.
		
	viewCreator := self  
		viewCreatorForSelector: #gtCreateViewSourceFor:
		forSlot: #dictionaryOfCollections
		inObject: self targetObject.
	
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_dictionaryObject_associationsView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> orderedDictionaryObject_groupingView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	self 
		assert: self targetObject dictionaryOfCollections class 
		equals: OrderedDictionary.
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewGroupingFor:
		forSlot: #dictionaryOfCollections
		inObject: self targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_dictionaryObject_groupingView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> sequenceableCollection_associationsDetailsView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateDetailsViewSourceFor:
		forSlot: #listOfAssociations
		inObject: self targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_associationsDetailsView_detailsView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> setObject_itemsView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewSourceFor:
		forSlot: #pluggableValue
		inObject: (self targetObject
			pluggableValue: (Set with: 1 with: 2)).
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_setObject_itemsView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> stringObject_editorView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewSourceFor:
		forSlot: #stringValue
		inObject: self targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_stringObject_editorView_slotData.
		
	^ viewCreator
]

{ #category : #examples }
GtViewCreatorExamples >> stringObject_webViewView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateHtmlWebViewViewSourceFor:
		forSlot: #pluggableValue
		inObject: (self targetObject
			pluggableValue: 'http://www.example.com').
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_stringObject_webViewView_slotData.
		
	^ viewCreator
]

{ #category : #accessing }
GtViewCreatorExamples >> targetObject [
	^ GtTestObjectForViewCreation new 
]

{ #category : #utils }
GtViewCreatorExamples >> viewCreatorForSelector: aSelector forObject: aSourceObject andSourceCode: aSourceString inBehaviour: aDestinationBehaviour [

	| viewCreator |
	viewCreator := GtViewCreator new 
		object: aSourceObject;
		objectSource: aSourceString;
		behavior:  aDestinationBehaviour.
	
	aSourceObject perform: aSelector with: viewCreator.
	
	^ viewCreator 
]

{ #category : #utils }
GtViewCreatorExamples >> viewCreatorForSelector: aCreatorSelector forSlot: aSlotName inObject: aTargetObject [ 
	^ self
		viewCreatorForSelector: aCreatorSelector
		forObject: (aTargetObject perform: aSlotName)
		andSourceCode: aSlotName asString
		inBehaviour: aTargetObject class
]
