Class {
	#name : #GtInspectorAbstractObject,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'GToolkit-Inspector-Model'
}

{ #category : #testing }
GtInspectorAbstractObject class >> isAbstract [ 
	^ self name = #GtInspectorAbstractObject
]

{ #category : #converting }
GtInspectorAbstractObject >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self subclassResponsibility
]

{ #category : #notifying }
GtInspectorAbstractObject >> notifyObjectChangedIn: anInspector [
	"Notify about object changes"
	self subclassResponsibility
]

{ #category : #accessing }
GtInspectorAbstractObject >> object [
	"Return an inspecting object"
	^ self subclassResponsibility
]
