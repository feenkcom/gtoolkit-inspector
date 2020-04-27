Class {
	#name : #Gt2InspectorProtoObjectHolder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #testing }
Gt2InspectorProtoObjectHolder class >> isAbstract [ 
	^ self name = #Gt2InspectorProtoObjectHolder
]

{ #category : #converting }
Gt2InspectorProtoObjectHolder >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self subclassResponsibility
]

{ #category : #accessing }
Gt2InspectorProtoObjectHolder >> object [
	"Return an inspecting object"
	^ self subclassResponsibility
]
