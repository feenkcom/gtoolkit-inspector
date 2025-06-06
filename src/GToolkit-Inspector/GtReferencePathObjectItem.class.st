Class {
	#name : #GtReferencePathObjectItem,
	#superclass : #GtReferencePathItem,
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #'instance creation' }
GtReferencePathObjectItem class >> referencedObjects: aCollectionOfObjects [
	^ aCollectionOfObjects collect: [ :each | self new referencedObject: each ]
]

{ #category : #printing }
GtReferencePathObjectItem >> gtDisplayOn: stream [
	self object gtDisplayOn: stream
]

{ #category : #'api - accessing' }
GtReferencePathObjectItem >> name [
	<return: #String>
	^ self object className
]
