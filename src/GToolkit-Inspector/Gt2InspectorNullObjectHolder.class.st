Class {
	#name : #Gt2InspectorNullObjectHolder,
	#superclass : #Gt2InspectorProtoObjectHolder,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Inspector-! New - Object Holder'
}

{ #category : #accessing }
Gt2InspectorNullObjectHolder >> object [
	"Return an inspecting object"
	^ nil
]

{ #category : #printing }
Gt2InspectorNullObjectHolder >> printOn: aStream [ 
	aStream nextPutAll: 'Null Object Holder'
]
