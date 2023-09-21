Class {
	#name : #GtInspectorTabName,
	#superclass : #GtInspectorAbstractTabName,
	#instVars : [
		'string'
	],
	#category : 'GToolkit-Inspector-Tab Selector'
}

{ #category : #factory }
GtInspectorTabName class >> null [ 
	^ GtInspectorNullTabName default
]

{ #category : #testing }
GtInspectorTabName >> isEqualToString: aString [
	^ self string = aString
]

{ #category : #printing }
GtInspectorTabName >> printOn: aStream [
	aStream 
		nextPutAll: 'Tab name: ';
		print: self string
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
