Class {
	#name : #GtInspectorListHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Inspector-Brick'
}

{ #category : #initialization }
GtInspectorListHandler >> initialize [
	super initialize.
	transformation := [ :x : indices | "by default there is no transformation" x ]
]

{ #category : #accessing }
GtInspectorListHandler >> transformation [
	^ transformation
]

{ #category : #accessing }
GtInspectorListHandler >> transformation: anObject [	
	transformation := anObject
]

{ #category : #accessing }
GtInspectorListHandler >> transformedValueFrom: anObject selection: aSelectionIndices [
	^ self transformation cull: anObject cull: aSelectionIndices
]
