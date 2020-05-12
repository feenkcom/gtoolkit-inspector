Class {
	#name : #Gt2InspectorProtoModelExtension,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #notifications }
Gt2InspectorProtoModelExtension >> objectChangedTo: anObject [
	self subclassResponsibility
]

{ #category : #notifications }
Gt2InspectorProtoModelExtension >> objectRemoved [
	self subclassResponsibility
]
