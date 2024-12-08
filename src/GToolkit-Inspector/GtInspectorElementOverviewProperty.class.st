"
I am used to display other {{gtClass:BlElement}} properties using {{gtClass:GtInspectorElementOverview}}. 

"
Class {
	#name : #GtInspectorElementOverviewProperty,
	#superclass : #Object,
	#instVars : [
		'label',
		'definingMethod',
		'spawnActionBlock'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #accessing }
GtInspectorElementOverviewProperty >> definingMethod [
	<return: #RGMethodDefinition>
	^ definingMethod
]

{ #category : #accessing }
GtInspectorElementOverviewProperty >> definingMethod: aCompiledMethod [
	definingMethod := aCompiledMethod asRingDefinition
]

{ #category : #accessing }
GtInspectorElementOverviewProperty >> label [
	^ label
]

{ #category : #accessing }
GtInspectorElementOverviewProperty >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtInspectorElementOverviewProperty >> object: anObjectStencil [
	self spawnActionBlock: [ :anElement |
		| anObject |
		anObject := anObjectStencil asStencil create. 
		anElement phlow spawnObject: anObject ]
]

{ #category : #accessing }
GtInspectorElementOverviewProperty >> spawnActionBlock [
	"Return a block in a form of [ :anElement | ... ].
	Evaluation of the block should call a spawn action, e.g., 
	[ :anElement | anElement phlow spawnObject: ... ]"

	<return: #BlockClosure>
	^ spawnActionBlock
]

{ #category : #accessing }
GtInspectorElementOverviewProperty >> spawnActionBlock: aOneArgBlock [
	"Set a block in a form of [ :anElement | ... ].
	Evaluation of the block should call a spawn action, e.g., 
	[ :anElement | anElement phlow spawnObject: ... ]"

	spawnActionBlock := aOneArgBlock
]
