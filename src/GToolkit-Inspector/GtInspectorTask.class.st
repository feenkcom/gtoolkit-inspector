Class {
	#name : #GtInspectorTask,
	#superclass : #GtTaskerTask,
	#traits : 'TGtInspectorPageModelChecker',
	#classTraits : 'TGtInspectorPageModelChecker classTrait',
	#instVars : [
		'inspectorInstance'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #accessing }
GtInspectorTask >> inspectorInstance [
	^ inspectorInstance
]

{ #category : #accessing }
GtInspectorTask >> inspectorInstance: anObject [
	inspectorInstance := anObject
]
