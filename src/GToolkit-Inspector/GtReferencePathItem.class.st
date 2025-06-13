Class {
	#name : #GtReferencePathItem,
	#superclass : #Object,
	#instVars : [
		'referencedObject',
		'referenceTypeName'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #cleaning }
GtReferencePathItem class >> cleanOut [
	GtReferencePathItem allSubInstancesDo: #cleanOut
]

{ #category : #'api - accessing' }
GtReferencePathItem >> allReferencedObjects [
	<return: #Collection of: #GtReferencedObject>
	^ Array with: self referencedObject
]

{ #category : #cleaning }
GtReferencePathItem >> cleanOut [
	referencedObject ifNotNil: [ :anObject | anObject object: nil ].
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
	<return: #String>
	^ referenceTypeName
		ifNil: [ referencedObject referenceTypeName ]
		ifNotNil: [ referenceTypeName value asString ]
]

{ #category : #accessing }
GtReferencePathItem >> referenceTypeName: aStringOrBlock [
	referenceTypeName := aStringOrBlock
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
