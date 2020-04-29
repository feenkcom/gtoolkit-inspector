Class {
	#name : #Gt2InspectorTabName,
	#superclass : #Gt2InspectorProtoTabName,
	#instVars : [
		'string'
	],
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #factory }
Gt2InspectorTabName class >> null [ 
	^ Gt2InspectorNullTabName default
]

{ #category : #testing }
Gt2InspectorTabName >> isEqualToString: aString [
	^ self string = aString
]

{ #category : #printing }
Gt2InspectorTabName >> printOn: aStream [
	aStream 
		nextPutAll: 'Tab name: ';
		print: self string
]

{ #category : #accessing }
Gt2InspectorTabName >> string [
	<return: #String>
	^ string
]

{ #category : #accessing }
Gt2InspectorTabName >> string: aString [
	self 
		assert: [ aString isString ] 
		description: [ 'Tab name must be a string' ].
	string := aString
]
