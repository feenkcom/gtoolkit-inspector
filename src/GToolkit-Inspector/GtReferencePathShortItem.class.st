Class {
	#name : #GtReferencePathShortItem,
	#superclass : #GtReferencePathItem,
	#instVars : [
		'name',
		'all'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #accessing }
GtReferencePathShortItem >> all [
	"Return all referenced objects that are covered by this item"

	<return: #Collection of: #GtReferencedObject>
	^ all
]

{ #category : #accessing }
GtReferencePathShortItem >> all: aCollectionOfGtReferencedObject [
	"Set all referenced objects that are covered by this item"

	all := aCollectionOfGtReferencedObject
]

{ #category : #'api - accessing' }
GtReferencePathShortItem >> allReferencedObjects [
	^ self all
]

{ #category : #cleaning }
GtReferencePathShortItem >> cleanOut [
	super cleanOut.
	all := nil
]

{ #category : #printing }
GtReferencePathShortItem >> gtDisplayOn: stream [
	name
		ifNotNil: [ stream nextPutAll: name asString ]
		ifNil: [ self object gtDisplayOn: stream ]
]

{ #category : #views }
GtReferencePathShortItem >> gtSkippedFor: aView [
	<gtView>
	^ aView columnedList
		title: 'All objects';
		items: [ all ifNil: [ #() ] ];
		column: 'Referenced object'
			text: [ :each | each object == self object ifTrue: [ each gtDisplayText bold ] ifFalse: [ each ] ];
		send: #object;
		contextItemLabel: 'Spawn object'
			action: [ :element :item | element phlow spawnObject: item object ];
		contextItemLabel: 'Spawn reference path item'
			action: [ :element :item | element phlow spawnObject: item ]
]

{ #category : #accessing }
GtReferencePathShortItem >> name [
	^ name ifNil: [ self object className ]
]

{ #category : #accessing }
GtReferencePathShortItem >> name: anObject [
	name := anObject
]
