Class {
	#name : #GtReferencePathAllCondition,
	#superclass : #Object,
	#instVars : [
		'builder',
		'shift',
		'conclusion',
		'item'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #'api - patterns' }
GtReferencePathAllCondition >> allFollowing: aBlock [
	"Include none or some following objects that satisfy the condition."

	| result |
	shift := shift + 1.
	result := self computeCurrent: aBlock.
	result 
		ifFalse: [ shift := shift - 1 ] 
		ifTrue: [ self allFollowing: aBlock ]
]

{ #category : #accessing }
GtReferencePathAllCondition >> builder [
	^ builder
]

{ #category : #accessing }
GtReferencePathAllCondition >> builder: aBuilder [
	builder := aBuilder.
	shift := 0.
	conclusion := true
]

{ #category : #'api - patterns' }
GtReferencePathAllCondition >> computeCurrent: aBlock [
	<return: #Boolean>
	^ self exploredIndex <= builder referencedObjects size
		and: [ aBlock cull: self exploredObject cull: self ]
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> conclusion [
	^ conclusion
]

{ #category : #'api - patterns' }
GtReferencePathAllCondition >> current: aBlock [
	conclusion := conclusion and: [ self computeCurrent: aBlock ]
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> exploredIndex [
	^ builder currentIndex + shift
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> exploredObject [
	^ builder followingObject: shift
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> exploredReferencedObject [
	^ builder followingReferencedObject: shift
]

{ #category : #'api - patterns' }
GtReferencePathAllCondition >> following: aBlock [
	shift := shift + 1.
	self current: aBlock
]

{ #category : #views }
GtReferencePathAllCondition >> gtItemFor: aView [
	<gtView>
	^ aView forward
		title: 'Item source code';
		object: [ item ];
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
GtReferencePathAllCondition >> item [
	^ item
]

{ #category : #accessing }
GtReferencePathAllCondition >> item: aBlock [
	"Set a block that returns a GtReferencePathItem instance. 
	The block has three arguments: [ :builder :current :all | ... ].
	The current is a current referenced object (GtReferencedObject kind of instance).
	The all are all covered referenced objects."

	item := aBlock
]

{ #category : #'api - patterns' }
GtReferencePathAllCondition >> peek: aBlock [
	"Check the following object condition, 
	but do not include the object in the result"

	self following: aBlock.
	shift := shift - 1
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> shift [
	^ shift
]
