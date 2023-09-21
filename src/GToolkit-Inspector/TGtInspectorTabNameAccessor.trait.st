Trait {
	#name : #TGtInspectorTabNameAccessor,
	#instVars : [
		'tabName'
	],
	#category : 'GToolkit-Inspector-Tab Selector'
}

{ #category : #defaults }
TGtInspectorTabNameAccessor >> defaultTabName [
	^ GtInspectorTabName null
]

{ #category : #initialization }
TGtInspectorTabNameAccessor >> initializeTabName [
	tabName := self defaultTabName.
]

{ #category : #accessing }
TGtInspectorTabNameAccessor >> tabName [
	<return: #GtInspectorTabName>
	^ tabName
]

{ #category : #accessing }
TGtInspectorTabNameAccessor >> tabName: aGtInspectorTabName [
	self 
		assert: [ aGtInspectorTabName isNotNil ]
		description: [ 'Tab name must be non-nil' ].
	tabName := aGtInspectorTabName
]
