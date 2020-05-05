Class {
	#name : #Gt2InspectorNullTabName,
	#superclass : #Gt2InspectorProtoTabName,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #testing }
Gt2InspectorNullTabName >> isEqualToString: aString [
	^ false
]

{ #category : #printing }
Gt2InspectorNullTabName >> printOn: aStream [
	aStream nextPutAll: 'Without tab name'
]
