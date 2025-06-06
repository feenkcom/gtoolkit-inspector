Class {
	#name : #GtReferencePathShortItem,
	#superclass : #GtReferencePathItem,
	#instVars : [
		'skipped',
		'name'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #'api - cleaning' }
GtReferencePathShortItem >> cleanOut [
	super cleanOut.
	skipped := nil
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
	^ aView forward
		title: 'Skipped items';
		object: [ skipped ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtReferencePathShortItem >> name [
	^ name ifNil: [ self object className ]
]

{ #category : #accessing }
GtReferencePathShortItem >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtReferencePathShortItem >> skipped [
	<return: #Collection of: #GtReferencedObject>
	^ skipped
]

{ #category : #accessing }
GtReferencePathShortItem >> skipped: anObject [
	skipped := anObject
]
