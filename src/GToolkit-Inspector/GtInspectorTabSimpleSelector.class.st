Class {
	#name : 'GtInspectorTabSimpleSelector',
	#superclass : 'GtInspectorTabSelector',
	#traits : 'TGtInspectorTabNameAccessor',
	#classTraits : 'TGtInspectorTabNameAccessor classTrait',
	#category : 'GToolkit-Inspector-Tab Selector'
}

{ #category : 'defaults' }
GtInspectorTabSimpleSelector >> defaultTabName [
	^ GtInspectorTabName null
]

{ #category : 'initialization' }
GtInspectorTabSimpleSelector >> initialize [
	super initialize.
	self initializeTabName.
]

{ #category : 'printing' }
GtInspectorTabSimpleSelector >> printOn: aStream [
	aStream 
		nextPutAll: 'Selector of: ';
		print: self tabName
]

{ #category : 'configuration' }
GtInspectorTabSimpleSelector >> recentlySelectedTab: aTabName on: anObject [
	aTabName hasTabName ifFalse: [ ^ self ].
	self tabName: aTabName
]

{ #category : 'actions' }
GtInspectorTabSimpleSelector >> selectTabIn: aTabGroup on: anObect [
	aTabGroup viewModel tabs
		detect:
			[ :tabModel | 
				| aTitle |
				aTitle := tabModel widget phlow entity ifNotNil: #title.
				self tabName isEqualToString: aTitle asString ]
		ifFound: [ :tabModel | tabModel select ]
		ifNone: [ "do nothing" ]
]

{ #category : 'accessing' }
GtInspectorTabSimpleSelector >> tabName [
	<return: #GtInspectorTabName>
	^ tabName
]
