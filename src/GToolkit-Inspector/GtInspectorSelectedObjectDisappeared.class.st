"
I am sent when a selected element disappears from the screen
"
Class {
	#name : #GtInspectorSelectedObjectDisappeared,
	#superclass : #BlEvent,
	#instVars : [
		'selectedObject',
		'selectedElement'
	],
	#category : #'GToolkit-Inspector-Brick'
}

{ #category : #accessing }
GtInspectorSelectedObjectDisappeared >> selectedElement [
	^ selectedElement
]

{ #category : #accessing }
GtInspectorSelectedObjectDisappeared >> selectedElement: anObject [
	selectedElement := anObject
]

{ #category : #accessing }
GtInspectorSelectedObjectDisappeared >> selectedObject [
	^ selectedObject
]

{ #category : #accessing }
GtInspectorSelectedObjectDisappeared >> selectedObject: anObject [
	selectedObject := anObject
]
