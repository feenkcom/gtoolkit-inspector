Class {
	#name : #GtInspectorTabSelector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #factory }
GtInspectorTabSelector class >> byViewMethod [
	^ GtInspectorTabByViewMethodSelector new
]

{ #category : #factory }
GtInspectorTabSelector class >> byViewName [
	^ GtInspectorTabByViewNameSelector new
]

{ #category : #testing }
GtInspectorTabSelector class >> isAbstract [
	^ self name = #GtInspectorTabSelector 
]

{ #category : #configuration }
GtInspectorTabSelector >> recentlySelectedTab: aInspectorTabName on: anObject [
	"Set recently selected tab name for a given object"
	self subclassResponsibility
]

{ #category : #actions }
GtInspectorTabSelector >> selectTabIn: aTabGroup on: anObject [
	"Select tab of a given tab group"
	self subclassResponsibility
]
