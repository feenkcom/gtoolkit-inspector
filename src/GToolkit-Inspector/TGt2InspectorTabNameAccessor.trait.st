Trait {
	#name : #TGt2InspectorTabNameAccessor,
	#instVars : [
		'tabName'
	],
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #defaults }
TGt2InspectorTabNameAccessor >> defaultTabName [
	^ Gt2InspectorTabName null
]

{ #category : #initialization }
TGt2InspectorTabNameAccessor >> initializeTabName [
	tabName := self defaultTabName.
]

{ #category : #accessing }
TGt2InspectorTabNameAccessor >> tabName [
	<return: #Gt2InspectorTabName>
	^ tabName
]

{ #category : #accessing }
TGt2InspectorTabNameAccessor >> tabName: aGtInspectorTabName [
	self 
		assert: [ aGtInspectorTabName isNotNil ]
		description: [ 'Tab name must be non-nil' ].
	tabName := aGtInspectorTabName
]
