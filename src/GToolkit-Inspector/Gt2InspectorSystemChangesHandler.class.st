Class {
	#name : #Gt2InspectorSystemChangesHandler,
	#superclass : #Gt2InspectorExtension,
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #notifications }
Gt2InspectorSystemChangesHandler >> objectChangedTo: anObject [
	self flag: #todo
]

{ #category : #notifications }
Gt2InspectorSystemChangesHandler >> objectRemoved [
	self flag: #todo
]
