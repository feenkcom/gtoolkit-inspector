Class {
	#name : #Gt2InspectorViewSelector,
	#superclass : #Gt2InspectorProtoViewSelector,
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #factory }
Gt2InspectorViewSelector class >> last [
	^ Gt2InspectorLastViewSelector new
]

{ #category : #factory }
Gt2InspectorViewSelector class >> null [
	^ Gt2InspectorNullViewSelector default
]
