Class {
	#name : #Gt2InspectorProtoObjectHolder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Object Holder'
}

{ #category : #testing }
Gt2InspectorProtoObjectHolder class >> isAbstract [ 
	^ self name = #Gt2InspectorProtoObjectHolder
]

{ #category : #accessing }
Gt2InspectorProtoObjectHolder >> object [
	"Return an inspecting object"
	^ self subclassResponsibility
]
