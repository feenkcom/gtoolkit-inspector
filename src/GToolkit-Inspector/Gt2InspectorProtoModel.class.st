Class {
	#name : #Gt2InspectorProtoModel,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #converting }
Gt2InspectorProtoModel >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self subclassResponsibility
]
