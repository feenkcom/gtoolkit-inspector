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
GtReferencePathPattern >> condition: aBlock [
	"Set a block that returns a boolean. 
	The block has one argument: [ :builder | true ].
	The return value indicates whether this pattern covers current path (from a current index)."

	condition := aBlock
]

{ #category : #accessing }
GtReferencePathPattern >> item [
	^ item
]

{ #category : #accessing }
GtReferencePathPattern >> item: aBlock [
	"Set a block that returns a GtReferencePathItem instance. 
	The block has three arguments: [ :builder :current :rest | ... ].
	The current is a current referenced object (GtReferencedObject kind of instance).
	The rest are other skipped referenced objects."

	item := aBlock
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
