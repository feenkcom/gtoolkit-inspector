"
I am sent when a selected element appears on the screen
"
Class {
	#name : #GtInspectorSelectedObjectAppeared,
	#superclass : #BlEvent,
	#instVars : [
		'selectedObject',
		'selectedElement'
	],
	#category : 'GToolkit-Inspector'
}

{ #category : #accessing }
GtInspectorSelectedObjectAppeared >> selectedElement [
	^ selectedElement
]

{ #category : #accessing }
GtInspectorSelectedObjectAppeared >> selectedElement: anObject [
	selectedElement := anObject
]

{ #category : #accessing }
GtInspectorSelectedObjectAppeared >> selectedObject [
	^ selectedObject
]

{ #category : #accessing }
GtInspectorSelectedObjectAppeared >> selectedObject: anObject [
	selectedObject := anObject
]
