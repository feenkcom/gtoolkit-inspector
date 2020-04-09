Class {
	#name : #GtInspectorTask,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtInspectorPageModelChecker',
	#classTraits : 'TBlDebug classTrait + TGtInspectorPageModelChecker classTrait',
	#instVars : [
		'inspectorInstance'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #testing }
GtInspectorTask class >> isAbstract [
	^ self name = #GtInspectorTask 
]

{ #category : #accessing }
GtInspectorTask >> entryIdentifier [
	^ self
]

{ #category : #execution }
GtInspectorTask >> execute [
	self subclassResponsibility
]

{ #category : #accessing }
GtInspectorTask >> inspectorInstance [
	^ inspectorInstance
]

{ #category : #accessing }
GtInspectorTask >> inspectorInstance: anObject [
	inspectorInstance := anObject
]
