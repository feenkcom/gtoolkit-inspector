Class {
	#name : #GtViewCreatorExamples,
	#superclass : #GtViewCreator,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #examples }
GtViewCreatorExamples >> associationsList_detailsView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateDetailsViewSourceFor:
		forSlot: #listOfAssociations
		inObject: self targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_associationsList_detailsView_slotData.
		
	^ viewCreator
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_associationsList_detailsView_slotData [
	^  'gtListOfAssociationsFor: aView
	<gtView>
	listOfAssociations ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''Details'';
		items: [ listOfAssociations ];
		column: ''Property''
			text: [ :each | each key gtDisplayString asRopedText foreground: Color gray ];
		column: ''Value'' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]'
]

{ #category : #'data - expected' }
GtViewCreatorExamples >> expectedSourceCode_sequenceableCollection_listView_slotData [
	^  'gtListOfAssociationsFor: aView
	<gtView>
	listOfAssociations ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''ListOfAssociations'';
		items: [ listOfAssociations ];
		column: ''Index''
			text: [ :each :index | index gtDisplayString ]
			width: 45;
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

{ #category : #examples }
GtViewCreatorExamples >> sequenceableCollection_listView_slotData_sourceCodeGeneration [
	<gtExample>
	| viewCreator |
	
	viewCreator := self 
		viewCreatorForSelector: #gtCreateViewSourceFor:
		forSlot: #listOfAssociations
		inObject: self targetObject.
		
	self 
		assert: viewCreator source 
		equals: self expectedSourceCode_sequenceableCollection_listView_slotData.
		
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
