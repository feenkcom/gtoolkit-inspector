Class {
	#name : #Gt2InspectorProtoModelExtensions,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #notifications }
Gt2InspectorProtoModelExtensions >> objectChangedTo: anObject [
	self subclassResponsibility
]

{ #category : #notifications }
Gt2InspectorProtoModelExtensions >> objectRemoved [
	self subclassResponsibility
]
