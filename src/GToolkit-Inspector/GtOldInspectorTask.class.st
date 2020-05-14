Class {
	#name : #GtOldInspectorTask,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtInspectorPageModelChecker',
	#classTraits : 'TBlDebug classTrait + TGtInspectorPageModelChecker classTrait',
	#instVars : [
		'inspectorInstance'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #testing }
GtOldInspectorTask class >> isAbstract [
	^ self name = #GtOldInspectorTask 
]

{ #category : #converting }
GtOldInspectorTask >> asBlTktCommand [ 
	^ BlTktWrapperCommand new command: self
]

{ #category : #accessing }
GtOldInspectorTask >> entryIdentifier [
	^ self
]

{ #category : #execution }
GtOldInspectorTask >> execute [
	self subclassResponsibility
]

{ #category : #accessing }
GtOldInspectorTask >> inspectorInstance [
	^ inspectorInstance
]

{ #category : #accessing }
GtOldInspectorTask >> inspectorInstance: anObject [
	inspectorInstance := anObject
]
