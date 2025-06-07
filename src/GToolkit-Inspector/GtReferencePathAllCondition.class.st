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
	conclusion ifFalse: [ ^ self ].
	shift := shift + 1.
	result := self computeCurrent: aBlock.
	result 
		ifFalse: [ shift := shift - 1 ] 
		ifTrue: [ self allFollowing: aBlock ]
]

{ #category : #'api - patterns' }
GtReferencePathAllCondition >> allFollowingSequences: aCollectionOfBlocks [
	"Include none or some following objects that satisfy the collection of conditions."

	| result lastShift |
	conclusion ifFalse: [ ^ self ].
	lastShift := shift.
	result := true.
	aCollectionOfBlocks
		do: [ :aBlock | 
			shift := shift + 1.
			result := result and: [ self computeCurrent: aBlock ] ].

	result
		ifFalse: [ shift := lastShift ]
		ifTrue: [ self allFollowingSequences: aCollectionOfBlocks ]
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
GtReferencePathAllCondition >> currentIndex [
	^ builder currentIndex
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> currentObject [
	^ builder currentObject
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
GtReferencePathAllCondition >> previousObject [
	^ self previousObject: 1
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> previousObject: anIndex [
	self
		assert: [ shift > 0 ]
		description: [ 'Shift must be greater than zero: {1}' format: {shift} ].
	self
		assert: [ shift - 1 >= 0 ]
		description: [ 'Cannot request object that precedes the current index: {1}'
				format: {shift - 1} ].

	^ builder followingObject: shift - anIndex
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> previousObject: anIndex is: aBlock [
	^ anIndex < shift
		ifTrue: [ aBlock value: (self previousObject: anIndex) ]
		ifFalse: [ self exploredIndex - anIndex > 0
				ifTrue: [ aBlock value: (builder specificObject: self exploredIndex - anIndex) ]
				ifFalse: [ false ] ]
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> previousObjectIs: aBlock [
	^ self previousObject: 1 is: aBlock
]

{ #category : #'api - accessing' }
GtReferencePathAllCondition >> shift [
	^ shift
]
