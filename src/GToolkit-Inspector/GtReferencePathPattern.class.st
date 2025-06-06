Class {
	#name : #GtReferencePathPattern,
	#superclass : #Object,
	#instVars : [
		'condition',
		'skip',
		'item'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #accessing }
GtReferencePathPattern >> condition [
	^ condition
]

{ #category : #accessing }
GtReferencePathPattern >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
GtReferencePathPattern >> item [
	^ item
]

{ #category : #accessing }
GtReferencePathPattern >> item: anObject [
	item := anObject
]

{ #category : #accessing }
GtReferencePathPattern >> skip [
	^ skip
]

{ #category : #accessing }
GtReferencePathPattern >> skip: aBlock [
	"Set a block that returns an integer. 
	The block has one argument: [ :builder | 1 ].
	The integer value identifies how many objects are covered by the pattern"

	skip := aBlock
]
