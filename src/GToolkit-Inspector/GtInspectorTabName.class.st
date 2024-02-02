Class {
	#name : #GtInspectorTabName,
	#superclass : #GtInspectorTabIdentifier,
	#instVars : [
		'string'
	],
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #factory }
GtInspectorTabName class >> null [ 
	^ GtInspectorNullTabIdentifier default
]

{ #category : #actions }
GtInspectorTabName >> applySelectionTo: anInspectorElement [
	(GtInspectorTabSelector byViewName
		tabName: self)
			selectTabInInspectorElement: anInspectorElement on: nil
]

{ #category : #printing }
GtInspectorTabName >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn:  aStream ]
]

{ #category : #printing }
GtInspectorTabName >> descriptionOn: aStream [

	aStream 
		nextPutAll: 'Tab name: ';
		print: self string 
]

{ #category : #testing }
GtInspectorTabName >> isEqualToString: aString [
	^ self string = aString
]

{ #category : #testing }
GtInspectorTabName >> matchesTab: aTabModel [
	| currentTabTitle |
	currentTabTitle := aTabModel widget phlow entity ifNotNil: #title.
	^ self isEqualToString: currentTabTitle asString
]

{ #category : #printing }
GtInspectorTabName >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< self string ]
]

{ #category : #accessing }
GtInspectorTabName >> string [
	<return: #String>
	^ string
]

{ #category : #accessing }
GtInspectorTabName >> string: aString [
	self 
		assert: [ aString isString ] 
		description: [ 'Tab name must be a string' ].
	string := aString
]
