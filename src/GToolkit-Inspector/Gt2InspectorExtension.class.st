Class {
	#name : #Gt2InspectorExtension,
	#superclass : #Gt2InspectorProtoModelExtension,
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #testing }
Gt2InspectorExtension class >> isAbstract [
	^ self name = #Gt2InspectorExtension 
]

{ #category : #'instance creation' }
Gt2InspectorExtension class >> newExtension [
	"Subclasses can define how to instantiate a new extension"
	^ self new
]

{ #category : #factory }
Gt2InspectorExtension class >> null [
	^ Gt2InspectorNullExtension default
]
