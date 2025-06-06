Class {
	#name : #GtReferencePathObjectItem,
	#superclass : #GtReferencePathItem,
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #'instance creation' }
GtReferencePathObjectItem class >> objects: aCollectionOfObjects [
	^ aCollectionOfObjects collect: [ :each | self new object: each ]
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
