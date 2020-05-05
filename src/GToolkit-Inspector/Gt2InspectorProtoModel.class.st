Class {
	#name : #Gt2InspectorProtoModel,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #converting }
Gt2InspectorProtoModel >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self subclassResponsibility
]
