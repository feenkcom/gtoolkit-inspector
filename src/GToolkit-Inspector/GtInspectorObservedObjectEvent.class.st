Class {
	#name : #GtInspectorObservedObjectEvent,
	#superclass : #BlEvent,
	#instVars : [
		'observedObject'
	],
	#category : #'GToolkit-Inspector-Brick'
}

{ #category : #accessing }
GtInspectorObservedObjectEvent >> observedObject [
	^ observedObject
]

{ #category : #accessing }
GtInspectorObservedObjectEvent >> observedObject: anObject [
	observedObject := anObject
]
