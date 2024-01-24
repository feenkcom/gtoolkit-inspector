Class {
	#name : #GtInspectorTabByViewNameSelector,
	#superclass : #GtInspectorTabSelector,
	#traits : 'TGtInspectorTabNameAccessor',
	#classTraits : 'TGtInspectorTabNameAccessor classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #defaults }
GtInspectorTabByViewNameSelector >> defaultTabName [
	^ GtInspectorTabName null
]

{ #category : #initialization }
GtInspectorTabByViewNameSelector >> initialize [
	super initialize.
	self initializeTabName.
]

{ #category : #printing }
GtInspectorTabByViewNameSelector >> printOn: aStream [
	aStream 
		nextPutAll: 'Selector of: ';
		print: self tabName
]

{ #category : #configuration }
GtInspectorTabByViewNameSelector >> recentlySelectedTab: aTabName on: anObject [
	aTabName hasTabName ifFalse: [ ^ self ].
	self tabName: aTabName
]

{ #category : #actions }
GtInspectorTabByViewNameSelector >> selectTabIn: aTabGroup on: anObect [
	aTabGroup viewModel tabs
		detect:
			[ :tabModel | 
				| aTitle |
				aTitle := tabModel widget phlow entity ifNotNil: #title.
				self tabName isEqualToString: aTitle asString ]
		ifFound: [ :tabModel | tabModel select ]
		ifNone: [ "do nothing" ]
]

{ #category : #accessing }
GtInspectorTabByViewNameSelector >> tabName [
	<return: #GtInspectorTabName>
	^ tabName
]
