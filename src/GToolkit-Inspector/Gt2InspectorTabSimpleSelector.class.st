Class {
	#name : #Gt2InspectorTabSimpleSelector,
	#superclass : #Gt2InspectorTabSelector,
	#traits : 'TGt2InspectorTabNameAccessor',
	#classTraits : 'TGt2InspectorTabNameAccessor classTrait',
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #initialization }
Gt2InspectorTabSimpleSelector >> initialize [
	super initialize.
	self initializeTabName.
]

{ #category : #printing }
Gt2InspectorTabSimpleSelector >> printOn: aStream [
	aStream 
		nextPutAll: 'Selector of: ';
		print: self tabName
]

{ #category : #configuration }
Gt2InspectorTabSimpleSelector >> recentlySelectedTab: aTabName on: anObject [
	self tabName: aTabName
]

{ #category : #actions }
Gt2InspectorTabSimpleSelector >> selectTabIn: aTabGroup on: anObect [
	aTabGroup viewModel tabs
		detect:
			[ :tabModel | 
				| aTitle |
				aTitle := tabModel widget phlow entity ifNotNil: #title.
				self tabName isEqualToString: aTitle asString ]
		ifFound: [ :tabModel | tabModel select ]
		ifNone: [ "do nothing" ]
]
