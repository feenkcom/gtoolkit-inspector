Class {
	#name : #Gt2InspectorTabProtoSelector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #testing }
Gt2InspectorTabProtoSelector class >> isAbstract [
	^ self name = #Gt2InspectorTabProtoSelector 
]

{ #category : #configuration }
Gt2InspectorTabProtoSelector >> recentlySelectedTab: aInspectorTabName on: anObject [
	"Set recently selected tab name for a given object"
	self subclassResponsibility
]

{ #category : #actions }
Gt2InspectorTabProtoSelector >> selectTabIn: aTabGroup on: anObject [
	"Select tab of a given tab group"
	self subclassResponsibility
]
