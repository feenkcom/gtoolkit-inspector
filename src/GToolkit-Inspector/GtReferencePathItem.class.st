Class {
	#name : #GtReferencePathItem,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #accessing }
GtReferencePathItem class >> cleanOut [
	GtReferencePathItem allSubInstancesDo: #cleanOut
]

{ #category : #'api - cleaning' }
GtReferencePathItem >> cleanOut [
	object := nil
]

{ #category : #'api - accessing' }
GtReferencePathItem >> name [
	<return: #String>
	^ self object className
]

{ #category : #accessing }
GtReferencePathItem >> object [
	^ object
]

{ #category : #accessing }
GtReferencePathItem >> object: anObject [
	object := anObject
]
