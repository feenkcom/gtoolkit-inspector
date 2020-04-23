Class {
	#name : #Gt2InspectorObjectHolder,
	#superclass : #Gt2InspectorProtoObjectHolder,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Inspector-! New - Object Holder'
}

{ #category : #factory }
Gt2InspectorObjectHolder class >> null [ 
	^ Gt2InspectorNullObjectHolder default
]

{ #category : #accessing }
Gt2InspectorObjectHolder >> object [
	^ object
]

{ #category : #accessing }
Gt2InspectorObjectHolder >> object: anObject [
	object := anObject
]

{ #category : #printing }
Gt2InspectorObjectHolder >> printOn: aStream [
	aStream 
		nextPutAll: 'Holder of ';
		print: self object
]
