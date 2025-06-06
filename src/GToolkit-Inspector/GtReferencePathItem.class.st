Class {
	#name : #GtReferencePathItem,
	#superclass : #Object,
	#instVars : [
		'referencedObject'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #accessing }
GtReferencePathItem class >> cleanOut [
	GtReferencePathItem allSubInstancesDo: #cleanOut
]

{ #category : #'api - cleaning' }
GtReferencePathItem >> cleanOut [
	referencedObject := nil
]

{ #category : #'api - accessing' }
GtReferencePathItem >> name [
	<return: #String>
	^ self object className
]

{ #category : #'api - accessing' }
GtReferencePathItem >> object [
	^ referencedObject object
]

{ #category : #'api - accessing' }
GtReferencePathItem >> referenceTypeName [
	^ referencedObject referenceTypeName
]

{ #category : #accessing }
GtReferencePathItem >> referencedObject [
	<return: #GtReferencedObject>
	^ referencedObject
]

{ #category : #accessing }
GtReferencePathItem >> referencedObject: aReferencedObject [
	referencedObject := aReferencedObject
]
