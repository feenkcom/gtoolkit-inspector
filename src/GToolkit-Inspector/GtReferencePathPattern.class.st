Class {
	#name : #GtReferencePathPattern,
	#superclass : #Object,
	#instVars : [
		'condition',
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
	"Set a block that returns a GtReferencePathAllCondition instance. 
	The block has one argument: [ :builder | true ].
	The return object indicates whether this pattern covers current path (from a current index)."

	condition := aBlock
]

{ #category : #accessing }
GtReferencePathPattern >> item [
	^ item
]

{ #category : #accessing }
GtReferencePathPattern >> item: aBlock [
	"Set a block that returns a GtReferencePathItem instance. 
	The block has three arguments: [ :builder :current :all | ... ].
	The current is a current referenced object (GtReferencedObject kind of instance).
	The all are all covered referenced objects."

	item := aBlock
]
