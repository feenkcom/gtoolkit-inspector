Class {
	#name : #Gt2InspectorSelectedTabProtoExtractor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #'api - actions' }
Gt2InspectorSelectedTabProtoExtractor >> extract [
	"Extract a selected inspector tab name"
	<return: #Gt2InspectorTabName>
]

{ #category : #accessing }
Gt2InspectorSelectedTabProtoExtractor >> inspectorElement: aGtInspector [
	self subclassResponsibility
]
